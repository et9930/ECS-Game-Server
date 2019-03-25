-- 
-- File: \modules\server_storage.lua
-- Created Date: 2019-03-25, 17:40:22
-- Author: Wang Chao (wangchao.1230@bytedance.com)
-- -----
-- Last Modified: 2019-03-25, 18:40:13
-- Modified By: Wang Chao (wangchao.1230@bytedance.com)
-- -----
-- 

local nk = require("nakama")

local M = {}

function M.StorageWrite(user_id, collection, key, value, version)
    local object_id = {
        {user_id = user_id, collection = collection, key = key, value = {value}, version = version}
    }

    nk.storage_write(object_id)
end

function M.StorageRead(user_id, collection, key)
    local object_id = {
        {user_id = user_id, collection = collection, key = key}
    }

    local objects = nk.storage_read(object_id)

    return objects[1].value
end

function M.StorageDelete(user_id, collection, key)
    local object_id = {
        {user_id = user_id, collection = collection, key = key}
    }

    nk.storage_delete(object_id)
end

return M
