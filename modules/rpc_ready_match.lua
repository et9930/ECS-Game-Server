-- 
-- File: \modules\rpc_ready_match.lua
-- Created Date: 2019-04-12, 14:07:15
-- Author: Wang Chao (wangchao.1230@bytedance.com)
-- -----
-- Last Modified: 2019-04-15, 10:54:03
-- Modified By: Wang Chao (wangchao.1230@bytedance.com)
-- -----
-- 

local nk = require("nakama")
local storage = require("server_storage")
local allocation = require("allocation_ninja")

local function FindMatchData(user_id)
    local custom_match_id = storage.Read(user_id, "match_data", "custom_match_id")
    if custom_match_id ~= nil then
        local match_data = storage.Read(nil, "server_match", custom_match_id)
        if match_data ~= nil then
            return match_data
        end
    end
    return nil
end

local function ReadyMatch(context, payload)

    local user_id = context.user_id
    local payload_table = nk.json_decode(payload)

    -- find match data
    local custom_match_id = storage.Read(user_id, "match_data", "custom_match_id")
    local match_data = FindMatchData(user_id) 
     
    if match_data == nil then
        if payload_table.ready == false then
            -- delete old match data
            print(user_id .. " leave match")
            storage.Delete(user_id, "match_data", "ready")
            storage.Delete(user_id, "match_data", "custom_match_id")
            return nk.json_encode({["result"] = true})
        end
    else
        if payload_table.ready == true then
            print(user_id .. " match ready")
            local old_ready_state = storage.Read(user_id, "match_data", "ready")
            if old_ready_state == true then
                return nk.json_encode({["result"] = false})
            end
            match_data.match_ready_number = match_data.match_ready_number + 1
            storage.Write(nil, "server_match", custom_match_id, match_data, nil, 2, 1)
            storage.Write(user_id, "match_data", "ready", true, nil, 2, 1)
        else
            print(user_id .. " match cancal")
            storage.Delete(nil, "server_match", custom_match_id)
        end    
    end
    
    for i = 1, #match_data.match_player do
        local notification_user_id = match_data.match_player[i].user_id
        local notification_context = {
            custom_match_id = custom_match_id,
            ready_state = payload_table.ready,
            ready_number = match_data.match_ready_number,
        }
        nk.notification_send(notification_user_id, "match_ready", notification_context, 501, nil, false)
    end      

    if match_data.match_ready_number == match_data.match_size then
        allocation.AllocationNinja(match_data)
    end
    
    return nk.json_encode({["result"] = true})
end

nk.register_rpc(ReadyMatch, "rpc_ready_match")

