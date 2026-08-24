local mp = require 'mp'
local options = require 'mp.options'

local o = {
  enabled = "yes",
}
options.read_options(o, "filename")

local function set_vars()
    TheSocketFile = mp.get_property("options/input-ipc-server")
    TheSocketFile = TheSocketFile .. ".txt"
    MediaTitle = mp.get_property("media-title")
    if not MediaTitle then
        MediaTitle = mp.get_property("filename")
    end
end

local function write_filename()
    local current_file = io.open(TheSocketFile, "w+")
    current_file:write(MediaTitle .. "\n0\n")
    current_file:close()
end

local function remove_file()
    if TheSocketFile ~= nil then
        os.remove(TheSocketFile)
    end
end

if o.enabled == "yes" then
    mp.register_event("file-loaded", set_vars)
    mp.register_event("file-loaded", write_filename)
    mp.register_event("shutdown", remove_file)
end

mp.add_key_binding(nil, "write-filename", function() write_filename() end)
