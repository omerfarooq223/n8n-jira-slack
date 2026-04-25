# Security Policy

## Supported Scope

This project contains automation workflows and documentation for Jira/Slack integrations. Security concerns are treated as high priority, especially those affecting:

- exposed webhook endpoints
- credential handling in n8n
- data sent to AI providers
- tenant/workspace identifiers in committed files

## Responsible Disclosure

If you discover a vulnerability, avoid filing a public issue with exploit details. Share a private report with:

- clear reproduction steps
- impact assessment
- suggested mitigation (if available)

## Security Requirements for Contributions

- Never commit API tokens, secrets, or credential exports.
- Never commit tenant-specific production identifiers unless explicitly required and approved.
- Sanitize workflow exports before committing.
- Validate webhook input and handle malformed payloads safely.
- Minimize sensitive context sent to external AI providers.

## Hardening Recommendations

- Restrict slash command access by workspace/app policy.
- Use least-privilege Jira and Slack tokens.
- Rotate credentials regularly and after incident response.
- Add request verification/rate limiting at ingress where possible.
