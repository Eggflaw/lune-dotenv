local dotenv = {}

local fs = require("@lune/fs")
local process = require("@lune/process")

function dotenv:parse(str: string): { [string?]: string? }
	-- TODO: Parse dotenv and convert it into a table
	local env: { [string?]: string? } = {}

	local multiline = false
	local multilineKey = ""
	local multilineValue = ""
	for line in str:gmatch("([^\n]+)\n") do
		local key, value = line:match("(.+)=(.+)")

		if key and value then
			local firstChar = value:sub(1, 1)
			local lastChar = value:sub(#value, #value)
			if firstChar == '"' then
				-- [[
				-- #value == 1 is for keys that start with this
				-- KEY="
				-- FOO
				-- BAR
				-- "
				-- otherwise it will return "\""
				-- ]]
				if lastChar ~= '"' or #value == 1 then
					multiline = true
				end
			end

			if not multiline then
				value = value:gsub('^"(.*)"$', "%1")
				value = value:gsub("^'(.*)'$", "%1")

				env[key] = value
			else
				value = value:gsub('^"(.*)', "%1")
				multilineKey = key
				multilineValue = value
			end
		elseif multiline then
			local lastChar = line:sub(#line, #line)
			local escapeChar = line:sub(#line - 1, #line - 1)
			if lastChar == '"' and escapeChar ~= "\\" then
				line = line:gsub('(.*)"$', "%1")
				multilineValue = multilineValue .. "\n" .. line

				env[multilineKey] = multilineValue

				multiline = false
				multilineKey = ""
				multilineValue = ""
				continue
			end
			multilineValue = multilineValue .. "\n" .. line
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
