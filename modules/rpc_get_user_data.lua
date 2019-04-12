-- 
-- File: \modules\rpc_get_user_data.lua
-- Created Date: 2019-03-25, 18:50:26
-- Author: Wang Chao (wangchao.1230@bytedance.com)
-- -----
-- Last Modified: 2019-04-10, 14:54:40
-- Modified By: Wang Chao (wangchao.1230@bytedance.com)
-- -----
-- 

local nk = require("nakama")
local storage = require("server_storage")

local function GetUserData(context, payload)
    local user_data = {}
    local payload_table = nk.json_decode(payload)
    local user_id = payload_table.user_id
    print(user_id .. " get data")
    user_data.username = storage.Read(user_id, "user_data", "username")
    user_data.head_shot = storage.Read(user_id, "user_data", "head_shot")
    user_data.user_level = storage.Read(user_id, "user_data", "user_level")
    user_data.user_exp = storage.Read(user_id, "user_data", "user_exp")
    user_data.battle_number = storage.Read(user_id, "user_data", "battle_number")
    user_data.win_rate = storage.Read(user_id, "user_data", "win_rate")
    user_data.ninja_number = storage.Read(user_id, "user_data", "ninja_number")
    user_data.level_s = storage.Read(user_id, "user_data", "level_s")
    user_data.level_a = storage.Read(user_id, "user_data", "level_a")
    user_data.level_b = storage.Read(user_id, "user_data", "level_b")
    user_data.level_c = storage.Read(user_id, "user_data", "level_c")
    user_data.level_d = storage.Read(user_id, "user_data", "level_d")
    return nk.json_encode(user_data)
end

nk.register_rpc(GetUserData, "rpc_get_user_data")