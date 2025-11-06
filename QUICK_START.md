# Quick Start Guide - Vim Configuration

This is a condensed guide to get started with the `.vimrc` quickly.

## 🚀 Installation (3 Steps)

```bash
# 1. Copy .vimrc to your home directory
cp .vimrc ~/.vimrc

# 2. Open Vim (vim-plug will auto-install)
vim

# 3. Install plugins
:PlugInstall
```

That's it! Your Vim is now configured with all keymaps and plugins.

## 📝 Optional: LSP Support

For code intelligence (autocompletion, go-to-definition, etc.):

```vim
:CocInstall coc-tsserver coc-json coc-html coc-css coc-pyright coc-go
```

**Requirements:** Node.js 12.12+ must be installed.

## 🔑 Most Important Keymaps

### Changed Insert Mode
- `q` - Enter insert mode (instead of `i`)
- `Q` - Insert at start of line (instead of `I`)

### Navigation
- `w` - Move word backward (instead of `b`)
- `e` - Move word forward (instead of `w`)
- `}` - Scroll half page down
- `{` - Scroll half page up

### Leader Key (Space)
- `Space + sf` - Find files (fuzzy search)
- `Space + sg` - Search in files (grep)
- `Space + e` - Toggle file explorer
- `Space + u` - Toggle undo tree

### Window Management
- `Alt + ←/→/↑/↓` - Navigate between windows
- `Alt + -` - Toggle terminal

### Recording
- `m` - Start recording macro (instead of `q`)
- `b` - Set mark (instead of `m`)

## ⚡ Quick Commands

| Command | Description |
|---------|-------------|
| `:PlugUpdate` | Update all plugins |
| `:PlugClean` | Remove unused plugins |
| `:CocConfig` | Configure LSP |
| `:NERDTreeToggle` | Toggle file tree |
| `:Files` | Fuzzy find files |
| `:Rg` | Search in files |

## 🔧 Common Issues

### Clipboard Not Working
Install vim with clipboard support:
```bash
# Ubuntu/Debian
sudo apt install vim-gtk3

# macOS
brew install vim
```

### COC.NVIM Not Working
Ensure Node.js is installed:
```bash
node --version  # Should be 12.12+
```

### Plugins Not Installing
Check internet connection and run:
```vim
:PlugInstall!
```

## 📚 Full Documentation

- **Detailed Guide:** See `VIMRC_README.md`
- **Conversion Details:** See `CONVERSION_SUMMARY.md`

## 🎯 What You Get

✅ All keymaps from Neovim config  
✅ LSP support via coc.nvim  
✅ Fuzzy file finding via fzf  
✅ Git integration  
✅ Auto-completion  
✅ Syntax highlighting  
✅ File explorer  
✅ Undo tree  
✅ And much more!

## 🆘 Getting Help

1. Check `:help <command>` in Vim
2. Read `VIMRC_README.md` for details
3. View `.vimrc` comments for inline documentation

---

**Ready to code!** Just remember: `q` enters insert mode, not `i` 😉
