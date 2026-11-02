# AWS Labs MCP Image Pulls

## Generate

Requires Bash, `curl`, and `jq`. On macOS, install jq with `brew install jq`.

```bash
./generate-pull.sh
```

The ECR gallery serves a JavaScript-only HTML shell, so `curl` plus `htmlq`
cannot extract its rendered repository links or pagination. The generator
instead calls the gallery's public `describeRepositoryCatalogData` endpoint,
requests 20 repositories per page, and follows continuation tokens until done.
It does not require AWS credentials. This is the website's API, not a documented
AWS service API, so future gallery changes may require updating the generator.

Each page's gallery URLs are saved as a JSON array in `pages/page-N.json`.
The generator reads those arrays, removes duplicate URLs, and writes an
executable `pull.sh`. Fetching and validation finish before existing output
files are replaced. Generated page files beyond the new final page are removed.
All output paths are relative to the generator, not the current directory.

## Pull

Requires Docker with a running daemon.

```bash
./pull.sh
./pull.sh --force-update
```

By default, images with the exact `:latest` tag already present locally are
skipped. `--force-update` pulls every image, even if it is already present.
Generation only collects links and writes files; it does not pull images.