-- 
-- File: \modules\rpc_ping.lua
-- Created Date: 2019-03-22, 14:42:35
-- Author: Wang Chao (wangchao.1230@bytedance.com)
-- -----
-- Last Modified: 2019-03-22, 14:59:58
-- Modified By: Wang Chao (wangchao.1230@bytedance.com)
-- -----
-- 

local nk = require("nakama")

local function Ping(context, payload)
    return nk.json_encode({["pong"] = ""})
end

nk.register_rpc(Ping, "rpc_ping")