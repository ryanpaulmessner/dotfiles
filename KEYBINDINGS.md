# Keybindings Cheat Sheet

Quick reference for all keybindings across Zsh, Neovim, tmux, and Ghostty.

---

## Unified Window/Pane Management

Same muscle memory works across all tools:

| Operation    | Vim              | tmux             |
|--------------|------------------|------------------|
| Navigate     | `Ctrl+W hjkl`    | `Ctrl+S hjkl`    |
| Swap/Move    | `Ctrl+W HJKL`    | `Ctrl+S HJKL`    |
| Resize       | `Ctrl+W Ctrl+hjkl` | `Ctrl+S Ctrl+hjkl` |
| Zoom         | `Ctrl+W z`       | `Ctrl+S z`       |
| Equalize     | `Ctrl+W =`       | `Ctrl+S =`       |
| Rotate       | `Ctrl+W r/R`     | `Ctrl+S R`       |
| Last Active  | `Ctrl+W ;`       | `Ctrl+S ;`       |

**Pattern**: More modifiers = more permanent changes
- `hjkl` → navigate (temporary)
- `HJKL` → swap (layout change)
- `Ctrl+hjkl` → resize (dimension change)

---

## Zsh (Vi-Mode)

Uses `zsh-vi-mode` plugin. Cursor shape indicates mode: beam (insert), block (normal).

### Mode Switching

| Binding    | Action                |
|------------|-----------------------|
| `Ctrl+G`   | Exit to normal mode   |
| `jk`       | Exit to normal mode (200ms timeout) |
| `i/a/A/I`  | Enter insert mode (standard vim) |

### Insert Mode

| Binding       | Action                          |
|---------------|---------------------------------|
| `Ctrl+A`      | Beginning of line               |
| `Ctrl+E`      | End of line                     |
| `Ctrl+K`      | Kill to end of line             |
| `Ctrl+W`      | Delete word backward            |
| `Ctrl+U`      | Delete to start of line         |
| `Ctrl+L`      | Clear screen                    |
| `Ctrl+R`      | FZF history search              |
| `Ctrl+T`      | FZF file widget                 |
| `Ctrl+P/N`    | Previous/next history           |
| `Ctrl+F`      | Accept entire autosuggestion    |
| `Ctrl+Y`      | Accept autosuggestion word-by-word |
| `→`           | Accept autosuggestion char-by-char |
| `Ctrl+→/←`    | Forward/backward word           |

### Normal Mode

Standard vim bindings: `hjkl`, `w/b/e`, `0/$`, `x`, `dd`, `dw`, `cw`, `ciw`, `u`, `/`, `f/t`, `p`, etc.

---

## tmux

**Prefix**: `Ctrl+S` (primary) or `Ctrl+Z` (secondary)

### Panes

| Binding         | Action                    |
|-----------------|---------------------------|
| `Prefix s`      | Split horizontal (below)  |
| `Prefix v`      | Split vertical (right)    |
| `Prefix hjkl`   | Navigate panes            |
| `Prefix HJKL`   | Swap pane position        |
| `Prefix Ctrl+hjkl` | Resize pane            |
| `Prefix z`      | Zoom/unzoom pane          |
| `Prefix =`      | Equalize (tiled layout)   |
| `Prefix R`      | Rotate panes              |
| `Prefix ;`      | Last active pane          |
| `Prefix b`      | Break pane to new window  |
| `Prefix x`      | Close pane (via plugin)   |

### Windows (Tabs)

| Binding         | Action                    |
|-----------------|---------------------------|
| `Prefix c`      | Create new window         |
| `Prefix Tab`    | Toggle last window        |
| `Prefix w`      | Choose window/session tree |
| `Prefix S`      | Fuzzy find sessions       |
| `Ctrl+Shift+←/→` | Reorder windows          |

### Copy Mode

| Binding         | Action                    |
|-----------------|---------------------------|
| `Prefix [`      | Enter copy mode           |
| `v`             | Begin selection           |
| `V`             | Line selection            |
| `Ctrl+V`        | Rectangle selection       |
| `y` / `Enter`   | Copy to clipboard (WSL: clip.exe) |
| `q` / `Escape`  | Exit copy mode            |

### Other

| Binding         | Action                    |
|-----------------|---------------------------|
| `Prefix r`      | Reload tmux config        |
| `Prefix M`      | Edit tmux config (split)  |
| `Prefix Ctrl+L` | Send Ctrl+L (clear)       |
| `Prefix F`      | Thumbs (vimperator copy)  |
| `Prefix P`      | Fuzzy find panes          |
| `Prefix TAB`    | Extrakto (copy text)      |

---

## Ghostty

Ghostty only draws the window; tmux does panes and tabs. Config: `config/ghostty/config.ghostty`
(machine-only lines in `~/.config/ghostty/config.local`). Left Option is Alt/Meta; right Option types
special characters. `Alt+Enter` goes through to programs; `Ctrl+Space` is the Ghostty leader
(press it twice to send `Ctrl+Space` to the program, e.g. nvim completion).

| Binding               | Action                  |
|-----------------------|-------------------------|
| `Cmd+C` / `Cmd+Shift+C` | Copy                  |
| `Cmd+V` / `Cmd+Shift+V` / `Shift+Insert` | Paste |
| `Shift+drag`          | Select in Ghostty (bypasses tmux mouse); copies to clipboard |
| `Cmd+click`           | Open URL                |
| `Cmd+ =/-/0`          | Font size +/-/reset     |
| `Cmd+Enter`           | Toggle fullscreen       |
| `Cmd+Shift+,`         | Reload config           |

Ghostty splits and tabs, leader `Ctrl+Space` (same letters as tmux; the leader waits with no timeout):

| Binding               | Action                  |
|-----------------------|-------------------------|
| `Leader h/j/k/l`      | Go to split left/down/up/right |
| `Leader Ctrl+h/j/k/l` | Resize split            |
| `Leader s` / `"`      | Split down              |
| `Leader v` / `%`      | Split right             |
| `Leader z`            | Zoom split              |
| `Leader =`            | Equalize splits         |
| `Leader x`            | Close split             |
| `Leader c`            | New tab                 |
| `Leader Tab`          | Last tab                |
| `Leader n` / `p`      | Next / previous tab     |
| `Leader 1-9`          | Go to tab 1-9           |
| `Leader Ctrl+Space`   | Send `Ctrl+Space`       |

No Ghostty equivalent for the old WezTerm swap (`Leader Shift+hjkl`), rotate (`Leader R`) and pane
picker (`Leader ;`).

Copy mode and quick select: use tmux (`Prefix [`, `Prefix F` thumbs, `Prefix TAB` extrakto).

---

## Neovim

### General

| Binding         | Action                    |
|-----------------|---------------------------|
| `Ctrl+G`        | Exit insert mode          |
| `<Esc>`         | Clear search highlight    |
| `Y`             | Yank to end of line       |
| `Q`             | Replay macro @q           |
| `n/N`           | Next/prev search (centered) |
| `Tab Tab`       | Switch alternate buffer   |

### Window Management

| Binding            | Action                 |
|--------------------|------------------------|
| `Ctrl+W hjkl`      | Navigate windows       |
| `Ctrl+W HJKL`      | Move window position   |
| `Ctrl+W Ctrl+hjkl` | Resize windows         |
| `Ctrl+W z`         | Zoom window            |
| `Ctrl+W =`         | Equalize windows       |
| `Ctrl+W ;`         | Last active window     |
| `<leader>wo`       | Close other windows    |

### File Navigation (Oil.nvim)

| Binding         | Action                    |
|-----------------|---------------------------|
| `-`             | Open parent directory     |
| `<leader>o`     | Open Oil                  |
| `<leader>O`     | Open Oil (float)          |

**In Oil buffer:**
| Binding         | Action                    |
|-----------------|---------------------------|
| `<CR>`          | Select/open               |
| `-`             | Parent directory          |
| `g.`            | Toggle hidden files       |
| `gs`            | Change sort               |
| `Ctrl+S`        | Open in vsplit            |
| `Ctrl+H`        | Open in split             |
| `Ctrl+P`        | Preview                   |

### Finder (Snacks.picker)

| Binding         | Action                    |
|-----------------|---------------------------|
| `Ctrl+P`        | Find files                |
| `Ctrl+B`        | Find buffers              |
| `<leader>ff`    | Find files (hidden)       |
| `<leader>fg`    | Find with grep            |
| `<leader>lg`    | Live grep                 |
| `<leader>fw`    | Find word under cursor    |
| `<leader>fh`    | Find help                 |
| `<leader>fk`    | Find keymaps              |
| `<leader>fd`    | Find dotfiles             |
| `<leader>fo`    | Recent files              |
| `<leader>fs`    | Git status files          |
| `<leader>f<CR>` | Resume last finder        |
| `<leader>,`     | Buffers                   |
| `<leader>/`     | Fuzzy buffer lines        |
| `<leader>:`     | Command history           |
| `<leader>pp`    | Registers                 |
| `z=`            | Spelling suggestions      |

**In picker:**
| Binding         | Action                    |
|-----------------|---------------------------|
| `Ctrl+X`        | Open in split             |
| `Ctrl+V`        | Open in vsplit            |

### LSP

| Binding         | Action                    |
|-----------------|---------------------------|
| `gd`            | Go to definition          |
| `gD`            | Go to declaration         |
| `gr`            | Go to references          |
| `gR`            | References (Trouble)      |
| `K`             | Hover documentation       |
| `<leader>D`     | Type definition           |
| `<leader>ca`    | Code action               |
| `<leader>rn`    | Rename symbol             |
| `<leader>lh`    | Toggle inlay hints        |
| `<leader>ds`    | Document symbols          |
| `<leader>cf`    | Format code               |

### Git (Fugitive & Diffview)

| Binding         | Action                    |
|-----------------|---------------------------|
| `<leader>gS`    | Git stage file            |
| `<leader>gw`    | Git write (stage)         |
| `<leader>gR`    | Git read (revert)         |
| `<leader>gd`    | Diffview open             |
| `<leader>gh`    | File history (current)    |
| `<leader>gH`    | File history (all)        |
| `<leader>gc`    | Diffview close            |
| `<leader>bc`    | Buffer commits            |

### Clipboard

| Binding         | Action                    |
|-----------------|---------------------------|
| `gy`            | Yank to system clipboard  |
| `gY`            | Yank to EOL to clipboard  |
| `<leader>ya`    | Yank entire file          |
| `<leader>yA`    | Yank file to clipboard    |

### Testing (vim-test)

| Binding         | Action                    |
|-----------------|---------------------------|
| `<leader>tn`    | Test nearest              |
| `<leader>tf`    | Test file                 |
| `<leader>ts`    | Test suite                |
| `<leader>tl`    | Test last                 |

### Motion (Flash)

| Binding           | Action                  |
|-------------------|-------------------------|
| `<leader><leader>`| Flash jump              |
| `<leader><CR>`    | Flash treesitter        |
| `f/F/t/T`         | Enhanced char motions   |

### Diagnostics (Trouble)

| Binding         | Action                    |
|-----------------|---------------------------|
| `<leader>xw`    | Workspace diagnostics     |
| `<leader>xd`    | Document diagnostics      |
| `<leader>xl`    | Location list             |
| `<leader>xq`    | Quickfix list             |
| `[q / ]q`       | Prev/next quickfix item   |

### AI (Claude Code)

| Binding         | Action                    |
|-----------------|---------------------------|
| `Ctrl+,`        | Toggle Claude             |
| `<leader>ac`    | Toggle Claude Code        |
| `<leader>af`    | Focus Claude              |
| `<leader>ar`    | Resume Claude             |
| `<leader>am`    | Select model              |
| `<leader>ab`    | Add current buffer        |
| `<leader>as`    | Send selection (visual)   |
| `<leader>ah`    | Claude history (session)  |
| `<leader>aH`    | Claude history (all)      |

### Visual Mode

| Binding         | Action                    |
|-----------------|---------------------------|
| `Tab / S-Tab`   | Indent/outdent            |
| `> / <`         | Indent (keep selection)   |
| `J / K`         | Move lines down/up        |
| `*`             | Search selected text      |
| `<leader>k`     | Replace selection globally |

### Misc

| Binding         | Action                    |
|-----------------|---------------------------|
| `<leader>mv`    | Move/rename current file  |
| `<leader>sa`    | Save as                   |
| `<leader>k`     | Replace word under cursor |
| `<leader>so`    | Source current file       |
| `<leader>rl`    | Reload current lua file   |
| `<leader>ps`    | Plugin sync (Lazy)        |
| `<leader>pc`    | Plugin clean              |
| `<leader>th`    | Toggle Hardtime           |
| `<leader>vg`    | Vim Be Good (practice)    |
| `[j / ]j`       | Portal jumplist           |

### Terminal

| Binding         | Action                    |
|-----------------|---------------------------|
| `<Esc><Esc>`    | Exit terminal mode        |
| `Ctrl+O`        | Exit terminal mode        |

---

## Quick Reference

### Leader Keys
- **Zsh**: None (vi-mode uses Escape/Ctrl+G)
- **tmux**: `Ctrl+S` or `Ctrl+Z`
- **Neovim**: `Space` (LazyVim default)

### Mode Escape
- **Zsh**: `Ctrl+G` or `jk`
- **Neovim**: `Ctrl+G` or `Escape`

### Consistent Patterns
- `hjkl` = navigate
- `HJKL` = swap/move
- `Ctrl+hjkl` = resize
- `s` = horizontal split
- `v` = vertical split
- `z` = zoom
- `;` = last active
