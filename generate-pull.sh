#!/usr/bin/env bash

set -euo pipefail

for dependency in curl jq; do
	if ! command -v "$dependency" >/dev/null 2>&1; then
		printf 'Missing dependency: %s\n' "$dependency" >&2
		exit 1
	fi
done

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
data_dir="$script_dir/pages"
work_dir="$(mktemp -d "$script_dir/.generate-pull.XXXXXX")"
trap 'rm -rf -- "$work_dir"' EXIT

api_url='https://api.us-east-1.gallery.ecr.aws/describeRepositoryCatalogData'
next_token=''
seen_tokens='[]'
page=1
page_files=()

while :; do
	request="$(jq -n --arg token "$next_token" '
		{registryAliasName: "awslabs-mcp", maxResults: 20}
		+ (if $token == "" then {} else {nextToken: $token} end)
	')"
	printf 'Fetching gallery page %s...\n' "$page"
	response="$(curl --fail --silent --show-error --location \
		--connect-timeout 15 --max-time 120 --retry 3 \
		--header 'Content-Type: application/json' --data "$request" "$api_url")"
	if ! jq -e '
		(.repositories | type == "array" and length > 0)
		and all(.repositories[]; .repositoryName | type == "string"
			and test("^awslabs/[a-z0-9._/-]+$"))
		and (.nextToken == null or (.nextToken | type == "string"))
	' <<< "$response" >/dev/null; then
		printf 'Invalid or empty gallery response for page %s\n' "$page" >&2
		exit 1
	fi

	page_file="$work_dir/page-$page.json"
	jq '[.repositories[].repositoryName | "https://gallery.ecr.aws/awslabs-mcp/" + .]' \
		<<< "$response" > "$page_file"
	page_files+=("$page_file")
	next_token="$(jq -r '.nextToken // ""' <<< "$response")"
	[[ -n "$next_token" ]] || break
	if jq -e --arg token "$next_token" 'index($token) != null' <<< "$seen_tokens" >/dev/null; then
		printf 'Gallery returned a repeated pagination token\n' >&2
		exit 1
	fi
	seen_tokens="$(jq --arg token "$next_token" '. + [$token]' <<< "$seen_tokens")"
	page=$((page + 1))
done

jq -sr '
	add | reduce .[] as $url ([]; if index($url) then . else . + [$url] end) | .[]
' "${page_files[@]}" > "$work_dir/urls.txt"

{
	cat <<'HEADER'
#!/usr/bin/env bash

force_update=false
while [[ $# -gt 0 ]]; do
	case "$1" in
		--force-update) force_update=true ;;
		-h|--help)
			printf 'Usage: %s [--force-update]\n' "$0"
			exit 0
			;;
		*)
			printf 'Unknown argument: %s\n' "$1" >&2
			exit 2
			;;
	esac
	shift
done

pull_image() {
	local image="$1"
	if [[ "$force_update" == false ]] && docker image inspect "$image" >/dev/null 2>&1; then
		printf 'Skipping existing image: %s\n' "$image"
	else
		docker pull "$image"
	fi
}

HEADER
	while IFS= read -r url; do
		printf 'pull_image public.ecr.aws/%s:latest\n' "${url#https://gallery.ecr.aws/}"
	done < "$work_dir/urls.txt"
} > "$work_dir/pull.sh"

bash -n "$work_dir/pull.sh"
chmod +x "$work_dir/pull.sh"
mkdir -p "$data_dir"
for page_file in "${page_files[@]}"; do
	mv -- "$page_file" "$data_dir/"
done
for page_file in "$data_dir"/page-*.json; do
	filename="${page_file##*/}"
	if [[ "$filename" =~ ^page-([0-9]+)\.json$ ]] && (( 10#${BASH_REMATCH[1]} > page )); then
		rm -- "$page_file"
	fi
done
mv -- "$work_dir/pull.sh" "$script_dir/pull.sh"
printf 'Generated pull.sh from %s pages (%s images).\n' "$page" "$(wc -l < "$work_dir/urls.txt" | tr -d ' ')"
