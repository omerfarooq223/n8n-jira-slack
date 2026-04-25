# Operations Runbook

## Pre-Production Checklist

- Confirm all required n8n credentials exist in target environment.
- Set environment variables from `.env.example`.
- Ensure slash command URLs point to production n8n endpoints.
- Validate workflows with `bash scripts/validate-workflows.sh`.
- Run smoke tests for all three commands.

## Smoke Test Commands

- `/jira-update Move JAN-1 to In Progress`
- `/jira-create Create a task: verify webhook retries`
- `/sprint-summary`

## Common Failure Modes

- **Invalid command format:** Slack payload differs from expected shape.
- **Transition not found:** Jira workflow does not expose requested status.
- **Issue creation parsing error:** AI output is malformed or missing JSON fields.
- **Unauthorized API calls:** credential references missing or expired.

## Rollback Approach

- Deactivate affected workflow in n8n.
- Revert to previous workflow JSON export.
- Re-run smoke tests before re-enabling.
