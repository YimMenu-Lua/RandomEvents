require("EventInfo")
require ("EventCoords")

random_events_tab = gui.get_tab("Random Events")

local selected_event = 0
local event_state = 0
local event_loc = 0

local cooldown_value = 0
local availability_value = 0
local availability2_value = 0

local fm_content = 1890378
local session_controller = 1574589
local session_controller2 = 1575020
local freemode_offset = 15368

function get_event_coords(event, location)

	if event == 0 then return drug_vehicle_coordinates(location)
	elseif event == 1 then return movie_prop_coordinates(location)
	elseif event == 2 then return sleeping_guard_coordinates(location)
	elseif event == 3 then return slashers_coordinates(location)
	-- Exclude Phantom
	elseif event == 5 then return smuggler_trail_coordinates(location)
	elseif event == 6 then return cerberus_coordinates(location)
	elseif event == 7 then return smuggler_plane_coordinates(location)
	elseif event == 8 then return crime_scene_coordinates(location)
	elseif event == 9 then return metal_detector_coordinates(location)
	elseif event == 10 then return gang_convoy_coordinates(location)
	elseif event == 11 then return store_robbery_coordinates(location)
	-- Exclude Gooch
	elseif event == 13 then return bank_shootout_coordinates(location)
	elseif event == 14 then return armored_truck_coordinates(location)
	elseif event == 15 then return possessed_animal_coordinates(location)
	end

	return vec3:new(0.0, 0.0, 0.0)
end

function custom_text(format, ...)
    local formatted_text = string.format(format, ...)
    ImGui.Text(formatted_text)
end

script.register_looped("UpdateStateAndTunas", function (script)
	event_state = globals.get_int(fm_content + 1 + 1 + (instance_ids[selected_event + 1] * 15)) -- See func_8162 in freemode for more info
	event_loc = globals.get_int(fm_content + 1 + 1 + (instance_ids[selected_event + 1] * 15) + 6) -- See func_8162 in freemode for more info
	globals.set_int(fm_content + 289, PLAYER.PLAYER_ID()) -- Set yourself as selected player by Phantom Car
	tunables.set_int(1470797531, 1) -- Enable Slashers
	tunables.set_int(-167641066, 3) -- Enable Phantom Car
	tunables.set_int('SSP2POSIX', 1697101200) -- Start Sightseeing POSIX - Thursday, 12 October 2023 09:00:00
	tunables.set_int(-2122185994, 3) -- Enable Cerberus
	tunables.set_int('ENABLE_MAZEBANKSHOOTOUT_DLC22022', 1) -- Enable Bank Shootout
	tunables.set_int('ENABLE_HALLOWEEN_POSSESSED_ANIMAL', 1) -- Enable Possessed Animals
end)

random_events_tab:add_imgui(function()

	selected_event = ImGui.Combo("Select Event", selected_event, { "Drug Vehicle", "Movie Props", "Sleeping Guard", "Slashers", "Phantom Car", "Smuggler Trail", "Cerberus", "Smuggler Plane", "Crime Scene", "Metal Detector", "Gang Convoy", "Store Robbery", "Gooch", "Weazel Bank", "Armoured Truck", "Possessed Animals" }, 16, 10)

	if selected_event ~= 4 and selected_event ~= 12 then
		if ImGui.Button("Teleport") then
			if event_state >= 1 then	
				script.run_in_fiber(function (script)
					local coords = get_event_coords(selected_event, event_loc)
					PED.SET_PED_COORDS_KEEP_VEHICLE(PLAYER.PLAYER_PED_ID(), coords.x, coords.y, coords.z)
				end)
			else
				gui.show_message("Random Events", "Please wait until the cooldown ends.")
			end
		end
	else
		ImGui.BeginDisabled()
		ImGui.Button("Teleport")
		ImGui.EndDisabled()
	end
	
	ImGui.SameLine()
	
	if ImGui.Button("Force Trigger") then
		if event_state == 1 then
			globals.set_int(fm_content + force_offsets[selected_event + 1], 1)
		else
			gui.show_message("Random Events", "Please wait until the cooldown ends.")
		end
	end
	
	ImGui.SameLine()
	
	-- Event State & Location won't change if you start the event using the debug script event. Rockstar probably uses it to force-trigger random events for testing.
	
	if ImGui.Button("Start Event (Debug)") then
		script.run_in_fiber(function (script)
			locals.set_int("freemode", freemode_offset + 1 + (18 * 12) + 2, 2710833) -- Setting the active requirement. I use gooch (func_8414) because it meets the requirements for triggering all random events (default is ghosts exposed)
			locals.set_int("freemode", freemode_offset + 229 + 1 + 19, event_ids[selected_event + 1])
			script:sleep(2000)
			locals.set_int("freemode", freemode_offset + 229 + 1 + 19, 313) -- Setting value back to ghosts exposed to avoid loop
		end)
		gui.show_message("Random Events", "The event has been started successfully.")
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
	
	custom_text("Location: %d", event_loc)
	
	ImGui.Separator()
	
	if (ImGui.TreeNode("Cooldown Editor")) then		
	
		cooldown_value = ImGui.InputInt("##cooldown_value", cooldown_value)
		
		ImGui.SameLine()
		
		if ImGui.Button("Apply Value##cd") then
			script.run_in_fiber(function (script)
				globals.set_int(session_controller2, 11)
				globals.set_int(session_controller, 1)
				script:sleep(2000)
				globals.set_int(session_controller, 0)
				script:sleep(1000)
				if (selected_event == 14) then
					globals.set_int(262145 + 34038, cooldown_value)
				else
					tunables.set_int(cd_tuna_hashes[selected_event + 1], cooldown_value)
				end
			end)
		end
		
		custom_text("Current Value: %d ms", (selected_event == 14 and globals.get_int(262145 + 34038) or tunables.get_int(cd_tuna_hashes[selected_event + 1])))
	end
	
	if (ImGui.TreeNode("Availability Editor")) then
		
		availability_value = ImGui.InputInt("##availability_value", availability_value)
		
		ImGui.SameLine()
		
		if ImGui.Button("Apply Value##ab") then
			script.run_in_fiber(function (script)
				globals.set_int(session_controller2, 11)
				globals.set_int(session_controller, 1)
				script:sleep(2000)
				globals.set_int(session_controller, 0)
				script:sleep(1000)
				if (selected_event == 14) then
					globals.set_int(262145 + 34039, availability_value)
				else
					tunables.set_int(ab_tuna_hashes[selected_event + 1], availability_value)
				end
			end)
		end
		
		custom_text("Current Value: %d ms", (selected_event == 14 and globals.get_int(262145 + 34039) or tunables.get_int(ab_tuna_hashes[selected_event + 1])))
		
		ImGui.PopTreeNode()
	end
	
	if (ImGui.TreeNode("Availability 2 Editor")) then
			
		availability2_value = ImGui.InputInt("##availability2_value", availability2_value)
		
		ImGui.SameLine()
		
		if ImGui.Button("Apply Value##ab2") then
			locals.set_int(fm_scripts[selected_event + 1], ab2_locals[selected_event + 1], availability2_value)
		end
		
		custom_text("Current Value: %d min", locals.get_int(fm_scripts[selected_event + 1], ab2_locals[selected_event + 1]))
		
		ImGui.PopTreeNode()
	end
end)
