-- 
-- File: \modules\before_match_data_send.lua
-- Created Date: 2019-04-28, 06:15:15
-- Author: Wang Chao (wangchao.1230@bytedance.com)
-- -----
-- Last Modified: 2019-05-16, 07:42:20
-- Modified By: Wang Chao (wangchao.1230@bytedance.com)
-- -----
-- 

local nk = require("nakama")
local storage = require("server_storage")
local inspect = require("inspect")

local function BeforeMatchDataSend(context, payload)
    local decode_data = nk.base64_decode(payload.match_data_send.data)
    local data_table = nk.json_decode(decode_data)
    local match_data = storage.Read(nil, "server_match", data_table.mid)
    local delta_time = nk.time() - match_data.match_start_time    
    local single_record = {
        time = delta_time,
        op_code = payload.match_data_send.op_code,
        data = decode_data
    }    
    local match_record = storage.Read(nil, "match_record", data_table.mid) or {}
    table.insert(match_record, single_record)
    storage.Write(nil, "match_record", data_table.mid, match_record, nil, 2, 1)
    -- local file = io.open("match_data/match_data_" .. data_table.mid .. ".replay", "a")
    -- file:write(delta_time .. " " .. decode_data .. "\n")
    -- file:close()    
    return payload
end

nk.register_rt_before(BeforeMatchDataSend, "MatchDataSend")