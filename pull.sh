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

pull_image public.ecr.aws/awslabs-mcp/awslabs/aws-documentation-mcp-server:latest
pull_image public.ecr.aws/awslabs-mcp/awslabs/aws-api-mcp-server:latest
pull_image public.ecr.aws/awslabs-mcp/awslabs/cost-analysis-mcp-server:latest
pull_image public.ecr.aws/awslabs-mcp/awslabs/amazon-neptune-mcp-server:latest
pull_image public.ecr.aws/awslabs-mcp/awslabs/eks-mcp-server:latest
pull_image public.ecr.aws/awslabs-mcp/awslabs/cost-explorer-mcp-server:latest
pull_image public.ecr.aws/awslabs-mcp/awslabs/aws-pricing-mcp-server:latest
pull_image public.ecr.aws/awslabs-mcp/awslabs/cloudwatch-mcp-server:latest
pull_image public.ecr.aws/awslabs-mcp/awslabs/terraform-mcp-server:latest
pull_image public.ecr.aws/awslabs-mcp/awslabs/core-mcp-server:latest
pull_image public.ecr.aws/awslabs-mcp/awslabs/dynamodb-mcp-server:latest
pull_image public.ecr.aws/awslabs-mcp/awslabs/postgres-mcp-server:latest
pull_image public.ecr.aws/awslabs-mcp/awslabs/billing-cost-management-mcp-server:latest
pull_image public.ecr.aws/awslabs-mcp/awslabs/aws-diagram-mcp-server:latest
pull_image public.ecr.aws/awslabs-mcp/awslabs/bedrock-kb-retrieval-mcp-server:latest
pull_image public.ecr.aws/awslabs-mcp/awslabs/aws-healthomics-mcp-server:latest
pull_image public.ecr.aws/awslabs-mcp/awslabs/ccapi-mcp-server:latest
pull_image public.ecr.aws/awslabs-mcp/awslabs/aurora-dsql-mcp-server:latest
pull_image public.ecr.aws/awslabs-mcp/awslabs/amazon-sns-sqs-mcp-server:latest
pull_image public.ecr.aws/awslabs-mcp/awslabs/aws-dataprocessing-mcp-server:latest
pull_image public.ecr.aws/awslabs-mcp/awslabs/redshift-mcp-server:latest
pull_image public.ecr.aws/awslabs-mcp/awslabs/amazon-mq-mcp-server:latest
pull_image public.ecr.aws/awslabs-mcp/awslabs/s3-tables-mcp-server:latest
pull_image public.ecr.aws/awslabs-mcp/awslabs/elasticache-mcp-server:latest
pull_image public.ecr.aws/awslabs-mcp/awslabs/cfn-mcp-server:latest
pull_image public.ecr.aws/awslabs-mcp/awslabs/mysql-mcp-server:latest
pull_image public.ecr.aws/awslabs-mcp/awslabs/memcached-mcp-server:latest
pull_image public.ecr.aws/awslabs-mcp/awslabs/valkey-mcp-server:latest
pull_image public.ecr.aws/awslabs-mcp/awslabs/cloudwatch-applicationsignals-mcp-server:latest
pull_image public.ecr.aws/awslabs-mcp/awslabs/amazon-bedrock-agentcore-mcp-server:latest
pull_image public.ecr.aws/awslabs-mcp/awslabs/amazon-kendra-index-mcp-server:latest
pull_image public.ecr.aws/awslabs-mcp/awslabs/aws-location-mcp-server:latest
pull_image public.ecr.aws/awslabs-mcp/awslabs/lambda-tool-mcp-server:latest
pull_image public.ecr.aws/awslabs-mcp/awslabs/iam-mcp-server:latest
pull_image public.ecr.aws/awslabs-mcp/awslabs/stepfunctions-tool-mcp-server:latest
pull_image public.ecr.aws/awslabs-mcp/awslabs/cloudwatch-appsignals-mcp-server:latest
pull_image public.ecr.aws/awslabs-mcp/awslabs/openapi-mcp-server:latest
pull_image public.ecr.aws/awslabs-mcp/awslabs/aws-iot-sitewise-mcp-server:latest
pull_image public.ecr.aws/awslabs-mcp/awslabs/aws-iac-mcp-server:latest
pull_image public.ecr.aws/awslabs-mcp/awslabs/prometheus-mcp-server:latest
pull_image public.ecr.aws/awslabs-mcp/awslabs/nova-canvas-mcp-server:latest
pull_image public.ecr.aws/awslabs-mcp/awslabs/aws-bedrock-data-automation-mcp-server:latest
pull_image public.ecr.aws/awslabs-mcp/awslabs/cdk-mcp-server:latest
pull_image public.ecr.aws/awslabs-mcp/awslabs/timestream-for-influxdb-mcp-server:latest
pull_image public.ecr.aws/awslabs-mcp/awslabs/cloudtrail-mcp-server:latest
pull_image public.ecr.aws/awslabs-mcp/awslabs/aws-msk-mcp-server:latest
pull_image public.ecr.aws/awslabs-mcp/awslabs/amazon-qbusiness-anonymous-mcp-server:latest
pull_image public.ecr.aws/awslabs-mcp/awslabs/aws-bedrock-custom-model-import-mcp-server:latest
pull_image public.ecr.aws/awslabs-mcp/awslabs/document-loader-mcp-server:latest
pull_image public.ecr.aws/awslabs-mcp/awslabs/healthlake-mcp-server:latest
pull_image public.ecr.aws/awslabs-mcp/awslabs/aws-appsync-mcp-server:latest
pull_image public.ecr.aws/awslabs-mcp/awslabs/aws-network-mcp-server:latest
pull_image public.ecr.aws/awslabs-mcp/awslabs/cloudwatch-logs-mcp-server:latest
pull_image public.ecr.aws/awslabs-mcp/awslabs/amazon-rekognition-mcp-server:latest
pull_image public.ecr.aws/awslabs-mcp/awslabs/lambda-mcp-server:latest
pull_image public.ecr.aws/awslabs-mcp/awslabs/healthimaging-mcp-server:latest
pull_image public.ecr.aws/awslabs-mcp/awslabs/aws-for-sap-management-mcp-server:latest
pull_image public.ecr.aws/awslabs-mcp/awslabs/amazon-translate-mcp-server:latest
pull_image public.ecr.aws/awslabs-mcp/awslabs/security-agent-mcp-server:latest
pull_image public.ecr.aws/awslabs-mcp/awslabs/mssql-mcp-server:latest
pull_image public.ecr.aws/awslabs-mcp/awslabs/oracle-mcp-server:latest
pull_image public.ecr.aws/awslabs-mcp/awslabs/well-architected-security-mcp-server:latest
pull_image public.ecr.aws/awslabs-mcp/awslabs/aws-support-mcp-server:latest
pull_image public.ecr.aws/awslabs-mcp/awslabs/sagemaker-ai-mcp-server:latest
pull_image public.ecr.aws/awslabs-mcp/awslabs/git-repo-research-mcp-server:latest
pull_image public.ecr.aws/awslabs-mcp/awslabs/amazon-keyspaces-mcp-server:latest
pull_image public.ecr.aws/awslabs-mcp/awslabs/aws-appsynce-mcp-server:latest
pull_image public.ecr.aws/awslabs-mcp/awslabs/sagemaker-hyperpod-mcp-server:latest
pull_image public.ecr.aws/awslabs-mcp/awslabs/roda-mcp-server:latest
pull_image public.ecr.aws/awslabs-mcp/awslabs/db2-mcp-server:latest
