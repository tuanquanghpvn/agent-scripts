#!/usr/bin/env bash
set -euo pipefail

root_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
timestamp="$(date +%Y%m%d%H%M%S)"

echo "==> Sync Claude skills"
claude_skills_dir="$HOME/.claude/skills"
mkdir -p "$claude_skills_dir"
rsync -a --delete "$root_dir/skills/" "$claude_skills_dir/"

echo "==> Sync Codex skills"
codex_skills_dir="$HOME/.codex/skills"
mkdir -p "$codex_skills_dir"
rsync -a --delete "$root_dir/skills/" "$codex_skills_dir/"

claude_cfg_src="$root_dir/configs/claude.json"
claude_cfg_dst="$HOME/.claude.json"
if [[ -f "$claude_cfg_src" ]]; then
  if [[ -f "$claude_cfg_dst" ]]; then
    cp "$claude_cfg_dst" "$claude_cfg_dst.bak.$timestamp"
  fi
  cp "$claude_cfg_src" "$claude_cfg_dst"
  echo "==> Claude config replaced"
else
  echo "==> Skip Claude config (missing $claude_cfg_src)"
fi

codex_cfg_src="$root_dir/configs/codex.toml"
codex_cfg_dst="$HOME/.codex/config.toml"
if [[ -f "$codex_cfg_src" ]]; then
  if [[ -f "$codex_cfg_dst" ]]; then
    cp "$codex_cfg_dst" "$codex_cfg_dst.bak.$timestamp"
  fi
  cp "$codex_cfg_src" "$codex_cfg_dst"
  echo "==> Codex config replaced"
else
  echo "==> Skip Codex config (missing $codex_cfg_src)"
fi
