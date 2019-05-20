-- 
-- File: \modules\rpc_get_match_data.lua
-- Created Date: 2019-04-10, 15:05:22
-- Author: Wang Chao (wangchao.1230@bytedance.com)
-- -----
-- Last Modified: 2019-05-16, 08:48:13
-- Modified By: Wang Chao (wangchao.1230@bytedance.com)
-- -----
-- 

local nk = require("nakama")
local storage = require("server_storage")

local function GetMatchData(context, payload)
    local payload_table = nk.json_decode(payload)
    local user_id = context.user_id
    print(user_id .. " get match data")
    local custom_match_id = storage.Read(user_id, "match_data", "custom_match_id")
    local match_data = storage.Read(nil, "server_match", custom_match_id)

    return nk.json_encode(match_data)
end

nk.register_rpc(GetMatchData, "rpc_get_match_data")