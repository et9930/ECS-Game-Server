-- 
-- File: \modules\before_sign_in.lua
-- Created Date: 2019-04-03, 17:19:55
-- Author: Wang Chao (wangchao.1230@bytedance.com)
-- -----
-- Last Modified: 2019-04-03, 20:35:33
-- Modified By: Wang Chao (wangchao.1230@bytedance.com)
-- -----
-- 

local nk = require("nakama")
local storage = require("server_storage")

local function BeforeSignIn(context, payload)
    local created = payload.create
    if (created ~= nil and created == true) then                
        local users = nk.users_get_username({payload.username})
        if #users > 0 then         
            return nil
        end
        return payload
    end
    return payload
end

nk.register_req_before(BeforeSignIn, "AuthenticateEmail")