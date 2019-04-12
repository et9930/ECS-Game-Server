-- 
-- File: \modules\after_join_match.lua
-- Created Date: 2019-04-10, 10:53:10
-- Author: Wang Chao (wangchao.1230@bytedance.com)
-- -----
-- Last Modified: 2019-04-10, 11:39:45
-- Modified By: Wang Chao (wangchao.1230@bytedance.com)
-- -----
-- 

local nk = require("nakama")
local storage = require("server_storage")
local inspect = require("inspect")

local function AfterJoinMatch(context, payload)
    print(inspect(context))
    print(inspect(payload))
    
end

nk.register_rt_after(AfterJoinMatch, "MatchJoin")
