local dotenv = {}

local fs = require("@lune/fs")
local process = require("@lune/process")

function dotenv:parse(str: string): { [string?]: string? }
	-- TODO: Parse dotenv and convert it into a table
	local env: { [string?]: string? } = {}

	for line in str:gmatch("([^\n]+)\n") do
		local key, value = line:match("(.+)=(.+)")
		if key and value then
			value = value:gsub('^"(.*)"$', "%1")
			value = value:gsub("^'(.*)'$", "%1")

			env[key] = value
		end
	end

	return env
end

function dotenv:load(overwrite: boolean?, path: string?)
	-- TODO:  call parse() and add it into process.env
	local target = path or ".env"

	local file = fs.readFile(target)

	local env = dotenv:parse(file)

	for key, value in env do
		if not process.env[key] or overwrite then
			process.env[key] = value
		end
	end
end

return dotenv
