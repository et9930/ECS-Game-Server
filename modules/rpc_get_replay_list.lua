-- 
-- File: \modules\rpc_get_replay_list.lua
-- Created Date: 2019-05-16, 07:30:45
-- Author: Wang Chao (wangchao.1230@bytedance.com)
-- -----
-- Last Modified: 2019-05-19, 03:06:17
-- Modified By: Wang Chao (wangchao.1230@bytedance.com)
-- -----
-- 

local nk = require("nakama")
local storage = require("server_storage")

local function GetReplayList(context, payload)
    local payload_table = nk.json_decode(payload)
    local user_id = payload_table.user_id
    print(user_id .. " get replay list")
    local replay_id_list = storage.Read(user_id, "match_data", "match_list") or {}
    local replay_list = {}
    for _, match_id in ipairs(replay_id_list) do
        local match_data = storage.Read(nil, "server_match", match_id)
        table.insert(replay_list, match_data)
    end
    return nk.json_encode({["replay_list"] = replay_list})
end

nk.register_rpc(GetReplayList, "rpc_get_replay_list")