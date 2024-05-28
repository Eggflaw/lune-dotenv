# lune-dotenv
A dotenv parser for Lune

lune-dotenv loads environtment variables from a `.env` file and adds them into `process.env`.
> [!WARNING]
> lune-dotenv is still in-development. Some features aren't implemented yet and there might be breaking changes to the API in the future.

* [Installtation](#installation)
* [Usage](#usage)
* [API](#api)
* [TODO](#todo)


## Installation
### Wally
Coming soon.

### Git submodules
```
git submodule add  https://github.com/Eggflaw/lune-dotenv.git
```
## Usage
Create a `.env` file into the root directory of your project.
```env
OPENCLOUD_KEY=OPENCLOUDKEYHERE
SECRETS="SECRETS"
```
You can now load the `.env` file with lune-dotenv
```lua
local process = require("@lune/process")
local dotenv = require("Packages/lune-dotenv") -- Assuming you added lune-dotenv into Packages/

dotenv:load() -- Must come before accessing process.env
print(process.env.OPENCLOUD_KEY) -- Remove after you confirmed it's working

```
## API
### `dotenv:load(overwrite: boolean?, path: string?)`
Loads a `.env` file and add it into `process.env`

By default, `load` will find a `.env` file in the current working directory

If there is an environment variable with the same key name,  lune-dotenv will not overwrite it.
<br>
Set `overwrite` to true to avoid this.

```lua

dotenv:load(false)
print(process.env.HOME) -- "/home/yourname"

--============--

dotenv:load(true)
print(process.env.HOME) -- "NEWHOME"

```

You can give `load` a custom path instead of finding a `.env` in the current directory
```lua
dotenv:load(false, "tests/envs/path.env")
print(process.env.CUSTOM_PATH)
```

### `dotenv:parse(str: string): { [string?]: string? }`
Parse `.env` content and convert it into a table. <br>
Use this if you don't want to load `.env` into `process.env`

```lua
local content = fs.readFile(".env")

local env = dotenv:parse(content)
print(env)
```

## TODO
- [x] Basic values
- [ ] Multiline values
- [ ] Comments
- [ ] Variable Substitution
- [ ] Command Substitution
- [ ] Exports

References:
- https://rubydoc.info/github/bkeepers/dotenv/main#multi-line-values
- https://github.com/motdotla/dotenv?tab=readme-ov-file#%EF%B8%8F-usage
