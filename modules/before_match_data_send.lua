-- 
-- File: \modules\before_match_data_send.lua
-- Created Date: 2019-04-28, 06:15:15
-- Author: Wang Chao (wangchao.1230@bytedance.com)
-- -----
-- Last Modified: 2019-05-03, 05:34:49
-- Modified By: Wang Chao (wangchao.1230@bytedance.com)
-- -----
-- 

local nk = require("nakama")
local storage = require("server_storage")
local inspect = require("inspect")

local function BeforeMatchDataSend(context, payload)

    return payload
end

nk.register_rt_before(BeforeMatchDataSend, "MatchDataSend")