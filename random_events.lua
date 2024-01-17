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
    ARMORED_TRUCK = 16,
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
  "Gang Convoy",
  "Store Robbery",
  "Gooch",
  "Weazel Bank Shootout",
  "Armoured Truck",
  "Possessed Animals",
  "Ghosts Exposed",
  "Happy Holidays Hauler"
}

selected_event = 0
selected_loc = 0
enable_esp = false

local fmmc_types = { 24, 26, 259, 273, 270, 269, 275, 286, 287, 266, 147, 268, 288, 290, 310, 311, 312, 320, 313, 323 }
local request_random_event_hash = -126218586
local gsbd_random_events = 1882037
local event_state
local event_loc
local event_coords
local trigger_range

function request_random_event(event_id, event_location)
    local args = {request_random_event_hash, 0, -1, event_id, 0, event_location, 0}
    network.trigger_script_event(-1, args)
end

script.register_looped("Random Events", function (script)
	event_state = globals.get_int(gsbd_random_events + 1 + (1 + (selected_event * 15)))
	event_loc = globals.get_int(gsbd_random_events + 1 + (1 + (selected_event * 15)) + 6)
	event_coords = globals.get_vec3(gsbd_random_events + 1 + (1 + (selected_event * 15)) + 10) -- It gets updated every 5 seconds
	trigger_range = globals.get_float(gsbd_random_events + 1 + (1 + (selected_event * 15)) + 13)
	
	tunables.set_bool('STANDARDCONTROLLERVOLUME', true) -- Slashers
	tunables.set_bool('STANDARDTARGETTINGTIME', true) -- Phantom Car
	tunables.set_int('SSP2POSIX', 1697101200) -- Thursday, 12 October 2023 09:00:00 GMT
	tunables.set_bool('ENABLE_SU22_SMUGGLER_TRAIL', true) -- R* has disabled it in 1.68 for some reason (was too buggy?)
	tunables.set_int('NC_SOURCE_TRUCK_HEAD_COUNT', 3) -- Cerberus
	tunables.set_bool('STANDARD_KEYBIND_SELECTION', true) -- Gooch
	tunables.set_bool('ENABLE_MAZEBANKSHOOTOUT_DLC22022', true)
	tunables.set_bool('ENABLE_HALLOWEEN_GHOSTHUNT', true)
	tunables.set_bool('ENABLE_HALLOWEEN_POSSESSED_ANIMAL', true)
	tunables.set_bool(2093114948, true) -- Happy Holidays Hauler
	
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
		GRAPHICS.DRAW_MARKER(28, event_coords.x, event_coords.y, event_coords.z, 0, 0, 0, 0, 180, 0, 200, 200, 200, 93, 182, 229, 40, true, true, 2, false, nil, nil, false) -- Blip appear range (same for all events)
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
			end

			ImGui.PopStyleColor()
		end

		ImGui.EndCombo()
	end
	
	selected_loc = ImGui.InputInt("Select Location", selected_loc)
	
	if ImGui.Button("Start Event") then
		script.run_in_fiber(function (script)
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
			script.run_in_fiber(function (script)
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
	
	if event_state ~= 0 and selected_event ~= random_events.PHANTOM_CAR and selected_event ~= random_events.SIGHTSEEING and selected_event ~= random_events.XMAS_MUGGER and selected_event ~= random_events.GHOSTHUNT then
		enable_esp = ImGui.Checkbox("ESP", enable_esp)
	else
		enable_esp = false
		ImGui.BeginDisabled()
		ImGui.Checkbox("ESP", enable_esp)
		ImGui.EndDisabled()
	end
	
	ImGui.Separator()
	
	ImGui.Text("State: " .. (event_state == 0 and "Inactive" or event_state == 1 and "Available" or event_state == 2 and "Active" or event_state == 3 and "Cleanup" or "None"))
	ImGui.Text("Location: " .. (event_loc ~= -1 and event_loc or "None"))
	ImGui.Text("Trigger Range: " .. math.floor(trigger_range) .. " meters")
end)