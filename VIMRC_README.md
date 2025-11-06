# Classic Vim Configuration (.vimrc)

This `.vimrc` file is a complete conversion of the Neovim Lua configuration to work with classic Vim (8.0+). It replicates most of the functionality from the modular Neovim setup.

## Quick Start

### Installation

1. **Copy the .vimrc to your home directory:**
   ```bash
   cp .vimrc ~/.vimrc
   ```

2. **Install vim-plug (plugin manager):**
   The .vimrc will auto-install vim-plug on first run, or you can install it manually:
   ```bash
   curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
   ```

3. **Open Vim and install plugins:**
   ```vim
   vim
   :PlugInstall
   ```

4. **For LSP support (optional but recommended):**
   After installing coc.nvim via `:PlugInstall`, install language servers:
   ```vim
   :CocInstall coc-tsserver coc-json coc-html coc-css coc-pyright coc-go
   ```

## Features Included

### ✅ Fully Converted Features

- **All keymaps** from `lua/config/keymaps.lua`
- **All vim options** from `lua/config/options.lua`
- **Global settings** (leader keys, etc.)
- **Autocmds** (filetype detection, formatting on save)
- **Custom functions** (terminal toggle, etc.)

### 🔄 Plugin Equivalents

The Neovim plugins have been replaced with classic Vim equivalents:

| Neovim Plugin | Vim Equivalent | Purpose |
|---------------|----------------|---------|
| lazy.nvim | vim-plug | Plugin manager |
| native LSP | coc.nvim | Language Server Protocol |
| nvim-treesitter | vim-polyglot | Syntax highlighting |
| telescope.nvim | fzf.vim | Fuzzy finder |
| oil.nvim | NERDTree | File explorer |
| mini.nvim (statusline) | vim-airline | Status line |
| gitsigns.nvim | vim-gitgutter | Git integration |
| nvim-cmp | coc.nvim | Autocompletion |

### ⚠️ Limited/Not Available

Some Neovim-specific features cannot be fully replicated in classic Vim:

- **CopilotChat** - The chat interface requires Neovim (basic copilot.vim is available)
- **Harpoon terminals** - Simplified to a basic terminal toggle
- **Advanced Lua plugins** - Some Neovim-only plugins don't have Vim equivalents
- **Native LSP features** - Using coc.nvim instead (which is excellent but different)

## Key Mappings

All custom keymaps from the Neovim config are preserved:

### Basic Navigation & Editing
- `q` → Enter insert mode (replaces `i`)
- `Q` → Insert at beginning of line (replaces `I`)
- `m` → Start recording macro (replaces `q`)
- `w` → Move backward by word (replaces `b`)
- `e` → Move forward by word (replaces `w`)
- `b` → Set mark (replaces `m`)

### Indentation
- `+` → Auto-indent (replaces `=`)
- `=` → Move down (replaces `+`)

### Page Navigation
- `}` → Half page down (replaces `Ctrl+d`)
- `{` → Half page up (replaces `Ctrl+u`)
- `Ctrl+d` → Next paragraph (replaces `}`)
- `Ctrl+e` → Previous paragraph (replaces `{`)

### Window Navigation
- `Alt+Left/Right/Up/Down` → Navigate between windows

### Leader Key Mappings (Space)
- `<leader>sf` → Find files (fzf)
- `<leader>sg` → Live grep (search in files)
- `<leader>sb` → List buffers
- `<leader>sh` → Search help tags
- `<leader>e` → Toggle NERDTree
- `<leader>u` → Toggle undo tree
- `<leader>wo` → Vertical split
- `<Alt-->` → Toggle bottom terminal

### LSP Keymaps (when coc.nvim is installed)
- `gd` → Go to definition
- `gy` → Go to type definition
- `gi` → Go to implementation
- `gr` → Find references
- `K` → Show documentation
- `<leader>rn` → Rename symbol
- `<leader>f` → Format code
- `<leader>ac` → Code actions
- `[d` / `]d` → Navigate diagnostics

## Language Support

The configuration includes support for:

- **Go** (via vim-go)
- **Zig** (via zig.vim)
- **TypeScript/JavaScript** (via coc-tsserver)
- **HTML/CSS** (via coc-html, coc-css, emmet-vim)
- **Python** (via coc-pyright)
- **YAML, Dockerfile** (syntax highlighting)
- **Markdown** (with preview support)
- And many more via vim-polyglot and coc.nvim extensions

## Plugin Manager Commands

### Installing Plugins
```vim
:PlugInstall
```

### Updating Plugins
```vim
:PlugUpdate
```

### Removing Unused Plugins
```vim
:PlugClean
```

### Check Plugin Status
```vim
:PlugStatus
```

## COC.NVIM Commands

### Install Language Server
```vim
:CocInstall coc-<language>
```

### Configure COC
```vim
:CocConfig
```

### Restart COC
```vim
:CocRestart
```

### List Extensions
```vim
:CocList extensions
```

## Customization

### Adding More Plugins

Edit `.vimrc` and add plugins between `call plug#begin()` and `call plug#end()`:

```vim
call plug#begin('~/.vim/plugged')
Plug 'username/plugin-name'
call plug#end()
```

Then run `:PlugInstall` in Vim.

### Changing Keymaps

Find the keymap section in `.vimrc` and modify as needed:

```vim
" Example: Change leader key
let mapleader = ","
```

### Changing Theme

Modify the colorscheme section:

```vim
colorscheme your-preferred-theme
```

## Troubleshooting

### Plugins Not Installing

1. Check internet connection
2. Ensure vim-plug is installed: `ls ~/.vim/autoload/plug.vim`
3. Try `:PlugInstall!` to force reinstall

### COC.NVIM Issues

1. Ensure Node.js is installed: `node --version` (12.12+ required)
2. Run `:CocInfo` to check status
3. Check `:CocOpenLog` for errors

### FZF Not Working

1. Install fzf system-wide:
   ```bash
   # Ubuntu/Debian
   sudo apt install fzf
   
   # macOS
   brew install fzf
   ```

2. Or let the plugin install it automatically (set in .vimrc)

### Clipboard Not Working

Ensure Vim is compiled with clipboard support:
```bash
vim --version | grep clipboard
```

If you see `-clipboard`, you need to install a Vim version with clipboard support:
```bash
# Ubuntu/Debian
sudo apt install vim-gtk3

# macOS
brew install vim
```

## Performance Tips

1. **Lazy-load plugins** - Many plugins in the .vimrc are configured to load only for specific filetypes
2. **Disable unused plugins** - Comment out plugins you don't need
3. **Reduce updatetime** - Adjust `set updatetime=250` if you experience lag

## Differences from Neovim Config

### Major Changes

1. **Plugin Manager**: lazy.nvim → vim-plug
2. **LSP**: Native Neovim LSP → coc.nvim
3. **Fuzzy Finder**: Telescope → FZF
4. **File Explorer**: Oil → NERDTree
5. **Syntax**: Treesitter → vim-polyglot

### Behavior Differences

- Some async features may be slower in Vim
- Floating windows behave differently
- Terminal integration is more basic
- Some advanced Neovim APIs are not available

## Upgrading from Neovim

If you're coming from the Neovim config:

1. Your muscle memory for keymaps will work identically
2. Most workflows will feel the same
3. LSP features work similarly through coc.nvim
4. Some advanced features (like Treesitter) are replaced with simpler alternatives

## Additional Resources

- [Vim Documentation](https://vimhelp.org/)
- [vim-plug Documentation](https://github.com/junegunn/vim-plug)
- [coc.nvim Documentation](https://github.com/neoclide/coc.nvim)
- [FZF.vim Documentation](https://github.com/junegunn/fzf.vim)

## Contributing

If you find issues or want to improve this configuration:

1. Test your changes with `vim -u .vimrc`
2. Ensure no syntax errors: `vim -u .vimrc -c 'echo "OK"' -c qa`
3. Document any new features in this README

## License

This configuration is based on the original Neovim setup and maintains the same structure and keybindings for consistency.
