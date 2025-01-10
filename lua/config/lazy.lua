local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim" --config the lazynvim download path to C:/Users/xx/Appdata/local/nvim.data/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then  --这段代码的作用是检查路径 lazypath 是否不存在。如果路径不存在，则表达式返回 true，如果路径存在，则返回 false
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath }) -- vim.fn.system 执行 Git 命令时，会将命令输出（包括标准输出和标准错误输出）返回给 out 变量。也就是说，out 会包含 Git 克隆命令的执行结果，可以是成功的输出或者失败的错误信息。 
                                                                                                             -- 使用 Git 的 --filter=blob:none 参数来优化克隆过程，避免下载大文件内容。
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)
-- prepend 是一个用于修改 rtp 的方法，它将指定的路径添加到 runtimepath 的最前面。也就是说，lazypath 目录将被优先搜索，意味着 Neovim 在加载插件或文件时，会先搜索 lazypath 路径中的内容
-- vim.opt 是 Neovim 的一个 API，提供了对 Neovim 配置选项的访问和修改。
-- rtp 是 Neovim 中的一个选项，表示 runtime path（运行时路径）。它包含了 Neovim 启动时需要加载的目录和插件路径。通过设置 rtp，你可以控制 Neovim 在启动时搜索插件、脚本和其他资源的位置。
-- vim.opt.rtp 表示对 runtimepath 配置项的访问

require("lazy").setup({  --setup 是 lazy.nvim 插件提供的一个方法，用于配置和初始化插件管理器的设置。它接受一个表（table）作为参数，表中可以包含多个配置选项，这些选项会影响插件的加载行为、插件列表等。
  spec = {
    -- add LazyVim and import its plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins" }, -- https://github.com/LazyVim/LazyVim/tree/main 
                                                       -- LazyVim 是一个 Neovim 配置框架，旨在为用户提供一个快速、易于定制的基础配置，并使用 Lua 脚本来管理插件和设置。
    -- import/override with your plugins
    { import = "plugins" },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = {
    enabled = true, -- check for plugin updates periodically
    notify = false, -- notify on update
  }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
