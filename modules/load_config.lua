-- 
-- File: \modules\load_config.lua
-- Created Date: 2019-04-14, 17:03:12
-- Author: Wang Chao (wangchao.1230@bytedance.com)
-- -----
-- Last Modified: 2019-04-15, 11:22:51
-- Modified By: Wang Chao (wangchao.1230@bytedance.com)
-- -----
-- 

local nk = require("nakama")
local storage = require("server_storage")

local config_list = {
    "ninja_config",
    "map_config"
}

local function LoadConfig()
    for _, value in ipairs(config_list) do
        local file, err = io.open("configs/" .. value .. ".json", "r")    
        local config_string = file:read("*all")
        local config_table = nk.json_decode(config_string)
        storage.Write(nil, "server_config", value, config_table, nil, 2, 1)
        print("Load config : configs/" .. value .. ".json")
    end
end

nk.run_once(LoadConfig)