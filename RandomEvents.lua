random_events_tab = gui.get_tab("Random Events")

selected_event = 0
event_state = 0
event_loc = 0

cooldown_value = 0

event_ids = {
24,  -- Drug Vehicle 
26,  -- Movie Props 
259, -- Sleeping Guard 
273, -- Exotic Exports 
270, -- Slashers 
269, -- Phantom Car
275, -- Sightseeing 
286, -- Smuggler Trail 
287, -- Cerberus 
266, -- Smuggler Plane 
147, -- Crime Scene 
268, -- Metal Detector 
288, -- Gang Convoy 
290, -- Store Robbery 
310, -- Gooch 
311, -- Weazel Bank Shootout 
312, -- Armored Truck 
320, -- Possessed Animals 
313 } -- Ghosts Exposed

force_offsets = {
441, -- Drug Vehicle
444, -- Movie Props
447, -- Sleeping Guard
450, -- Exotic Export/Cerberus
453, -- Slashers
456, -- Phantom Car
459, -- Sightseeing
462, -- Smuggler Trail (kinda buggy)
450, -- Exotic Export/Cerberus
468, -- Smuggler Plane
471, -- Crime Scene
474, -- Metal Detector
477, -- Gang Convoy
480, -- Store Robbery
482, -- Gooch
486, -- Weazel Bank Shootout
489, -- Armored Truck
492, -- Possessed Animals
495 } -- Ghosts Exposed

cd_offsets = {
33884, -- Drug Vehicle
33886, -- Movie Props
33888, -- Sleeping Guard
33890, -- Exotic Exports
31881, -- Slashers
31880, -- Phantom Car
33056, -- Sightseeing
33892, -- Smuggler Trail
33894, -- Cerberus
32812, -- Smuggler Plane
33896, -- Crime Scene
33898, -- Metal Detector
34032, -- Gang Convoy
34034, -- Store Robbery
33969, -- Gooch
34036, -- Weazel Bank Shootout
34038, --  Armored Truck
31881, -- Possessed Animals
34040 } -- Ghosts Exposed

local fm_content = 1890378
local session_controller = 1574589
local session_controller2 = 1575020
local cool_down_deez_nutts = 262145

function customText(format, ...)
    local formatted_text = string.format(format, ...)
    ImGui.Text(formatted_text)
end

script.register_looped("UpdateStateAndTunas", function (script)
	event_state = globals.get_int(fm_content + 1 + 1 + (selected_event * 15))
	event_loc = globals.get_int(fm_content + 1 + 1 + (selected_event * 15) + 6)
	tunables.set_int(1470797531, 1) -- Slashers
	tunables.set_int(-167641066, 3) -- Phantom Car
	tunables.set_int('SSP2POSIX', 1697101200) -- Sightseeing POSIX - Thursday, 12 October 2023 09:00:00
	tunables.set_int(-2122185994, 3) -- Cerberus
	tunables.set_int('ENABLE_MAZEBANKSHOOTOUT_DLC22022', 1) -- Bank Shootout
	tunables.set_int('ENABLE_HALLOWEEN_POSSESSED_ANIMAL', 1) -- Possessed Animals
	tunables.set_int('ENABLE_HALLOWEEN_GHOSTHUNT', 1) -- Ghosts Exposed
end)

random_events_tab:add_imgui(function()

	selected_event = ImGui.Combo("Select Event", selected_event, { "Drug Vehicle", "Movie Props", "Sleeping Guard", "Exotic Exports", "Slashers", "Phantom Car", "Sightseeing", "Smuggler Trail", "Cerberus", "Smuggler Plane", "Crime Scene", "Metal Detector", "Gang Convoy", "Store Robbery", "Gooch", "Weazel Bank", "Armoured Truck", "Possessed Animals", "Ghosts Exposed" }, 19, 10)
	
	if ImGui.Button("Force Trigger") then
		if event_state == 1 then
			globals.set_int(fm_content + force_offsets[selected_event + 1], 1)
		else
			gui.show_message("Random Events", "Please wait until the cooldown ends.")
		end
	end
	
	if (ImGui.IsItemHovered()) then
		ImGui.SetTooltip("It might not work on some random events!")
	end
	
	ImGui.SameLine()	
	
	-- Event State & Location won't get updated if you start the event using the debug script event. Rockstar probably uses it to force-trigger random events for testing.
	
	if ImGui.Button("Start Event (Debug)") then
		script.run_in_fiber(function (script)
			if (selected_event == 5) then
				locals.set_int("freemode", 15368 + 1 + (18 * 12) + 2, 2710833)
				script:sleep(2000)
				locals.set_int("freemode", 15368 + 229 + 1 + 19, event_ids[selected_event + 1])
				script:sleep(2000)
				globals.set_int(fm_content + 289, PLAYER.PLAYER_ID()) -- Set yourself as selected player by Phantom Car
				script:sleep(2000)
				locals.set_int("freemode", 15368 + 229 + 1 + 19, 313)
			else 
				locals.set_int("freemode", 15368 + 1 + (18 * 12) + 2, 2710833) -- Setting the active requirement. I use gooch (func_8414) because it meets the requirements for triggering all random events (default is ghosts exposed)
				locals.set_int("freemode", 15368 + 229 + 1 + 19, event_ids[selected_event + 1])
				script:sleep(2000)
				locals.set_int("freemode", 15368 + 229 + 1 + 19, 313) -- Setting value back to ghosts exposed to avoid loop
			end
		end)
		gui.show_message("Random Events", "The event has been started successfully.")
	end
	
	if (ImGui.IsItemHovered()) then
		ImGui.SetTooltip("Changes will only take effect if you are the freemode script host!")
	end
	
	if (event_state == 0) then
		ImGui.Text("Event State: Waiting for cooldown to end")
	elseif (event_state == 1) then
		ImGui.Text("Event State: Ready")
	elseif (event_state == 2) then
		ImGui.Text("Event State: Triggered")
	else
		ImGui.Text("Event State: Unknown")
	end
	
	customText("Location: %d", event_loc)
	
	ImGui.Separator()
	
	ImGui.Text("Cooldown Editor")
	
	ImGui.Text("You can modify the cooldown in milliseconds.")
	
	cooldown_value = ImGui.InputInt("##cooldown_value", cooldown_value)
	
	ImGui.SameLine()
	
	if ImGui.Button("Set Cooldown Value") then
		script.run_in_fiber(function (script)
			globals.set_int(session_controller2, 11)
			globals.set_int(session_controller, 1)
			script:sleep(2000)
			globals.set_int(session_controller, 0)
			script:sleep(1000)
			globals.set_int(cool_down_deez_nutts + cd_offsets[selected_event + 1], cooldown_value)
		end)
	end
	
	customText("Current Value: %d ms", globals.get_int(cool_down_deez_nutts + cd_offsets[selected_event + 1]))
	
end)