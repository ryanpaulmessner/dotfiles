---
id: dot-2dj
title: "Ghostty as the main terminal (review, then config)"
type: epic
status: open
priority: 2
parent: null
blocked_by: []
related: []
supersedes: []
discovered_from: null
labels: []
created: 2026-11-20
closed: null
close_reason: null
---

Ryan swaps the terminal app from WezTerm to Ghostty (zsh and tmux stay). Phase 1: review in docs/ghostty-review.md (what WezTerm does today, Ghostty equivalents, integration checks in/out of tmux, install path, proposal). Phase 2 after Ryan's decision card: config/ghostty/config, tmux/nvim/taskfile changes on a branch. WSL2 path must keep working (no Ghostty on Windows). Handoff: ~/dev/work/handoffs/ghostty.md

## Notes
- 2026-11-20 claude: Card 32f94ea5 answered: Build; remove WezTerm. Ryan: this config won't use WSL at all (forked from personal config that does). Key defaults as recommended (no override).
- 2026-11-20 claude: Card 98713e90: Merge now. master fast-forwarded to 7a6f9dc (not pushed). Waiting on Ryan: task dot:symlink, brew install --cask --adopt ghostty, restart Ghostty, source tmux.conf, rm ~/.config/wezterm, then the checklist in docs/ghostty-review.md.
