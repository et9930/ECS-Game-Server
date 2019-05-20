-- 
-- File: \modules\rpc_get_match_replay.lua
-- Created Date: 2019-05-16, 08:16:50
-- Author: Wang Chao (wangchao.1230@bytedance.com)
-- -----
-- Last Modified: 2019-05-16, 09:04:48
-- Modified By: Wang Chao (wangchao.1230@bytedance.com)
-- -----
-- 

local nk = require("nakama")
local storage = require("server_storage")

local function GetMatchReplay(context, payload)
    local payload_table = nk.json_decode(payload)
    local match_id = payload_table.match_id
    local match_record = storage.Read(nil, "match_record", match_id) or {}
    return nk.json_encode({["match_record"] = match_record})
end

nk.register_rpc(GetMatchReplay, "rpc_get_match_replay")