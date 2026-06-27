# Terminal Setup — Catppuccin Mocha

> Ghostty · Zsh (vi mode) · tmux + sesh · Starship · Carapace · fzf · zoxide · Atuin · TPM

---

## Directory Structure

```
terminal-setup/
├── ghostty/
│   └── config              → ~/.config/ghostty/config
├── zsh/
│   └── .zshrc              → ~/.zshrc
├── tmux/
│   └── tmux.conf           → ~/.config/tmux/tmux.conf
├── starship/
│   └── starship.toml       → ~/.config/starship.toml
├── atuin/
│   └── config.toml         → ~/.config/atuin/config.toml
└── install.sh              (run this first)
```

---

## Quick Start

```sh
chmod +x install.sh
./install.sh
```

Then open Ghostty, start tmux, and press **`Ctrl+Space` + `I`** to install tmux plugins.

---

## Keybinds Reference

### Zsh — Vi Mode

| Key | Action |
|-----|--------|
| `Esc` | Normal mode |
| `vv` (normal mode) | Edit command in `$EDITOR` |
| `H` / `L` | Start / end of line |
| `Ctrl+R` | Atuin fuzzy history search |
| `Ctrl+T` | fzf file picker |
| `Alt+C` | fzf directory picker |

### tmux — Prefix is `Ctrl+Space`

| Shortcut | Action |
|----------|--------|
| `Prefix + \|` | Split pane horizontally |
| `Prefix + -` | Split pane vertically |
| `Prefix + h/j/k/l` | Navigate panes (vim-style) |
| `Prefix + H/J/K/L` | Resize panes |
| `Prefix + T` | **sesh** session switcher (fzf) |
| `Prefix + Space` | Switch to last session |
| `Prefix + [` | Enter copy mode |
| `v` (copy mode) | Begin selection |
| `y` (copy mode) | Yank selection |
| `Prefix + r` | Reload tmux config |
| `Prefix + I` | Install plugins (TPM) |
| `< / >` | Swap windows left/right |

### sesh Picker (inside `Prefix + T`)

| Key | Filter |
|-----|--------|
| `Ctrl+A` | All sessions |
| `Ctrl+T` | tmux sessions only |
| `Ctrl+G` | Config directories |
| `Ctrl+X` | zoxide directories |
| `Ctrl+F` | fd file search |
| `Ctrl+D` | Kill selected session |

---

## Tool Details

### Ghostty
- Theme: `catppuccin-mocha` (built-in)
- Font: JetBrainsMono Nerd Font 14px
- `background-opacity = 0.95` + blur for translucency

### Zsh
- Vi mode with cursor shape change (beam in insert, block in normal)
- Carapace handles completions for 600+ CLIs
- zoxide replaces `cd` transparently
- Atuin replaces `Ctrl+R` with a fuzzy, syncable history TUI

### tmux + sesh
- TPM manages plugins
- `tmux-resurrect` + `tmux-continuum` auto-save sessions every 10 min
- `tmux-yank` integrates system clipboard with copy mode
- Catppuccin Mocha status bar with directory + session + time

### Starship
- Full Catppuccin Mocha palette defined inline
- Segments: OS → directory → git → language → docker → time
- `vimcmd_symbol` changes prompt to `❮` in vi normal mode

### Atuin
- `enter_accept = true` → Enter runs, Tab edits before running
- `search_mode = "fuzzy"` for forgiving history search
- Catppuccin theme (built-in, requires atuin ≥ 18)

### fzf
- Catppuccin Mocha colors applied via `FZF_DEFAULT_OPTS`
- Preview with `bat` (syntax-highlighted)
- Uses `fd` instead of `find` for speed

---

## After Install Checklist

- [ ] Open Ghostty — verify Catppuccin colors
- [ ] `tmux` → `Ctrl+Space + I` → install plugins
- [ ] `tmux` → `Ctrl+Space + r` → reload config
- [ ] Test `Ctrl+R` for Atuin history
- [ ] Test `cd` (zoxide) — it learns as you navigate
- [ ] Test `Ctrl+T` for fzf file picker
- [ ] Test `Ctrl+Space + T` for sesh session picker
- [ ] Optional: `atuin login` to sync history across machines
