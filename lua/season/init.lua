local M = {}
local uv = vim.uv
local json = vim.json
local session_dir = vim.fn.stdpath("data") .. "/season_sessions/"
local hash_file = session_dir .. "hash.json"

-- Default configurations.
M.config = {
	show_notifications = true,
}

-- Helper to print notifications.
local function notify(msg)
	if M.config.show_notifications then
		print(msg)
	end
end

-- Ensure the sessions directory exists.
local function ensure_dir()
	if not uv.fs_stat(session_dir) then
		uv.fs_mkdir(session_dir, 448)
	end
end

-- Generate a hash of the current working directory (CWD).
local function hash_cwd(cwd)
	return vim.fn.sha256(cwd)
end

-- Load the hash table from the hash.json file.
local function load_hashes()
	local file = io.open(hash_file, "r")
	if file then
		local content = file:read("*a")
		file.close(file)

		return json.decode(content) or {}
	else
		return {}
	end
end

-- Save the hash table back to hash.json.
local function save_hashes(hash_table)
	local file = io.open(hash_file, "w")

	if file then
		file:write(json.encode(hash_table))
		file:close()
	end
end

-- Get the session file path based on the current directory.
local function get_session_file()
	local hashes = load_hashes()
	local cwd = vim.fn.getcwd()
	local cwd_hash = hash_cwd(cwd)

	if not hashes[cwd_hash] then
		hashes[cwd_hash] = cwd
		save_hashes(hashes)
	end

	return session_dir .. cwd_hash .. ".nvim"
end

-- Save or update the session.
function M.save_session()
	ensure_dir()
	local session_file = get_session_file()
	vim.cmd("mksession! " .. vim.fn.fnameescape(session_file))
	notify("Session saved to: " .. session_file)
end

-- Load the session if available.
function M.load_session()
	local session_file = get_session_file()

	if uv.fs_stat(session_file) then
		vim.cmd("source " .. vim.fn.fnameescape(session_file))
		notify("Session loaded from: " .. session_file)
	else
		notify("No session found for this directory")
	end
end

-- Setup function.
function M.setup(user_config)
	M.config = vim.tbl_deep_extend("force", M.config, user_config or {})
end

return M
