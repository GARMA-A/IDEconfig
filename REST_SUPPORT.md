# REST API Documentation Support

This configuration now includes comprehensive support for .rest files to document and test your API endpoints easily.

## Features

### File Recognition
- `.rest` and `.http` files are automatically recognized
- Proper syntax highlighting via `vim-http-syntax`

### LSP Autocompletion 
- Smart snippet-based completion for common HTTP operations
- Custom completion sources optimized for REST files
- Buffer-based autocompletion for existing variable names

### Available Snippets

| Trigger | Description |
|---------|-------------|
| `get` | GET request template |
| `post` | POST request template with JSON body |
| `put` | PUT request template with JSON body |
| `delete` | DELETE request template |
| `patch` | PATCH request template with JSON body |
| `auth` | Bearer authorization header |
| `basic` | Basic authentication header |
| `apikey` | API key header template |
| `json` | JSON content-type header |
| `form` | Form content-type header |
| `ua` | User-Agent header |
| `var` | Variable definition |
| `env` | Environment separator |
| `req` | Complete request template |

### Keymaps

When editing .rest files:

| Keymap | Action |
|--------|--------|
| `<leader>rr` | Run REST request under cursor |
| `<leader>rl` | Run last REST request |
| `<leader>rp` | Preview request as curl command |

### Usage Example

Create a file with `.rest` or `.http` extension:

```http
### Variables
@baseUrl = https://api.example.com
@token = your_auth_token_here

### Get all users
GET {{baseUrl}}/users
Content-Type: application/json
Authorization: Bearer {{token}}

### Create a new user
POST {{baseUrl}}/users
Content-Type: application/json

{
  "name": "John Doe",
  "email": "john@example.com"
}
```

### Configuration

The REST support is automatically configured when you open .rest files:

1. **Plugin**: Uses `rest-nvim/rest.nvim` for request execution
2. **Syntax**: Uses `nickel-lang/vim-http-syntax` for highlighting
3. **Completion**: Enhanced nvim-cmp configuration for HTTP files
4. **Snippets**: Custom LuaSnip snippets for common patterns

### Tips

- Use variables (`@name = value`) to avoid repetition
- Separate requests with `###` for better organization
- Use `{{variable}}` syntax to reference variables
- Snippet completion works in insert mode - type trigger and press Tab
- Buffer completion helps with existing variable names and URLs