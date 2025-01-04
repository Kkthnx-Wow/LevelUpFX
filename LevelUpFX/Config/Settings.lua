local _, namespace = ...

namespace:RegisterSettings("LevelUpFXDB", {
	{
		key = "enableAddon",
		type = "toggle",
		title = "Enable LevelUpFX",
		tooltip = "Enable or disable the LevelUpFX addon.",
		default = true,
	},
	{
		key = "cheerOnLevelUp",
		type = "toggle",
		title = "Cheer on Level Up",
		tooltip = "50% chance to perform the 'CHEER' emote when you level up.",
		default = false,
	},
	{
		key = "chatEmoteOnLevelUp",
		type = "toggle",
		title = "Send Level-Up Emote in Chat",
		tooltip = "Send a message to the chat indicating you leveled up.",
		default = false,
	},
	{
		key = "frameScale",
		type = "slider",
		title = "Frame Scale",
		tooltip = "Adjust the scale of the level-up notification frame.",
		default = 0.9,
		minValue = 0.5,
		maxValue = 1.0,
		valueStep = 0.1,
		valueFormat = "%.1f", -- Format value to 1 decimal place
	},
	{
		key = "frameAnchorX",
		type = "slider",
		title = "X Position",
		tooltip = "Adjust the horizontal position of the level-up notification frame.",
		default = 0,
		minValue = -500,
		maxValue = 500,
		valueStep = 1,
		valueFormat = "%d", -- Format value to whole number
		callback = function(value)
			if namespace.currentFrame then
				namespace.currentFrame:ClearAllPoints()
				namespace.currentFrame:SetPoint("CENTER", value, namespace:GetOption("frameAnchorY"))
			end
		end,
	},
	{
		key = "frameAnchorY",
		type = "slider",
		title = "Y Position",
		tooltip = "Adjust the vertical position of the level-up notification frame.",
		default = 0,
		minValue = -500,
		maxValue = 500,
		valueStep = 1,
		valueFormat = "%d", -- Format value to whole number
		callback = function(value)
			if namespace.currentFrame then
				namespace.currentFrame:ClearAllPoints()
				namespace.currentFrame:SetPoint("CENTER", namespace:GetOption("frameAnchorX"), value)
			end
		end,
	},
})

function UnlockFrame()
	LevelUpTest("test"); -- Display the test message.
	if not namespace.currentFrame then return end
	namespace.currentFrame:Show()
	namespace.currentFrame:SetMovable(true)
	namespace.currentFrame:EnableMouse(true)
	namespace.currentFrame:RegisterForDrag("LeftButton")
	-- Save the new position when the frame is moved
	namespace.currentFrame:SetScript("OnDragStart", function(self) self:StartMoving() end)
	namespace.currentFrame:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() local point, relativeTo, relativePoint, xOfs, yOfs = self:GetPoint() namespace:SetOption("frameAnchorX", xOfs) namespace:SetOption("frameAnchorY", yOfs) end)
end

namespace:RegisterOptionCallback("enableAddon", function(value)
	if not value then
		-- Hide the frame if the addon is disabled
		if namespace.currentFrame then
			namespace.currentFrame:Hide()
		end
		-- print("|cff5bc0beLevelUpFX|r |cffff0000disabled.|r")
	else
		-- print("|cff5bc0beLevelUpFX|r |cff00ff00enabled.|r")
	end
end)

namespace:RegisterOptionCallback("frameScale", function(value)
	if namespace.currentFrame then
		namespace.currentFrame:SetScale(value)
	end
end)

namespace:RegisterOptionCallback("cheerOnLevelUp", function(value)
	namespace.cheerEnabled = value
end)

namespace:RegisterOptionCallback("chatEmoteOnLevelUp", function(value)
	namespace.chatEmoteEnabled = value
end)
