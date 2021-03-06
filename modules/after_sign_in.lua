--
-- File: \modules\after_sign_in.lua
-- Created Date: 2019-03-25, 17:40:01
-- Author: Wang Chao (wangchao.1230@bytedance.com)
-- -----
-- Last Modified: 2019-03-25, 18:25:25
-- Modified By: Wang Chao (wangchao.1230@bytedance.com)
-- -----
--

local nk = require("nakama")
local storage = require("server_storage")

local function AfterSignIn(context, payload)
    local created = payload.created
    if (created ~= nil and created == true) then
        local user_id = context.user_id
        print(user_id .. " init data")
        storage.Write(user_id, "user_data", "username", context.username, nil, 2, 1)
        storage.Write(user_id, "user_data", "head_shot", "NamikazeMinato", nil, 2, 1)
        storage.Write(user_id, "user_data", "user_level", 1, nil, 2, 1)
        storage.Write(user_id, "user_data", "user_exp", 0, nil, 2, 1)
        storage.Write(user_id, "user_data", "battle_number", 0, nil, 2, 1)
        storage.Write(user_id, "user_data", "win_rate", 0, nil, 2, 1)
        storage.Write(user_id, "user_data", "ninja_number", 0, nil, 2, 1)
        storage.Write(user_id, "user_data", "level_s", 0, nil, 2, 1)
        storage.Write(user_id, "user_data", "level_a", 0, nil, 2, 1)
        storage.Write(user_id, "user_data", "level_b", 0, nil, 2, 1)
        storage.Write(user_id, "user_data", "level_c", 0, nil, 2, 1)
        storage.Write(user_id, "user_data", "level_d", 0, nil, 2, 1)
    end
end

nk.register_req_after(AfterSignIn, "AuthenticateEmail")