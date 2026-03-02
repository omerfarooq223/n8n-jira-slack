# n8n Jira-Slack Integration

Automated workflows connecting Jira and Slack using n8n and OpenRouter AI.

## Workflows

### 1. Jira Status Updater
Update Jira issue statuses directly from Slack.
- **Path:** `/update-status`
- **Usage:** `/jira-update Move JAN-1 to Done`

### 2. Jira Issue Creator
Create new Jira issues from Slack with AI parsing.
- **Path:** `/jira-create`
- **Usage:** `/jira-create Create a bug: login button not working`

### 3. Sprint Summary
Get real-time Kanban board summary posted to Slack.
- **Path:** `/sprint-summary`
- **Usage:** `/sprint-summary`

## Prerequisites
- n8n running locally
- Jira Software Cloud API credentials
- Slack API Bot Token
- OpenRouter API key
- ngrok for local webhook exposure

## Setup
1. Import any `.json` from `workflows/` into n8n
2. Add Jira, Slack and OpenRouter credentials
3. Start ngrok: `ngrok http 5678`
4. Update Slack slash command URLs with ngrok URL
5. Activate workflows in n8n

## Slack Slash Commands
| Command | Description |
|---|---|
| `/jira-update` | Update issue status |
| `/jira-create` | Create new issue |
| `/sprint-summary` | Get board summary |

## Tech Stack
- [n8n](https://n8n.io) - Workflow automation
- [Jira](https://atlassian.com/jira) - Project management
- [Slack](https://slack.com) - Team communication
- [OpenRouter](https://openrouter.ai) - AI model access
