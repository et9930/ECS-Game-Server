--
-- File: \modules\matchmaker_matched.lua
-- Created Date: 2019-04-10, 14:02:26
-- Author: Wang Chao (wangchao.1230@bytedance.com)
-- -----
-- Last Modified: 2019-04-10, 14:02:39
-- Modified By: Wang Chao (wangchao.1230@bytedance.com)
-- -----
--

local nk = require("nakama")
local storage = require("server_storage")

local function MatchmakerMatched(context, matchmaker_users)
    local custom_match_id = nk.uuid_v4()
    local left_team_number = {
        #matchmaker_users / 2,
        #matchmaker_users / 2
    }
    local team_number = {
        0,
        0
    }
    local match_type = 0

    -- match type
    for i = 1, #matchmaker_users do
        if matchmaker_users[i].properties.matchType ~= 0 then
            match_type = matchmaker_users[i].properties.matchType
            break
        end
    end
    if match_type == 0 then
        match_type = math.random(1, 3)
    end

    local match_data = {
        custom_match_id = custom_match_id,
        match_type = match_type,
        match_size = #matchmaker_users,
        match_player = {},
        match_ready_number = 0,
        match_choose_finish_number = 0,
        match_random_seed = math.random(10000)
    }
    
    for i = 1, #matchmaker_users do
        local match_player_info = {}

        local user_id = matchmaker_users[i].presence.user_id

        -- user team
        local team = math.random(1, 2)        
        if left_team_number[team] == 0 then
            team = 3 - team
        end
        left_team_number[team] = left_team_number[team] - 1

        team_number[team] = team_number[team] + 1        

        local ready = false
        
        match_player_info.user_id = user_id
        match_player_info.team = team
        match_player_info.position = team_number[team] + (team - 1) * 4 - 1

        match_data.match_player[i] = match_player_info

        storage.Write(user_id, "match_data", "custom_match_id", custom_match_id, nil, 2, 1)
        storage.Write(user_id, "match_data", "ready", ready, nil, 2, 1)
        storage.Write(user_id, "match_data", "team", team, nil, 2, 1)
    end

    storage.Write(nil, "server_match", custom_match_id, match_data, nil, 2, 1)

    return nil
end
nk.register_matchmaker_matched(MatchmakerMatched)
