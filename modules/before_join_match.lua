-- 
-- File: \modules\before_join_match.lua
-- Created Date: 2019-04-10, 10:50:04
-- Author: Wang Chao (wangchao.1230@bytedance.com)
-- -----
-- Last Modified: 2019-04-16, 14:20:30
-- Modified By: Wang Chao (wangchao.1230@bytedance.com)
-- -----
-- 

local nk = require("nakama")
local storage = require("server_storage")
local inspect = require("inspect")

local function BeforeJoinMatch(context, payload)
    -- print(inspect(context))
    -- print(inspect(payload))
    return payload
end

nk.register_rt_before(BeforeJoinMatch, "MatchJoin")