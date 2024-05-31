-- stylua: ignore
local describe = require("@testing/describe")
local test = require("@testing/test")
local assertEq = require("@testing/assertEq")
local process = require("@lune/process")
local fs = require("@lune/fs")

local dotenv = require("../lib")

local function readEnv(path)
	local content = fs.readFile(path)
	local env = dotenv:parse(content)
	return env
end

describe("Multiline", function()
	test("Normal", function()
		local env = readEnv("tests/envs/multiline.env")

		assertEq(env.NORMAL, "BAR\nFOO\nBAZ\n")
		assertEq(env.TEST_2, "\nBAR\nFOO\nBAZ\n")
		assertEq(env.WITH_ESC, 'FOO\nBAR\\"\nBAZ\n')
	end)
end)
