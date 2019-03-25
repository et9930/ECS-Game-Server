-- 
-- File: \modules\rpc_get_user_data.lua
-- Created Date: 2019-03-25, 18:50:26
-- Author: Wang Chao (wangchao.1230@bytedance.com)
-- -----
-- Last Modified: 2019-03-25, 20:18:37
-- Modified By: Wang Chao (wangchao.1230@bytedance.com)
-- -----
-- 

local nk = require("nakama")
local storage = require("server_storage")

local function GetUserData(context, payload)
    local user_data = {}
    local payload_table = nk.json_decode(payload)
    local user_id = payload_table.user_id
    user_data.username = storage.StorageRead(user_id, "user_data", "username")
    user_data.head_shot = storage.StorageRead(user_id, "user_data", "head_shot")
    user_data.user_level = storage.StorageRead(user_id, "user_data", "user_level")
    user_data.user_exp = storage.StorageRead(user_id, "user_data", "user_exp")
    user_data.battle_number = storage.StorageRead(user_id, "user_data", "battle_number")
    user_data.win_rate = storage.StorageRead(user_id, "user_data", "win_rate")
    user_data.ninja_number = storage.StorageRead(user_id, "user_data", "ninja_number")
    user_data.level_s = storage.StorageRead(user_id, "user_data", "level_s")
    user_data.level_a = storage.StorageRead(user_id, "user_data", "level_a")
    user_data.level_b = storage.StorageRead(user_id, "user_data", "level_b")
    user_data.level_c = storage.StorageRead(user_id, "user_data", "level_c")
    user_data.level_d = storage.StorageRead(user_id, "user_data", "level_d")
    return user_data
end

nk.register_rpc(GetUserData, "rpc_get_user_data")