local describe = require("@testing/describe")
local test = require("@testing/test")
local assertEq = require("@testing/assertEq")
local process = require("@lune/process")

local dotenv = require("../lib")

describe("Populate process.env", function()
	test("Normal", function()
		dotenv:load()
		assertEq(process.env.SIMPLE, "ABC")
		assertEq(process.env.DOUBLE, "DEF")
		assertEq(process.env.SINGLE, "GHI")
	end)

	test("Overwrite TRUE", function()
		process.env.OVERWRITE = "FOO"
		dotenv:load(true)
		assertEq(process.env.OVERWRITE, "BAR")
	end)

	test("Overwrite FALSE", function()
		process.env.OVERWRITE = "FOO"
		dotenv:load(false)
		assertEq(process.env.OVERWRITE, "FOO")
	end)

	test("Custom Path", function()
		dotenv:load(false, "tests/envs/path.env")
		assertEq(process.env.CUSTOM_PATH, "THIS IS A CUSTOM PATH")
	end)
end)
