# Ghostty as the main terminal: review

Epic `dot-2dj`. Written 2026-11-20 by the ghostty coordinator. Phase 1 only: nothing in `~/` or the repo
config was changed. The proposed files were checked with `ghostty +validate-config` and a separate tmux
server (`tmux -L ghostty-test`), and are shown here, not installed.

Status words: **pass** (works in Ghostty today or with the proposal), **gap** (needs a change or a
decision), **not checked** (needs Ryan's eyes or a remote host; see the checklist at the end).

## Summary

- Ryan uses WezTerm as a plain window around tmux: `wezterm cli list` shows one window, one tab, one pane
  (running tmux). None of the WezTerm pane, tab, leader or status-bar features are in use. Almost
  nothing is lost.
- Ghostty already works well inside tmux. The live tmux client from Ghostty has `TERM=xterm-ghostty`
  with true colour, undercurl, cursor shape, focus events, OSC 52 and SGR mouse. Two tmux features are
  missing for Ghostty (`sync`, `hyperlinks`); one line in `tmux.conf` adds them.
- Ghostty runs with defaults today. The proposal is one small config file (about 50 lines).
- Ghostty was not installed with Homebrew, and the repo has no Ghostty install. A fresh Mac gets WezTerm,
  not Ghostty.
- WSL2 must keep WezTerm: Ghostty has no official Windows build (see section 4).
- Decisions for Ryan: what to do with WezTerm, and three key bindings. See section 5.

## 0. The older plan (`docs/ghostty-integration-plan.md`)

| Claim in the old plan | Now |
| --- | --- |
| Ghostty has native tabs, splits, quick terminal | Still true. |
| Mirror the WezTerm leader bindings natively (`ctrl+space>…`) | Out of date. Ryan does not use WezTerm panes or tabs; tmux does all of it. Do not port them. |
| "Coexist with WezTerm, macOS first" | Partly true: macOS is the target. Coexist is now Ryan's decision (section 5). |
| No official Windows build; list of community forks | No official build is still true (ghostty.org/docs/install/binary: "only officially distributes prebuilt binaries for macOS"). The fork list was not re-checked. |
| Config at `config/ghostty/config` | Works, but the 1.3 default name is `config.ghostty` (man page, FILES). Both names load (tested with `XDG_CONFIG_HOME`). Use `config.ghostty`. |
| Symlink is free: `config/*` → `~/.config/*` | True: `taskfiles/dotfiles.yml:185` loops over `./config/*`. |
| Add `cask 'ghostty'` near `cask 'wezterm'` | Still needed (`Brewfile:7`). Ghostty.app is in /Applications but not from brew (section 4). |
| No copy mode in Ghostty | Out of date: 1.3 has key tables ("copy mode", "vim mode" are the examples in the docs). Not needed: tmux copy mode is used. |
| Font size 11 vs dkarter's 17 | Still open; proposal uses 11 to match WezTerm. |

## 1 and 2. What WezTerm does today, and the Ghostty equivalent

WezTerm file: `config/wezterm/wezterm.lua`. Ghostty source: `ghostty +show-config --default --docs`
from Ghostty 1.3.1 (the installed app) and the man page in the app bundle.

| Feature | WezTerm today | Ghostty | Status |
| --- | --- | --- | --- |
| Theme | `Tokyo Night` with darker background `#14151c`, brighter fg `#d0daf5` and a bright custom ANSI palette (`wezterm.lua:21`, `:94-122`) | `theme = TokyoNight Night` (same `#1a1b26` base) plus `background`, `foreground`, `palette = N=#…` lines that override the theme | pass (proposal) |
| Light/dark | Dark only | `theme = light:TokyoNight Day,dark:TokyoNight Night` exists. Custom `background`/`palette` lines would apply to both, so light mode would need them dropped | not wanted today; noted |
| Font | FiraCode Nerd Font, fallbacks JetBrains Mono, Cascadia Code, Consolas, size 11 (`:25-31`) | `font-family` repeated for fallbacks, `font-size` (default 13). FiraCode Nerd Font is installed in `~/Library/Fonts` | pass (proposal) |
| Ligatures | `calt`, `clig`, `liga` (`:40`) | Ligatures are on by default; `font-feature = calt`, `liga` makes it explicit | pass |
| Line height / Windows font fixes | `line_height`, freetype flags on Windows (`:34-48`) | `adjust-cell-height` etc. Not needed on macOS | pass |
| Window decorations | macOS: `RESIZE` (no title bar) (`:59`) | `macos-titlebar-style = hidden` | pass (proposal) |
| Padding | 4 px each side (`:61-66`) | `window-padding-x/y = 4` | pass |
| Tab bar, tab titles, right status (date, battery) | Shown always (`:69-73`, `:625-673`) | Ghostty tabs show only with 2+ tabs. No status bar. tmux status already shows battery | pass (nothing to port) |
| Opacity / blur | Opaque, blur 20 on macOS (no effect when opaque) (`:186-191`) | `background-opacity`, `background-blur`; defaults are opaque | pass |
| Cursor | Blinking bar, 500 ms (`:194-197`) | `cursor-style = bar`, `cursor-style-blink = true` (rate is fixed) | pass |
| Scrollback | 10,000 lines (`:209`) | `scrollback-limit` in bytes (default 10 MB). tmux has its own (100,000, `tmux.conf:181`) | pass |
| Startup command | macOS: `/bin/zsh -l` (system zsh) (`:236`) | Default is the login shell: `ghostty +show-config` shows `command = /opt/homebrew/bin/zsh`. tmux also uses brew zsh (`tmux.conf:14-16`) | pass (Ghostty is more consistent) |
| Window size | Not set | `window-width/height`; not set | pass |
| Option as Meta | Left Option = Alt, right Option composes (`:535-536`) | `macos-option-as-alt = left` | pass (proposal) |
| CSI-u / kitty keyboard | Both off (`:243-244`) | Ghostty has no switch to turn the kitty protocol off; it is used only when a program asks. Inside tmux, tmux decides (`extended-keys` is off, and `zshrc:130` says it breaks scrollback). Outside tmux, Neovim will ask for it | gap (low): outside tmux, nvim key encoding differs from WezTerm; inside tmux no change |
| Copy / paste | `Cmd+Shift+C/V`, `Shift+Insert` (`:266-279`) | `Cmd+C/V` default. `Cmd+Shift+V` is `paste_from_selection` by default; proposal rebinds it and adds `Cmd+Shift+C`, `Shift+Insert` | pass (proposal) |
| Copy mode | `Cmd+[` WezTerm copy mode (`:261`, `:544-569`) | No built-in copy mode; key tables could build one. tmux copy mode (`prefix [`) is what runs inside tmux anyway | decision: drop (recommended) |
| Copy on select | WezTerm default: clipboard | Default `copy-on-select = true` goes to Ghostty's selection buffer; `clipboard` also writes the system clipboard. With tmux `mouse on`, only Shift+drag selects in Ghostty | pass (proposal sets `clipboard`) |
| URL opening | `Cmd+click` (`:575-582`) | Default: Cmd+hover/click opens URLs (`link-url = true`) | pass |
| Custom link rule (`owner/repo` → GitHub) | `:592-595` | `link` cannot be set yet ("TODO: This can't currently be set!" in the docs) | gap: lost. tmux-open / tmux-thumbs cover it |
| Quick select | `Cmd+Shift+Space`, paths/SHAs/IPs/hex (`:520-523`, `:598-608`) | None | decision: drop (recommended); `prefix F` tmux-thumbs and `prefix Tab` extrakto do this inside tmux |
| Leader `Ctrl+Space` pane/tab keys | 30+ bindings (`:256-477`) | Possible with `ctrl+space>…` sequences, but unused | decision: drop (recommended) |
| Font size keys | `Cmd+= - 0` (`:481-495`) | Same keys are default | pass |
| Reload config | `Leader r` (`:499`) | `Cmd+Shift+,` default | pass |
| `Ctrl+Z` | Passed through to tmux (prefix2) (`:505-509`) | Passed through by default | pass |
| Fullscreen | `Alt+Enter`, non-native (`:527-530`, `:537`) | `Cmd+Enter` / `Cmd+Ctrl+F` default; `macos-non-native-fullscreen = true` | decision: keep `Alt+Enter`? (recommended: no) |
| Bell | Silent, visual cursor flash (`:614-619`) | Default `bell-features` = attention + title, no audio | pass |
| `TERM` | `xterm-256color` (`:681`) | `xterm-ghostty` (own terminfo) | see section 3 |

## 3. Terminal integration checks

Measured from this session, which runs in tmux 3.7b attached from Ghostty 1.3.1.

| Check | Result | Status |
| --- | --- | --- |
| `TERM` outside tmux | `xterm-ghostty`; Ghostty sets `TERMINFO` to its app bundle (`Ghostty.app/Contents/Resources/terminfo/78/xterm-ghostty`). macOS system terminfo does not have it (`infocmp xterm-ghostty` fails in a shell without that variable) | pass on this Mac |
| `TERM` inside tmux | `tmux-256color` (`tmux.conf:21`) | pass |
| True colour | tmux sees `RGB` and `Tc` for the Ghostty client (`tmux info`); `COLORTERM=truecolor`; nvim `termguicolors` (`config/nvim/lua/config/options.lua:11`) | pass (gradient not looked at: checklist) |
| Undercurl | `Smulx` and `Setulc` present via `terminal-overrides` (`tmux.conf:34-35`) | pass in tmux caps; not checked by eye |
| Italics | `tmux-256color` has `sitm`; Ghostty supports italics | not checked by eye |
| Cursor shape (nvim, zsh-vi-mode) | `Ss`/`Se` present (`tmux.conf:37`); client feature `cstyle` | pass |
| tmux `terminal-features` | Ghostty client gets `bpaste,ccolour,clipboard,cstyle,focus,RGB,title` from the default `xterm*` entry. Missing `sync` (Ghostty supports mode 2026; the WezTerm client has `Sync`, the Ghostty client does not), `hyperlinks` (OSC 8), `usstyle`, `strikethrough`, `overline` | gap: one line (section 5) |
| `extended-keys` | Off (default). Kept off on purpose (`zshrc:130`) | pass (no change) |
| OSC 52 | tmux `set-clipboard external`; tmux copy also pipes to `pbcopy` (`tmux.conf:303-304`). Ghostty `clipboard-write = allow` | pass. Remote nvim → local clipboard through tmux does not work, same as WezTerm today (`external` ignores OSC 52 from programs) |
| Neovim clipboard | `gy` etc. use `"+` (`keymaps.lua:176-186`) → pbcopy on macOS, no terminal involved | pass |
| Mouse | SGR mouse (`kmous=\E[<`); tmux `mouse on` (`tmux.conf:198`) | pass |
| Focus events | `focus-events on` (`tmux.conf:43`); client feature `focus` | pass |
| nvim keymaps that name WezTerm | Only a comment (`config/nvim/lua/config/keymaps.lua:163`) | pass (comment text only) |
| `Ctrl+Space` | WezTerm ate it as leader. In Ghostty it reaches the program. blink.cmp (LazyVim's completion) maps `<C-space>` to "show completion" (`blink/cmp/keymap/presets.lua:8`); zsh gets `^@` | gap (decision 3) |
| zsh vi-mode and stty | `stty -ixon` (`config/zsh/settings.zsh:4`), `KEYTIMEOUT=1`; zsh-vi-mode (`config/zsh/keybindings.zsh`). Nothing terminal-specific | pass |
| Ghostty shell integration | Inside tmux it does not load (tmux starts zsh itself). Outside tmux it loads and by default sets the cursor to a bar at the prompt, which fights zsh-vi-mode's cursor; proposal sets `shell-integration-features = no-cursor` | pass (proposal); zinit interplay not checked |
| SSH to servers | `aliases:39` `alias ssh="TERM=xterm-256color ssh"`, so interactive `ssh` sends `xterm-256color` and works everywhere. What breaks: anything that runs `ssh` without the alias (scripts, `command ssh`, tools) sends `xterm-ghostty` outside tmux or `tmux-256color` inside tmux. A host without that terminfo gives "unknown terminal type" (`clear`, `less`, `htop`, `vim` misbehave). Ghostty's `ssh-env` / `ssh-terminfo` features would handle this but are off by default; `ssh-terminfo` installs terminfo on the remote host, so not proposed | not checked on staging/prod VMs (no remote check run) |
| `sudo` outside tmux | `sudo` drops `TERMINFO`, so `xterm-ghostty` is unknown under sudo. Ghostty's `sudo` shell-integration feature fixes it; off by default | gap (low; Ryan works inside tmux) |
| Images | No image protocol in use (no snacks image, no kitty graphics in config) | pass |
| Stale WezTerm env in tmux | The running tmux server was started from WezTerm. Its global env still has `TERM_PROGRAM=WezTerm`, `WEZTERM_*`, `SSH_AUTH_SOCK=~/.local/share/wezterm/agent.1370` (`tmux show-environment -g`). The session env was updated on attach (`SSH_AUTH_SOCK` is the launchd socket), so ssh works. Panes still get the `WEZTERM_*` variables. Goes away the next time Ryan starts tmux from Ghostty | gap (low; no action now) |
| Ghostty version | Installed 1.3.1; ghostty.org shows 1.4.0 stable. A second tmux client reports "ghostty 1.2.3" with `xterm-256color` (`tmux list-clients`); not traced | not checked |

## 4. Install and setup

| Item | Today | Status |
| --- | --- | --- |
| Brewfile | `cask 'wezterm'` (`Brewfile:7`); no `ghostty`. `brew list --cask` shows only wezterm: Ghostty.app was installed by hand | gap: add `cask 'ghostty'`. Because the app already exists, `brew bundle` will refuse the cask until Ryan runs `brew install --cask --adopt ghostty` once (or deletes the app) |
| Config symlink | `task dot:symlink` links every `config/<tool>/` to `~/.config/<tool>` (`taskfiles/dotfiles.yml:185`) | pass: a new `config/ghostty/` is linked automatically |
| Existing Ghostty config | `~/Library/Application Support/com.mitchellh.ghostty/config.ghostty` exists and is empty (0 bytes). The man page says this path "takes precedence", but a test showed the XDG file still loads with the empty one present | pass; leave the empty file alone |
| WezTerm tasks | `taskfiles/wezterm.yml` (WSL only: copies config to the Windows home); called from `install` and `sync` (`taskfiles/dotfiles.yml:91`, `:126`); `Taskfile.dist.yml:86` | pass for WSL; no Ghostty task needed on macOS |
| Fresh Mac | `task install` → brew installs WezTerm, config links, no Ghostty | gap: fixed by the Brewfile line |
| WSL2 / Windows | Ghostty: no official Windows build ("The Ghostty project only officially distributes prebuilt binaries for macOS", ghostty.org/docs/install/binary). WezTerm.exe + `wsl.exe` stays the only supported path. A `config/ghostty/` dir on WSL is linked but unused (harmless) | pass if WezTerm stays for WSL |
| Docs naming WezTerm | `AGENTS.md:3`, `README.md:34`, `:45`, `:67-69`, `KEYBINDINGS.md:3`, `:11`, `:118-160`, `:368`; `dprint.json:59` excludes `wezterm.lua` | gap: update in phase 2 |

## 5. Proposal

### `config/ghostty/config.ghostty` (validated with `ghostty +validate-config`; not installed)

```ini
# Ghostty: main terminal on macOS. tmux does panes/tabs; Ghostty only draws.
# Machine-only lines go in ~/.config/ghostty/config.local (not in the repo).

# Look: Tokyo Night with the brighter colours from config/wezterm/wezterm.lua
theme = TokyoNight Night
background = #14151c
foreground = #d0daf5
palette = 0=#2a2f44
palette = 1=#ff9db4
palette = 2=#c3f991
palette = 3=#ffd580
palette = 4=#97c2ff
palette = 5=#d7bdff
palette = 6=#a3e5ff
palette = 7=#f5f5f5
palette = 8=#545c7e
palette = 9=#ffb3c9
palette = 10=#dcffb0
palette = 11=#ffe9a3
palette = 12=#b8d7ff
palette = 13=#ebd5ff
palette = 14=#c9f3ff
palette = 15=#ffffff

font-family = FiraCode Nerd Font
font-family = JetBrains Mono
font-size = 11
font-feature = calt
font-feature = liga

window-padding-x = 4
window-padding-y = 4
macos-titlebar-style = hidden
macos-non-native-fullscreen = true
cursor-style = bar
cursor-style-blink = true

# Keys: left Option is Alt/Meta, right Option types special characters
macos-option-as-alt = left
keybind = shift+insert=paste_from_clipboard
keybind = super+shift+c=copy_to_clipboard
keybind = super+shift+v=paste_from_clipboard

copy-on-select = clipboard
confirm-close-surface = false

# zsh-vi-mode sets the cursor shape; do not let shell integration fight it
shell-integration-features = no-cursor

config-file = ?config.local
```

`confirm-close-surface = false` matches WezTerm (no prompt on close). With tmux, closing the window only
detaches. Change it if Ryan wants the prompt.

### `config/tmux/tmux.conf` (one line after line 37; tested on `tmux -L ghostty-test`)

```tmux
set -as terminal-features 'xterm-ghostty:RGB:clipboard:ccolour:cstyle:focus:hyperlinks:sync:title:usstyle:strikethrough:overline'
```

Ryan sources the real tmux config himself. The WSL `if-shell` block (`tmux.conf:292-302`) keeps its
WezTerm comment; it is still correct for WSL.

### Neovim

No change needed. Optional: comment at `keymaps.lua:163` says "tmux/wezterm".

### Taskfiles, Brewfile, docs

- `Brewfile`: add `cask 'ghostty'` (comment: main terminal on macOS). Keep or remove `cask 'wezterm'`
  per decision 1.
- Taskfiles: no new task. `wezterm:sync` stays for WSL (or goes, per decision 1).
- `AGENTS.md`, `README.md`, `KEYBINDINGS.md`: name Ghostty as the macOS terminal; keep the WezTerm
  section marked "WSL/Windows only" or remove it.
- Mark `docs/ghostty-integration-plan.md` as replaced by this review.

### Decisions for Ryan

1. **WezTerm**: (a) keep it for WSL/Windows only: keep `config/wezterm/`, `taskfiles/wezterm.yml`,
   drop the macOS cask (recommended); (b) keep it everywhere as a fallback, cask included; (c) remove it
   from the repo (breaks the WSL machine: it has no other terminal config here).
2. **WezTerm-only keys** with no Ghostty equivalent worth building: copy mode `Cmd+[`, quick select
   `Cmd+Shift+Space`, the `owner/repo` link rule. Recommended: drop them; tmux copy mode, tmux-thumbs
   and extrakto do the same inside tmux.
3. **`Ctrl+Space`**: WezTerm used it as a leader, so programs never saw it. In Ghostty: (a) let it
   reach programs (blink.cmp's "show completion" in nvim starts working) (recommended), or (b)
   `keybind = ctrl+space=ignore` to keep it dead.
4. **`Alt+Enter` fullscreen**: drop it (recommended; `Cmd+Enter` is Ghostty's default and `Alt+Enter`
   then reaches programs), or keep it with `keybind = alt+enter=toggle_fullscreen`.

## Checklist for Ryan (things I cannot see from a shell)

After phase 2 installs the config and Ghostty restarts:

1. `~/dev/dotfiles/scripts/truecolor-test.sh` in tmux: smooth gradient.
2. In nvim, a spelling or LSP error: a curly underline in the error colour; italics in comments.
3. Left Option+b in zsh moves back a word; right Option+e then e types é.
4. `Cmd+click` a URL opens the browser; Shift+drag selects text and it is on the clipboard.
5. Colours match WezTerm side by side.
6. Which window is the "ghostty 1.2.3" tmux client (`tmux list-clients`)?
