-- 
-- File: \modules\after_join_match.lua
-- Created Date: 2019-04-10, 10:53:10
-- Author: Wang Chao (wangchao.1230@bytedance.com)
-- -----
-- Last Modified: 2019-04-16, 16:49:55
-- Modified By: Wang Chao (wangchao.1230@bytedance.com)
-- -----
-- 

local nk = require("nakama")
local storage = require("server_storage")

local function AfterJoinMatch(context, payload)
    -- local user_id = context.user_id
    -- local custom_match_id = storage.Read(user_id, "match_data", "custom_match_id")
    -- local match_data = storage.Read(nil, "server_match", custom_match_id)
    -- match_data.match_join_number = match_data.match_join_number + 1
    -- print("join_number " .. match_data.match_join_number)
    -- storage.Write(nil, "server_match", custom_match_id, match_data, nil, 2, 1)

    -- if match_data.match_join_number == match_data.match_size then
    --     for _, player in ipairs(match_data.match_player) do
    --         local notification_user_id = player.user_id
    --         local notification_context = {}
    --         nk.notification_send(notification_user_id, "match_all_join", notification_context, 500, nil, false)
    --     end
    -- end

end

nk.register_rt_after(AfterJoinMatch, "MatchJoin")
