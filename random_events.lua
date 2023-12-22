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
	XMAS_TRUCK = 19,
}

local selected_event = 0
local selected_loc = 0
local set_trigger_zone = 0.0

local event_state
local event_loc
local event_coords
local trigger_zone
local event_ids = { 24, 26, 259, 273, 270, 269, 275, 286, 287, 266, 147, 268, 288, 290, 310, 311, 312, 320, 313, 323 }
local event_hash = -126218586
local gsbd_randomevents = 1882037

function help_marker(text)
    ImGui.TextDisabled("(?)")
    if ImGui.IsItemHovered() then
        ImGui.BeginTooltip()
        ImGui.PushTextWrapPos(ImGui.GetFontSize() * 35)
        ImGui.TextUnformatted(text)
        ImGui.PopTextWrapPos()
        ImGui.EndTooltip()
	end
end

function start_event(event_id, event_location)
    local args = {event_hash, 0, -1, event_id, 0, event_location, 0}
    network.trigger_script_event(-1, args)
end

script.register_looped("Random Events", function (script)
	event_state = globals.get_int(gsbd_randomevents + 1 + (1 + (selected_event * 15)))
	event_loc = globals.get_int(gsbd_randomevents + 1 + (1 + (selected_event * 15)) + 6)
	event_coords = globals.get_vec3(gsbd_randomevents + 1 + (1 + (selected_event * 15)) + 10)
	trigger_zone = globals.get_float(gsbd_randomevents + 1 + (1 + (selected_event * 15)) + 13)
	tunables.set_int(1470797531, 1) -- Slashers
	tunables.set_int(-167641066, 3) -- Phantom Car
	tunables.set_int('SSP2POSIX', 1697101200)
	tunables.set_int('ENABLE_SU22_SMUGGLER_TRAIL', 1) -- R* has disabled it in 1.68 for some reason (was too buggy?)
	tunables.set_int(-2122185994, 1) -- Cerberus
	tunables.set_int(-2035583969, 1) -- Gooch
	tunables.set_int('ENABLE_MAZEBANKSHOOTOUT_DLC22022', 1)
	tunables.set_int('ENABLE_HALLOWEEN_GHOSTHUNT', 1)
	tunables.set_int('ENABLE_HALLOWEEN_POSSESSED_ANIMAL', 1)
	tunables.set_int('ENABLE_HALLOWEEN_GHOSTHUNT', 1)
	tunables.set_int(2093114948, 1) -- Happy Holidays Hauler
end)

random_events_tab:add_imgui(function()	
	selected_event = ImGui.Combo("Select Event", selected_event, { "Drug Vehicle", "Movie Props", "Sleeping Guard", "Exotic Exports", "Slashers", "Phantom Car", "Sightseeing", "Smuggler Trail", "Cerberus", "Smuggler Plane", "Crime Scene", "Metal Detector", "Gang Convoy", "Store Robbery", "Gooch", "Weazel Bank Shootout", "Armoured Truck", "Possessed Animals", "Ghosts Exposed", "Happy Holidays Hauler" }, 20, 10)
	
	selected_loc = ImGui.InputInt("Select Location", selected_loc)
	ImGui.SameLine()
	help_marker("If you input an invalid location, the event will fail to start.")
	
	set_trigger_zone, modified = ImGui.InputFloat("Set Trigger Zone", set_trigger_zone)
	ImGui.SameLine()
	help_marker("Determines the distance you need to get closer to trigger the event.")
	
	if modified then
		globals.set_float(gsbd_randomevents + 1 + (1 + (selected_event * 15)) + 13, set_trigger_zone)
	end
	
	if ImGui.Button("Start Event") then
		script.run_in_fiber(function (script)
			start_event(event_ids[selected_event + 1], selected_loc)
			gui.show_message("Random Events", "The event has been started successfully.")
		end)
	end
	
	ImGui.SameLine()
	
	if selected_event ~= random_events.VEHICLE_LIST and selected_event ~= random_events.PHANTOM_CAR and selected_event ~= random_events.SIGHTSEEING and selected_event ~= random_events.XMAS_MUGGER and selected_event ~= random_events.GHOSTHUNT and selected_event ~= random_events.XMAS_TRUCK then
		if ImGui.Button("Teleport") then
			if event_state >= 1 then
				script.run_in_fiber(function (script)
					PED.SET_PED_COORDS_KEEP_VEHICLE(PLAYER.PLAYER_PED_ID(), event_coords.x, event_coords.y, event_coords.z)
				end)
			else
				gui.show_message("Random Events", "Event is not active.")
			end
		end
	else
		ImGui.BeginDisabled()
		ImGui.Button("Teleport")
		ImGui.EndDisabled()
	end
	ImGui.SameLine()
	help_marker("Move away from the area a few meters after teleporting if the event doesn't get triggered.")
	
	ImGui.Text("Location: " .. (event_loc ~= -1 and event_loc or "None"))
	ImGui.Text("Trigger Zone: " .. math.floor(trigger_zone) .. " meters")
	ImGui.Text("State: " .. (event_state == 0 and "Waiting" or event_state == 1 and "Ready" or event_state == 2 and "Triggered" or "None"))
end)