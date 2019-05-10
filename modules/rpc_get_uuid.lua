-- 
-- File: \modules\rpc_get_uuid.lua
-- Created Date: 2019-05-09, 02:14:52
-- Author: Wang Chao (wangchao.1230@bytedance.com)
-- -----
-- Last Modified: 2019-05-09, 02:18:02
-- Modified By: Wang Chao (wangchao.1230@bytedance.com)
-- -----
-- 

local nk = require("nakama")

local function GetUuid(context, payload)
    return nk.json_encode({["uuid"] = nk.uuid_v4()})
end

nk.register_rpc(GetUuid, "rpc_get_uuid")