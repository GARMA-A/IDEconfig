# LSP Configuration Structure

This setup organizes Language Server Protocol (LSP) configurations in a modular way.

## Directory Structure

```
lua/plugins/
├── lsp.lua                 # Main LSP configuration with keybindings and mason setup
└── lsp/                    # Language-specific LSP configurations
    ├── go.lua              # Go language server (go.nvim plugin)
    ├── js.lua              # JavaScript LSP configuration
    ├── ts.lua              # TypeScript LSP configuration
    ├── rust.lua            # Rust analyzer configuration
    ├── python.lua          # Python (Pyright) LSP configuration
    ├── c.lua               # C (Clangd) LSP configuration
    ├── cpp.lua             # C++ (Clangd) LSP configuration
    └── csharp.lua          # C# (OmniSharp) LSP configuration
```

## How It Works

1. **Main LSP Configuration** (`lsp.lua`):
   - Sets up core LSP functionality
   - Configures keybindings for LSP actions
   - Manages Mason tool installation
   - Imports and merges language-specific configurations

2. **Language-Specific Configurations** (`lsp/*.lua`):
   - Each file exports a table with server configurations
   - Contains language-specific settings and options
   - Imported by the main `lsp.lua` file

## Language Servers Included

- **Go**: `gopls` (via go.nvim plugin)
- **TypeScript/JavaScript**: `tsserver`
- **Rust**: `rust-analyzer`
- **Python**: `pyright`
- **C/C++**: `clangd`
- **C#**: `omnisharp`
- **HTML**: `html-lsp`
- **CSS**: `css-lsp`
- **Tailwind CSS**: `tailwindcss-language-server`
- **YAML**: `yaml-language-server`
- **Prisma**: `prisma-language-server`
- **SQL**: `sqlls`
- **Docker**: `dockerls`

## Adding New Languages

To add a new language server:

1. Create a new file in `lua/plugins/lsp/` (e.g., `newlang.lua`)
2. Export a table with server configuration:
   ```lua
   return {
       servername = {
           -- Server-specific configuration
           settings = {
               -- Settings for the language server
           },
       },
   }
   ```
3. Add the require and merge statements in `lsp.lua`
4. Add the server to Mason's ensure_installed list

## Keybindings

The following LSP keybindings are available when an LSP is attached:

- `gd` - Go to definition
- `gr` - Go to references  
- `gI` - Go to implementation
- `gD` - Go to declaration
- `<leader>D` - Type definition
- `<leader>ds` - Document symbols
- `<leader>ws` - Workspace symbols
- `<leader>rn` - Rename
- `<leader>ca` - Code action
- `<leader>th` - Toggle inlay hints