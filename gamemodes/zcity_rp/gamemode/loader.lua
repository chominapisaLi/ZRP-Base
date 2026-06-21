local function IncluderFunc(fileName)
	if (fileName:find("sv_")) then
		include(fileName)
	elseif (fileName:find("shared.lua") or fileName:find("sh_")) then
		if (SERVER) then
			AddCSLuaFile(fileName)
		end

		include(fileName)
	elseif (fileName:find("cl_")) then
		if (SERVER) then
			AddCSLuaFile(fileName)
		else
			include(fileName)
		end
	end
end

--прошу обратить внимание что файлы внутри папок загружаются первыми
local function LoadFromDir(directory)
	local files, folders = file.Find(directory .. "/*", "LUA")

	for _, v in ipairs(folders) do
		LoadFromDir(directory .. "/" .. v)
	end

	for _, v in ipairs(files) do
		IncluderFunc(directory .. "/" .. v)
	end
end

LoadFromDir("zcity_rp/gamemode/libraries")

zb.modesHooks = {}
zb.modes = zb.modes or {}

print("Z-City modes loaded!")
