#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
WORKFLOWS_DIR="$ROOT_DIR/workflows"

if [[ ! -d "$WORKFLOWS_DIR" ]]; then
  echo "ERROR: workflows directory not found: $WORKFLOWS_DIR"
  exit 1
fi

if ! command -v jq >/dev/null 2>&1; then
  echo "ERROR: jq is required to validate workflow JSON files."
  exit 1
fi

errors=0

echo "Validating workflow JSON schema basics..."
for file in "$WORKFLOWS_DIR"/*.json; do
  [[ -e "$file" ]] || continue

  if ! jq -e '.name and .nodes and .connections' "$file" >/dev/null; then
    echo "ERROR: $file is missing required n8n workflow fields (.name/.nodes/.connections)."
    errors=$((errors + 1))
  fi

  if ! jq -e '.nodes | type == "array"' "$file" >/dev/null; then
    echo "ERROR: $file has invalid .nodes value (expected array)."
    errors=$((errors + 1))
  fi

  if ! jq -e '.connections | type == "object"' "$file" >/dev/null; then
    echo "ERROR: $file has invalid .connections value (expected object)."
    errors=$((errors + 1))
  fi
done

echo "Scanning workflow files for non-portable hardcoded values..."
for file in "$WORKFLOWS_DIR"/*.json; do
  [[ -e "$file" ]] || continue
  content="$(<"$file")"

  if [[ "$content" =~ https://[A-Za-z0-9.-]+\.atlassian\.net ]]; then
    echo "ERROR: $file includes hardcoded Jira tenant URL(s)."
    errors=$((errors + 1))
  fi

  if [[ "$content" =~ \"value\"[[:space:]]*:[[:space:]]*\"=?C[A-Z0-9]{8,}\" ]]; then
    echo "ERROR: $file includes hardcoded Slack channel ID(s)."
    errors=$((errors + 1))
  fi
done

if [[ "$errors" -gt 0 ]]; then
  echo
  echo "Validation failed with $errors error(s)."
  exit 1
fi

echo "Workflow validation passed."
