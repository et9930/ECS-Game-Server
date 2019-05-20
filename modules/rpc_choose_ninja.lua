-- 
-- File: \modules\rpc_choose_ninja.lua
-- Created Date: 2019-04-15, 20:28:37
-- Author: Wang Chao (wangchao.1230@bytedance.com)
-- -----
-- Last Modified: 2019-05-16, 03:32:54
-- Modified By: Wang Chao (wangchao.1230@bytedance.com)
-- -----
-- 

local nk = require("nakama")
local storage = require("server_storage")
local inspect = require("inspect")

local function ChooseNinja(context, payload)
    local user_id = context.user_id
    local payload_table = nk.json_decode(payload)

    local custom_match_id = storage.Read(user_id, "match_data", "custom_match_id")
    local match_data = storage.Read(nil, "server_match", custom_match_id)
    local team = storage.Read(user_id, "match_data", "team")

    for index, player in ipairs(match_data.match_player) do
        local notification_user_id = player.user_id
        local notification_context = {
            user_id = user_id,
            confirm = payload_table.confirm
        }

        if player.team == team then
            notification_context.ninja_name = payload_table.ninja_name            
        else
            notification_context.ninja_name = ""
        end

        nk.notification_send(notification_user_id, "choose_ninja", notification_context, 503, nil, false)
    
        if player.user_id == user_id and payload_table.confirm == true and payload_table.ninja_name ~= "" then
            match_data.match_player[index].ninja_name = payload_table.ninja_name
            match_data.match_choose_finish_number = match_data.match_choose_finish_number + 1
        end
    end     

    if match_data.match_choose_finish_number == match_data.match_size then
        match_data.match_start_time = nk.time()
        -- local file = io.open("MatchData/MatchData_" .. match_data.custom_match_id, "r")
        for i = 1, #match_data.match_player do

            local match_list = storage.Read(match_data.match_player[i].user_id, "match_data", "match_list") or {}
            table.insert(match_list, match_data.custom_match_id)
            storage.Write(match_data.match_player[i].user_id, "match_data", "match_list", match_list, nil, 2, 1)
            
            local notification_user_id = match_data.match_player[i].user_id
            local notification_context = match_data
            nk.notification_send(notification_user_id, "match_start", notification_context, 504, nil, false)
        end        
    end

    storage.Write(nil, "server_match", custom_match_id, match_data, nil, 2, 1)

    return nk.json_encode({["result"] = true})

end

nk.register_rpc(ChooseNinja, "rpc_choose_ninja")