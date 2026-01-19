# Sentry MCP Server Setup

Source: https://docs.sentry.io/product/sentry-mcp/

## Overview

Use Sentry’s hosted MCP server (OAuth, remote HTTP) or a local stdio server
for self-hosted Sentry.

Hosted MCP URL:

```
https://mcp.sentry.dev/mcp
```

## Claude Code (JSON)

User scope: `~/.claude.json`  
Project scope: `.mcp.json`

Remote hosted (OAuth):

```json
{
  "mcpServers": {
    "sentry": {
      "url": "https://mcp.sentry.dev/mcp"
    }
  }
}
```

Remote hosted (stdio via mcp-remote):

```json
{
  "mcpServers": {
    "sentry": {
      "command": "npx",
      "args": [
        "-y",
        "mcp-remote@latest",
        "https://mcp.sentry.dev/mcp"
      ]
    }
  }
}
```

CLI add (remote HTTP):

```bash
claude mcp add --transport http sentry https://mcp.sentry.dev/mcp
```

## Codex (TOML)

Location: `~/.codex/config.toml`

Remote hosted (OAuth):

```toml
[mcp_servers.sentry]
url = "https://mcp.sentry.dev/mcp"
```

## Self-hosted / Local stdio

Requires Sentry User Auth Token with scopes:
`org:read`, `project:read`, `project:write`, `team:read`, `team:write`, `event:write`

Run stdio server:

```bash
npx @sentry/mcp-server@latest --access-token=sentry-user-token --host=sentry.example.com
```

Env vars:

```bash
export SENTRY_ACCESS_TOKEN=your-token
export SENTRY_HOST=sentry.example.com
```

Claude Code stdio config:

```json
{
  "mcpServers": {
    "sentry": {
      "command": "npx",
      "args": [
        "-y",
        "@sentry/mcp-server@latest"
      ],
      "env": {
        "SENTRY_ACCESS_TOKEN": "your-token",
        "SENTRY_HOST": "sentry.example.com"
      }
    }
  }
}
```

## Verify

- Claude Code: `/mcp` or `claude mcp list`
- Codex: `/mcp` in TUI
