-- 
-- File: \modules\server_storage.lua
-- Created Date: 2019-03-25, 17:40:22
-- Author: Wang Chao (wangchao.1230@bytedance.com)
-- -----
-- Last Modified: 2019-04-14, 16:13:42
-- Modified By: Wang Chao (wangchao.1230@bytedance.com)
-- -----
-- 

local nk = require("nakama")
local M = {}

function M.Write(user_id, collection, key, value, version, permission_read, permission_write)
    local object_id = {
        {
            user_id = user_id, 
            collection = collection, 
            key = key, 
            value = {value = value}, 
            version = version, 
            permission_read = permission_read, 
            permission_write = permission_write
        }
    }
    nk.storage_write(object_id)
end

function M.Read(user_id, collection, key)
    local object_id = {
        {user_id = user_id, collection = collection, key = key}
    }

    local objects = nk.storage_read(object_id)
    if objects[1] == nil then
        return nil
    end
    return objects[1].value.value
end

function M.Delete(user_id, collection, key)
    local object_id = {
        {user_id = user_id, collection = collection, key = key}
    }

    nk.storage_delete(object_id)
end

return M
