# Modular Neovim Configuration

This configuration has been organized into a modular structure for better maintainability and organization.

## Structure

```
├── init.lua                    # Main entry point (13 lines)
├── init_original.lua          # Backup of original monolithic file
└── lua/
    ├── config/                # Core configuration modules
    │   ├── globals.lua        # Global settings & leader keys
    │   ├── options.lua        # Vim options & settings
    │   ├── keymaps.lua        # Key mappings & custom functions
    │   ├── autocmds.lua       # Autocommands for filetypes
    │   └── lazy.lua           # Lazy.nvim plugin manager setup
    └── plugins/               # Plugin configurations
        ├── go.lua             # Go development tools
        ├── zig.lua            # Zig development tools
        ├── lsp.lua            # Language Server Protocol setup
        ├── misc.lua           # Utility plugins (colorizer, etc.)
        ├── treesitter.lua     # Syntax highlighting
        ├── telescope.lua      # Fuzzy finder
        ├── completion.lua     # Autocompletion & snippets
        ├── formatting.lua     # Code formatting
        ├── oil.lua            # File manager
        ├── copilot.lua        # AI assistance
        ├── git.lua            # Git integration
        └── ui.lua             # Themes & interface
```

## Benefits

- **Maintainable**: Each component is focused and easy to find
- **Modular**: Enable/disable features by adding/removing plugin files
- **Organized**: Clear separation between core config and plugins
- **Readable**: Much easier to navigate and understand
- **Same functionality**: All original features preserved exactly

## Supported Languages

This configuration includes full development support for:

- **Go**: LSP (gopls), formatting (gofumpt), debugging, testing
- **Zig**: LSP (zls), formatting (zig fmt), syntax highlighting, code snippets
- **TypeScript/JavaScript**: LSP (ts_ls), ESLint, Prettier formatting
- **HTML/CSS**: LSP, Tailwind CSS support, formatting
- **Python**: LSP, Black formatting
- **C/C++**: LSP, clang-format
- **C#**: LSP (OmniSharp), .NET support
- **SQL**: LSP (sqlls), pg_format
- **YAML/Docker**: LSP support
- **Prisma**: LSP for database schema
- **Lua**: LSP (lazydev), stylua formatting

## How it works

1. `init.lua` loads the core configuration modules in order:
   - `config.globals` - Sets up leader keys and global settings
   - `config.options` - Configures vim options
   - `config.keymaps` - Sets up all key mappings
   - `config.autocmds` - Configures autocommands
   - `config.lazy` - Bootstraps lazy.nvim and loads plugins

2. Lazy.nvim automatically loads all files in the `lua/plugins/` directory

## Customization

- To disable a plugin: Remove or rename the corresponding file in `lua/plugins/`
- To modify keymaps: Edit `lua/config/keymaps.lua`
- To change vim options: Edit `lua/config/options.lua`
- To add new plugins: Create a new file in `lua/plugins/`

## Migration

This modular structure maintains 100% compatibility with the original configuration.
The original 1351-line file has been preserved as `init_original.lua` for reference.