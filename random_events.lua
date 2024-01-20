random_events_tab = gui.get_tab("Random Events")

random_events = {
    DRUG_VEHICLE = 0,
    MOVIE_PROPS = 1,
    GOLDEN_GUN = 2,
    VEHICLE_LIST = 3,
    SLASHERS = 4,
    PHANTOM_CAR = 5,
    SIGHTSEEING = 6,
    SMUGGLER_TRAIL = 7,
    CERBERUS = 8,
    SMUGGLER_PLANE = 9,
    CRIME_SCENE = 10,
    METAL_DETECTOR = 11,
    CONVOY = 12,
    STORE_ROBBERY = 13,
    XMAS_MUGGER = 14,
    BANK_SHOOTOUT = 15,
    ARMOURED_TRUCK = 16,
    POSSESSED_ANIMALS = 17,
    GHOSTHUNT = 18,
    XMAS_TRUCK = 19
}

random_event_display_names = {
    "Drug Vehicle",
    "Movie Props",
    "Sleeping Guard",
    "Exotic Exports",
    "Slashers",
    "Phantom Car",
    "Sightseeing",
    "Smuggler Trail",
    "Cerberus",
    "Smuggler Plane",
    "Crime Scene",
    "Metal Detector",
    "Finders Keepers",
    "Store Robbery",
    "Gooch",
    "Weazel Bank Shootout",
    "Armored Truck",
    "Possessed Animals",
    "Ghosts Exposed",
    "Happy Holidays Hauler"
}

selected_event = 0
selected_loc = 0
enable_esp = false
enable_special_events = true

local fmmc_types = { 24, 26, 259, 273, 270, 269, 275, 286, 287, 266, 147, 268, 288, 290, 310, 311, 312, 320, 313, 323 }
local max_locations = { 29, 8, 9, 49, 7, 0, 25, 14, 11, 4, 9, 9, 6, 24, 0, 0, 9, 17, 8, 0 }
local blip_ranges = { 200, nil, 200, nil, nil, nil, nil, 400, nil, nil, 200, 200, 200, 100, nil, nil, 200, nil, nil, nil }
local request_random_event_hash = -126218586
local gsbd_random_events = 1882037
local gpbd_fm_2 = 1882422

local event_state
local event_loc
local event_coords
local trigger_range
local num_active_events
local max_events
local event_cooldown
local event_availability

function help_marker(text)
    ImGui.SameLine()
	ImGui.TextDisabled("(?)")
    if ImGui.IsItemHovered() then
        ImGui.BeginTooltip()
        ImGui.PushTextWrapPos(ImGui.GetFontSize() * 35)
        ImGui.TextUnformatted(text)
        ImGui.PopTextWrapPos()
        ImGui.EndTooltip()
	end
end

function get_num_active_events()
    local num_events = 0
    
    for i = 0, 19 do
        if globals.get_int(gpbd_fm_2 + (1 + (PLAYER.PLAYER_ID() * 142)) + 78 + 1 + (1 + (i * 3))) ~= 0 then
            num_events = num_events + 1
        end
    end
    
    return num_events
end

function get_event_cooldown(event)
	local cooldowns = {
		tunables.get_int("SUM22_RE_DRUG_VEHICLE_INACTIVE_TIME"),
		tunables.get_int("SUM22_RE_MOVIE_PROPS_INACTIVE_TIME"),
		tunables.get_int("SUM22_RE_GOLDEN_GUN_INACTIVE_TIME"),
		tunables.get_int("SUM22_RE_VEHICLE_LIST_INACTIVE_TIME"),
		tunables.get_int("STANDARDCONTROLLERVOLUME_COOLDOWN"),
		tunables.get_int("STANDARDTARGETTINGTIME"),
		tunables.get_int("SSP2_COOLDOWN"),
		tunables.get_int("SUM22_RE_SMUGGLER_TRAIL_INACTIVE_TIME"),
		tunables.get_int("NC_SOURCE_TRUCK_COOLDOWN"),
		tunables.get_int("SUM22_RE_SMUGGLER_PLANE_INACTIVE_TIME"),
		tunables.get_int("SUM22_RE_CRIME_SCENE_INACTIVE_TIME"),
		tunables.get_int("SUM22_RE_METAL_DETECTOR_INACTIVE_TIME"),
		tunables.get_int(-917017440),
		tunables.get_int(1373860254),
		tunables.get_int("STANDARD_KEYBIND_COOLDOWN"),
		tunables.get_int(1839585304),
		globals.get_int(262145 + 34272), -- Armored Truck (doesn't have a tunable)
		tunables.get_int("STANDARDCONTROLLERVOLUME_COOLDOWN"),
		tunables.get_int(-98345554),
		tunables.get_int(-1136431517)
	}
	
	return cooldowns[event]
end

function get_event_availability(event)
	local availabilities = {
		tunables.get_int("SUM22_RE_DRUG_VEHICLE_AVAILABLE_TIME"),
		tunables.get_int("SUM22_RE_MOVIE_PROPS_AVAILABLE_TIME"),
		tunables.get_int("SUM22_RE_GOLDEN_GUN_AVAILABLE_TIME"),
		tunables.get_int("SUM22_RE_VEHICLE_LIST_AVAILABLE_TIME"),
		tunables.get_int("STANDARDCONTROLLERVOLUME_AVAILABILITY"),
		tunables.get_int("STANDARDTARGETTINGTIME_AVAILABILITY"),
		tunables.get_int("SSP2_AVAILABILITY"),
		tunables.get_int("SUM22_RE_SMUGGLER_TRAIL_AVAILABLE_TIME"),
		tunables.get_int("NC_SOURCE_TRUCK_AVAILABILITY"),
		tunables.get_int("SUM22_RE_SMUGGLER_PLANE_AVAILABLE_TIME"),
		tunables.get_int("SUM22_RE_CRIME_SCENE_AVAILABLE_TIME"),
		tunables.get_int("SUM22_RE_METAL_DETECTOR_AVAILABLE_TIME"),
		tunables.get_int(1525434060),
		tunables.get_int(-1900341221),
		tunables.get_int("STANDARD_KEYBIND_AVAILABILITY"),
		tunables.get_int(-1555137323),
		globals.get_int(262145 + 34273), -- Armored Truck (doesn't have a tunable)
		tunables.get_int("STANDARDCONTROLLERVOLUME_AVAILABILITY"),
		tunables.get_int(-710010135),
		tunables.get_int(890076076)
	}
	
	return availabilities[event]
end

function request_random_event(event_id, event_location)
    local args = {request_random_event_hash, 0, -1, event_id, 0, event_location, 0}
    network.trigger_script_event(-1, args)
end

script.register_looped("Random Events", function(script)
	event_state = globals.get_int(gsbd_random_events + 1 + (1 + (selected_event * 15)))
	event_loc = globals.get_int(gsbd_random_events + 1 + (1 + (selected_event * 15)) + 6)
	event_coords = globals.get_vec3(gsbd_random_events + 1 + (1 + (selected_event * 15)) + 10) -- It gets updated every 5 seconds
	trigger_range = globals.get_float(gsbd_random_events + 1 + (1 + (selected_event * 15)) + 13)
	num_active_events = get_num_active_events()
	max_events = tunables.get_int("FMREMAXACTIVATEDEVENTS")
	event_cooldown = get_event_cooldown(selected_event + 1)
	event_availability = get_event_availability(selected_event + 1)
	
	tunables.set_int("STANDARDCONTROLLERVOLUME", enable_special_events and 1 or -1) -- Slashers
	tunables.set_int("STANDARDTARGETTINGTIME", enable_special_events and 1 or -1) -- Phantom Car
	tunables.set_int("SSP2POSIX", enable_special_events and 1697101200 or -1) -- Thursday, 12 October 2023 09:00:00 GMT
	tunables.set_bool("ENABLE_SU22_SMUGGLER_TRAIL", enable_special_events) -- R* has disabled it in 1.68 for some reason (was too buggy?)
	tunables.set_int("NC_SOURCE_TRUCK_HEAD_COUNT", enable_special_events and 3 or 1) -- Cerberus
	tunables.set_int("STANDARD_KEYBIND_SELECTION", enable_special_events and 1 or -1) -- Gooch
	tunables.set_bool("ENABLE_MAZEBANKSHOOTOUT_DLC22022", enable_special_events)
	tunables.set_bool("ENABLE_HALLOWEEN_GHOSTHUNT", enable_special_events)
	tunables.set_bool("ENABLE_HALLOWEEN_POSSESSED_ANIMAL", enable_special_events)
	tunables.set_bool(2093114948, enable_special_events) -- Happy Holidays Hauler
	
	if enable_esp and event_coords ~= vec3:new(0.0, 0.0, 0.0) then
		local player_coords = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), false)
		local distance = MISC.GET_DISTANCE_BETWEEN_COORDS(player_coords.x, player_coords.y, player_coords.z, event_coords.x, event_coords.y, event_coords.z, false)
		local km_or_m = (distance < 1000) and "m" or "km"
		local formatted_distance = (distance < 1000) and distance or (distance / 1000.0)
		local screen_coords_x = 0.0
		local screen_coords_y = 0.0
		
		_, screen_coords_x, screen_coords_y = GRAPHICS.GET_SCREEN_COORD_FROM_WORLD_COORD(event_coords.x, event_coords.y, event_coords.z, screen_coords_x, screen_coords_y)
		GRAPHICS.DRAW_LINE(player_coords.x, player_coords.y, player_coords.z, event_coords.x, event_coords.y, event_coords.z, 93, 182, 229, 255)
		GRAPHICS.REQUEST_STREAMED_TEXTURE_DICT("CommonMenu", false)
		GRAPHICS.DRAW_SPRITE("CommonMenu", "Common_Medal", screen_coords_x, screen_coords_y, 0.03, 0.06, 0.0, 93, 182, 229, 255, false, 0)
		HUD.BEGIN_TEXT_COMMAND_DISPLAY_TEXT("STRING")
		HUD.ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(string.format("%s (%.2f%s)", (event_state == 2 and "~HUD_COLOUR_GREEN~" or "") .. random_event_display_names[selected_event + 1] .. "~s~", formatted_distance, km_or_m))
		HUD.SET_TEXT_RENDER_ID(1)
		HUD.SET_TEXT_OUTLINE()
		HUD.SET_TEXT_CENTRE(true)
		HUD.SET_TEXT_DROP_SHADOW()
		HUD.SET_TEXT_SCALE(0, 0.3)
		HUD.SET_TEXT_FONT(4)
		HUD.SET_TEXT_COLOUR(255, 255, 255, 240)
		HUD.END_TEXT_COMMAND_DISPLAY_TEXT(screen_coords_x, screen_coords_y + -0.03, 0)
		GRAPHICS.DRAW_MARKER(28, event_coords.x, event_coords.y, event_coords.z, 0, 0, 0, 0, 180, 0, trigger_range, trigger_range, trigger_range, 0, 153, 51, 40, true, true, 2, false, nil, nil, false)		
		if blip_ranges[selected_event + 1] ~= nil then
			GRAPHICS.DRAW_MARKER(28, event_coords.x, event_coords.y, event_coords.z, 0, 0, 0, 0, 180, 0, blip_ranges[selected_event + 1], blip_ranges[selected_event + 1], blip_ranges[selected_event + 1], 93, 182, 229, 40, true, true, 2, false, nil, nil, false)
		end
	end
end)

random_events_tab:add_imgui(function()
	if ImGui.BeginCombo("Select Event", random_event_display_names[selected_event + 1]) then
		for i = 1, #random_event_display_names do
			local state = globals.get_int(gsbd_random_events + 1 + (1 + ((i - 1) * 15)))
			
			if state == 0 then
				ImGui.PushStyleColor(ImGuiCol.Text, 1, 0, 0, 1)
			elseif state == 1 then
				ImGui.PopStyleColor()
			elseif state == 2 then
				ImGui.PushStyleColor(ImGuiCol.Text, 0, 1, 0, 1)
			end

			if ImGui.Selectable(random_event_display_names[i], i - 1 == selected_event) then
				selected_event = i - 1
				selected_loc = 0
			end

			ImGui.PopStyleColor()
		end

		ImGui.EndCombo()
	end
	
	selected_loc, modified = ImGui.InputInt("Select Location (0-" .. max_locations[selected_event + 1] .. ")", selected_loc)
	
	if modified then
		selected_loc = math.min(math.max(selected_loc, 0), max_locations[selected_event + 1])
	end
	
	if num_active_events >= max_events then
		ImGui.Text("Active Events: ")
		ImGui.SameLine()
		ImGui.TextColored(1, 0, 0, 1, num_active_events .. "/" .. max_events)
	else
		ImGui.Text("Active Events: " .. num_active_events .. "/" .. max_events)
	end
	help_marker("Indicates the current number of active events out of the maximum allowed.")
	
	if ImGui.Button("Start Event") then
		script.run_in_fiber(function(script)
			request_random_event(fmmc_types[selected_event + 1], selected_loc)
			script:sleep(1000)
			if event_state >= 1 then
				gui.show_message("Random Events", "The event has been started successfully.")
			else
				gui.show_message("Random Events", "There has been an error while starting the event.")
			end
		end)
	end
	
	ImGui.SameLine()
	
	if selected_event ~= random_events.PHANTOM_CAR and selected_event ~= random_events.SIGHTSEEING and selected_event ~= random_events.XMAS_MUGGER and selected_event ~= random_events.GHOSTHUNT then
		if ImGui.Button("Teleport") then
			script.run_in_fiber(function(script)
				if event_state >= 1 then
					if event_coords ~= vec3:new(0.0, 0.0, 0.0) then
						PED.SET_PED_COORDS_KEEP_VEHICLE(PLAYER.PLAYER_PED_ID(), event_coords.x, event_coords.y, event_coords.z)
					else
						gui.show_message("Random Events", "Wait for coordinates to be updated.")
					end
				else
					gui.show_message("Random Events", "The event is not active.")
				end
			end)
		end
	else
		ImGui.BeginDisabled()
		ImGui.Button("Teleport")
		ImGui.EndDisabled()
	end
	
	ImGui.Separator()
	
	if event_state ~= 0 and selected_event ~= random_events.PHANTOM_CAR and selected_event ~= random_events.SIGHTSEEING and selected_event ~= random_events.XMAS_MUGGER and selected_event ~= random_events.GHOSTHUNT then
		enable_esp = ImGui.Checkbox("ESP", enable_esp)
		help_marker("Displays information about the event graphically:\n- The green sphere represents the trigger range\n- The blue sphere represents the blip appearance range (if applicable)")
	else
		enable_esp = false
		ImGui.BeginDisabled()
		ImGui.Checkbox("ESP", enable_esp)
		ImGui.EndDisabled()
	end
	
	enable_special_events = ImGui.Checkbox("Enable Special Events", enable_special_events)
	help_marker("Enables the special events that are normally disabled:\n- Slashers\n- Phantom Car\n- Sightseeing\n- Smuggler Trail\n- Cerberus\n- Gooch\n- Weazel Bank Shootout\n- Ghosts Exposed\n- Possessed Animals\n- Happy Holidays Hauler")
	
	ImGui.Separator()
	
	ImGui.Text("State: " .. (event_state == 0 and "Inactive" or event_state == 1 and "Available" or event_state == 2 and "Active" or event_state == 3 and "Cleanup" or "None"))
	help_marker("Indicates the current state of the event:\n- Inactive\n- Available\n- Active\n- Cleanup")
	
	ImGui.Text("Location: " .. (event_loc ~= -1 and event_loc or "None"))
	help_marker("Shows the current location of the event or indicates 'None' if no location is available.")
	
	ImGui.Text("Trigger Range: " .. (event_state >= 1 and math.floor(trigger_range) .. " meters" or "None"))
	help_marker("Specifies the distance required to trigger the event when available, or shows 'None' if the event is inactive.")
	
	ImGui.Text("Blip Appearance Range: " .. ((event_state >= 1 and blip_ranges[selected_event + 1] ~= nil) and math.floor(blip_ranges[selected_event + 1]) .. " meters" or "None"))
	help_marker("Specifies the distance for the blip to appear when approaching the event, or shows 'None' if not applicable.")
	
	ImGui.Text("Cooldown: " .. event_cooldown .. "ms (" .. math.floor(event_cooldown / 60000) .. " minutes)")
	help_marker("Indicates the time that must pass since session creation for the event to be available.\nDisplayed in milliseconds and minutes.")
	
	ImGui.Text("Availability: " .. event_availability .. "ms (" .. math.floor(event_availability / 60000) .. " minutes)")
	help_marker("Indicates the duration the event will be in the available state.\nDisplayed in milliseconds and minutes.")
end)