local nvm_default_bin = vim.fn.expand("~/.nvm/versions/node/v*/bin")
local matches = vim.fn.glob(nvm_default_bin, true, true)

if #matches > 0 then
  -- Grab the first matching version (usually your active/default one)
  vim.env.PATH = matches[1] .. ":" .. vim.env.PATH
end
require("config.setting")
require("config.lazy")
require("config.mapping")
