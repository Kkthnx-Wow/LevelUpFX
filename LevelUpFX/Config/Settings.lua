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
		key = "screenShotOnLevelUp",
		type = "toggle",
		title = "Screenshot on Level Up",
		tooltip = "Automatically take a screenshot one second after leveling up.",
		default = false,
	},
	{
		key = "screenShotEveryLevel",
		type = "toggle",
		title = "Screenshot Every Level",
		tooltip = "Take a screenshot for every level up, not just at specific levels.",
		default = false,
		requires = "screenShotOnLevelUp",
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
		key = "frameAnchorPoint",
		type = "menu",
		title = "Anchor Point",
		tooltip = "Select the anchor point for the level-up notification frame.",
		default = "CENTER",
		options = {
			{ value = "TOPLEFT", label = "Top Left" },
			{ value = "TOP", label = "Top" },
			{ value = "TOPRIGHT", label = "Top Right" },
			{ value = "LEFT", label = "Left" },
			{ value = "CENTER", label = "Center" },
			{ value = "RIGHT", label = "Right" },
			{ value = "BOTTOMLEFT", label = "Bottom Left" },
			{ value = "BOTTOM", label = "Bottom" },
			{ value = "BOTTOMRIGHT", label = "Bottom Right" },
		},
	},
	{
		key = "frameAnchorX",
		type = "slider",
		title = "X Position",
		tooltip = "Adjust the horizontal position of the level-up notification frame.",
		default = 0,
		minValue = GetScreenWidth() * -1,
		maxValue = GetScreenWidth(),
		valueStep = 1,
		valueFormat = "%d",
	},
	{
		key = "frameAnchorY",
		type = "slider",
		title = "Y Position",
		tooltip = "Adjust the vertical position of the level-up notification frame.",
		default = 400,
		minValue = GetScreenHeight() * -1,
		maxValue = GetScreenHeight(),
		valueStep = 1,
		valueFormat = "%d",
	},
	{
		key = "popupDuration",
		type = "slider",
		title = "Popup Duration",
		tooltip = "Adjust the duration of the level-up notification popup.",
		default = 2,
		minValue = 1,
		maxValue = 5,
		valueStep = 1,
		valueFormat = "%d",
	},
	{
		key = "welcomeMessage",
		type = "toggle",
		title = "Show Welcome Message",
		tooltip = "Show a welcome message with slash commands on first use.",
		default = true,
	},
})

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

namespace:RegisterOptionCallback("welcomeMessage", function(value)
	namespace.showWelcomeMessage = value
end)
