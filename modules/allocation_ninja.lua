-- 
-- File: \modules\allocation_ninja.lua
-- Created Date: 2019-04-14, 16:33:21
-- Author: Wang Chao (wangchao.1230@bytedance.com)
-- -----
-- Last Modified: 2019-04-15, 15:31:32
-- Modified By: Wang Chao (wangchao.1230@bytedance.com)
-- -----
-- 

local nk = require("nakama")
local storage = require("server_storage")
local M = {}
local allocation_number = 1

function M.AllocationNinja(match_data)
    local ninja_config = storage.Read(nil, "server_config", "ninja_config")
    local ninja_number = #ninja_config.ninjas
    local map_config = storage.Read(nil, "server_config", "map_config")
    local map_number = #map_config.maps
    
    -- random ninja list
    local ninja_list = {}
    for i = 1, ninja_number do
        ninja_list[i] = ninja_config.ninjas[i]
    end
    for i = ninja_number, 1, -1 do
        local random_ninja_index = math.random(1, ninja_number)
        local temp = ninja_list[i]
        ninja_list[i] = ninja_list[random_ninja_index]
        ninja_list[random_ninja_index] = temp
    end

    -- random map
    local random_map_index = math.random(1, map_number)
    local map = map_config.maps[random_map_index]

    for index, player in ipairs(match_data.match_player) do
        local notification_user_id = player.user_id
        local notification_context = {
            custom_match_id = match_data.custom_match_id,
            map = map,
            match_type = match_data.match_type,
            ninja_list = {}
        }
        local start_index = (index - 1) * allocation_number + 1
        local end_index = index * allocation_number

        for i = start_index, end_index do
            notification_context.ninja_list[i - start_index + 1] = ninja_list[i]
        end

        local log = player.user_id .. " allocation "
        for _, value in ipairs(notification_context.ninja_list) do
            log = log .. value.ninja_name .. " "
        end
        print(log)

        nk.notification_send(notification_user_id, "allocation_ninja", notification_context, 502, nil, false)
    end
end

return M