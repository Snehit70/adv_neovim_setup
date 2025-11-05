# Neovim Configuration Tests

This directory contains tests for the Neovim configuration using `plenary.nvim` test framework.

## Prerequisites

Before running the tests, make sure you have `plenary.nvim` installed. Add it to your plugin configuration if not already present:

```lua
-- In your lazy.nvim plugin spec
{
  "nvim-lua/plenary.nvim",
  lazy = false,
}
```

## Running Tests

### Run all tests

```bash
nvim --headless -c "PlenaryBustedDirectory tests/ { minimal_init = 'init.lua' }"
```

### Run a specific test file

```bash
nvim --headless -c "PlenaryBustedFile tests/options_spec.lua"
```

### Run tests from within Neovim

```vim
:PlenaryBustedDirectory tests/
```

Or for a specific file:

```vim
:PlenaryBustedFile tests/options_spec.lua
```

## Test Files

- **init_spec.lua**: Tests for the main init.lua file
- **options_spec.lua**: Tests for vim options configuration
- **plugins_spec.lua**: Tests for plugin availability and configuration files
- **keymaps_spec.lua**: Tests for keymaps and leader key configuration

## Writing New Tests

Tests are written using the `plenary.busted` framework. Basic structure:

```lua
describe("Feature Name", function()
  it("should do something", function()
    assert.is_true(condition)
  end)
  
  it("should equal expected value", function()
    assert.are.same(expected, actual)
  end)
end)
```

### Available Assertions

- `assert.is_true(value)`
- `assert.is_false(value)`
- `assert.are.same(expected, actual)`
- `assert.is_not_nil(value)`
- `assert.has_error(function)`
- `pending("reason")` - Skip a test

### Test Lifecycle Hooks

- `before_each(function)` - Run before each test
- `after_each(function)` - Run after each test
- `setup(function)` - Run once before all tests
- `teardown(function)` - Run once after all tests

## Continuous Testing

You can set up a command to run tests quickly:

```lua
vim.api.nvim_create_user_command('TestConfig', function()
  vim.cmd('PlenaryBustedDirectory tests/')
end, {})
```

Then run `:TestConfig` from within Neovim.
