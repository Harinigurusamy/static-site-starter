#!/usr/bin/env bash
# Usage: ./deploy-s3.sh your-bucket-name
set -euo pipefail

if ! command -v aws >/dev/null 2>&1; then
  echo "Please install AWS CLI: https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html"
  exit 1
fi

if [ -z "${1:-}" ]; then
  echo "Bucket name required. Example: ./deploy-s3.sh my-portfolio-site"
  exit 1
fi

BUCKET="$1"

echo "Syncing files to s3://$BUCKET ..."
aws s3 sync . "s3://$BUCKET"   --exclude ".git/*" --exclude ".gitignore" --exclude "deploy-s3.sh"   --delete

echo "Deployed to s3://$BUCKET"
