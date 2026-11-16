---
id: dot-ebo
title: "Git author email check on work commits"
type: task
status: open
priority: 2
parent: null
blocked_by: []
related: []
supersedes: []
discovered_from: null
labels: []
created: 2026-11-16
closed: null
close_reason: null
---

Harness audit (~/dev/work/notes/doc-cleanup-2026-11-16/done-E.md (Handoffs) and skills.md, handoff 4). In block-sensitive-commit.sh: refuse git commit in a work repo when user.email is not the work email; message says to fix it in the dotfiles gitconfig.

- [ ] Planted: commit in a work temp repo with the personal email is refused
- [ ] A commit with the work email passes
- [ ] Non-work repos unaffected
