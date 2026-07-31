# n8n Jira-Slack Integration

Production-oriented n8n workflows that connect Slack slash commands with Jira actions, including AI-assisted issue creation and sprint visibility.

## Why This Repo

- Turn Slack into an operational control plane for Jira.
- Reduce context-switching for day-to-day project management.
- Keep workflows modular so teams can import only what they need.

## Included Workflows

### `jira-status-updater.json`

Updates Jira issue status from Slack command input.

- **Webhook path:** `/update-status`
- **Example command:** `/jira-update Move JAN-42 to In Progress`
- **Core behavior:** parses command, resolves valid transition, executes Jira transition, sends Slack feedback

### `jira-issue-creator.json`

Creates Jira issues from natural-language Slack commands using OpenRouter for structured extraction.

- **Webhook path:** `/jira-create`
- **Example command:** `/jira-create Create a bug: login button not working on Safari`
- **Core behavior:** parse request text with LLM, normalize issue fields, create issue in Jira, notify Slack

### `sprint-summary.json`

Posts a board-level status summary with completion progress to Slack.

- **Webhook path:** `/sprint-summary`
- **Example command:** `/sprint-summary`
- **Core behavior:** fetch Jira issues, aggregate by status, generate progress bar summary, post to Slack

## Quick Start

1. Import the workflow JSON files from `workflows/` into n8n.
2. Create n8n credentials for Jira, Slack, and OpenRouter.
3. Configure environment variables (see `.env.example`) in your n8n environment.
4. Replace command paths or defaults if your workspace differs.
5. Expose n8n if running locally (`ngrok http 5678` or Cloud endpoint).
6. Configure Slack slash commands to point to your n8n webhook URLs.
7. Activate workflows and test each command end-to-end.

## Configuration Checklist

Before enabling in production, verify:

- Jira base URL and project key are not hardcoded to personal/dev tenants.
- Slack channel IDs and webhook routes match intended environments.
- n8n credential references point to credentials available in the target instance.
- OpenRouter model and prompt output format are pinned to expected behavior.
- Error/fallback paths are defined for malformed commands and API failures.

## Project Standards

- Contributor guide: `CONTRIBUTING.md`
- Security policy: `SECURITY.md`
- Runbook: `docs/operations-runbook.md`
- Workflow quality checks: `.github/workflows/validate-workflows.yml`
- Validation script: `scripts/validate-workflows.sh`

## Slash Commands

| Command | Purpose |
|---|---|
| `/jira-update` | Update issue status |
| `/jira-create` | Create a new Jira issue |
| `/sprint-summary` | Post board summary to Slack |

## Stack

- [n8n](https://n8n.io)
- [Jira Cloud API](https://developer.atlassian.com/cloud/jira/platform/rest/v3/intro/)
- [Slack API](https://api.slack.com/)
- [OpenRouter](https://openrouter.ai)

Author: Muhammad Umar Farooq
