random_events_tab = gui.get_tab("GUI_TAB_NETWORK"):add_tab("Random Events")

re_data = {
    instances = {
        DRUG_VEHICLE = 0,
        MOVIE_PROPS = 1,
        GOLDEN_GUN = 2,
        VEHICLE_LIST = 3,
        SLASHER = 4,
        PHANTOM_CAR = 5,
        SIGHTSEEING = 6,
        SMUGGLER_TRAIL = 7,
        CERBERUS = 8,
        SMUGGLER_PLANE = 9,
        CRIME_SCENE = 10,
        METAL_DETECTOR = 11,
        CONVOY = 12,
        ROBBERY = 13,
        XMAS_MUGGER = 14,
        BANK_SHOOTOUT = 15,
        ARMOURED_TRUCK = 16,
        POSSESSED_ANIMALS = 17,
        GHOSTHUNT = 18,
        XMAS_TRUCK = 19
    },
    states = {
        INACTIVE = 0,
        AVAILABLE = 1,
        ACTIVE = 2,
        CLEANUP = 3
    },
    names = {
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
    },
	cd_defaults = {
	   1800000, 900000, 1200000, 90000,
	   960000, 960000, 300000, 1200000,
	   960000, 2100000, 1800000, 1320000,
	   1200000, 1200000, 2880000, 1200000,
	   1200000, 960000, 1000, 3600000	
	},
	ab_defaults = {
	   900000, 600000, 600000, 900000,
	   1200000, 1200000, 1200000, 600000,
	   1200000, 600000, 900000, 600000,
	   600000, 600000, 1200000, 600000,
	   600000, 1200000, 119000, 1800000	
	}
}

selected_event = 0
selected_target = 1
selected_loc = 0
set_cd = re_data.cd_defaults[selected_event + 1]
set_ab = re_data.ab_defaults[selected_event + 1]
enable_esp = false
enable_line = true
enable_spheres = true
disable_all_events = false
enable_special_events = true
set_target_player = false
enable_notifications = true
notified_events = {}

local fmmc_types = { 24, 26, 259, 273, 270, 269, 275, 286, 287, 266, 147, 268, 288, 290, 310, 311, 312, 320, 313, 323 }
local max_locations = { 29, 8, 9, 49, 7, 0, 25, 14, 11, 4, 9, 9, 6, 24, 0, 0, 9, 17, 8, 0 }
local blip_ranges = { 200, nil, 200, nil, nil, nil, nil, 400, nil, nil, 200, 200, 200, 100, nil, nil, 200, nil, nil, nil }
local request_re_hash = -126218586
local gsbd_re = 1882037
local gsbd = 2648918
local gpbd_fm_2 = 1882422
local fmre_data = 15544

local re_initialized = false
local event_state = re_data.states.INACTIVE
local event_loc = 0
local event_coords = vec3:new(0.0, 0.0, 0.0)
local trigger_range = 0.0
local target_id = 0
local num_entities = {}
local num_active_events = 0
local max_entities = {}
local max_events = 0
local event_cooldown = 0
local event_availability = 0
local session_time = ""

function request_random_event(event_id, event_location)
    local args = {request_re_hash, 0, -1, event_id, 0, event_location, 0}
    network.trigger_script_event(-1, args)
end

function get_num_active_events()
    local num_events = 0
    
    for i = 0, 19 do
        if globals.get_int(gpbd_fm_2 + (1 + (self.get_id() * 142)) + 78 + 1 + (1 + (i * 3))) ~= 0 then
            num_events = num_events + 1
        end
    end
    
    return num_events
end

function get_targets()
    local player_table = {}

    for i = 0, 31 do
        local player_name = PLAYER.GET_PLAYER_NAME(i)
        if player_name ~= "**Invalid**" then
            table.insert(player_table, {id = i, name = player_name})
        end
    end

    return player_table
end

function is_event_exception()
    return selected_event == re_data.instances.PHANTOM_CAR or selected_event == re_data.instances.SIGHTSEEING or selected_event == re_data.instances.XMAS_MUGGER or selected_event == re_data.instances.GHOSTHUNT
end

function get_session_time()
    local seconds = tonumber(NETWORK.GET_TIME_DIFFERENCE(NETWORK.GET_CLOUD_TIME_AS_INT(), globals.get_int(gsbd + 1)))
    if seconds <= 0 then
        return "00:00:00"
    else
        local days = math.floor(seconds / (3600 * 24))
        local hours = string.format("%02.f", math.floor(seconds % (3600 * 24) / 3600))
        local mins = string.format("%02.f", math.floor(seconds % 3600 / 60))
        local secs = string.format("%02.f", math.floor(seconds % 60))

        return hours .. ":" .. mins .. ":" .. secs
    end
end

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

function looped_update_re_info()
	re_initialized = globals.get_int(gpbd_fm_2 + (1 + (self.get_id() * 142)) + 78) == 1
	event_state = globals.get_int(gsbd_re + 1 + (1 + (selected_event * 15)))
	event_loc = globals.get_int(gsbd_re + 1 + (1 + (selected_event * 15)) + 6)
	event_coords = globals.get_vec3(gsbd_re + 1 + (1 + (selected_event * 15)) + 10) -- It gets updated every 5 seconds
	trigger_range = globals.get_float(gsbd_re + 1 + (1 + (selected_event * 15)) + 13)
	num_entities[1] = globals.get_int(gsbd_re + 1 + (1 + (selected_event * 15)) + 7)
	num_entities[2] = globals.get_int(gsbd_re + 1 + (1 + (selected_event * 15)) + 7 + 1)
	num_entities[3] = globals.get_int(gsbd_re + 1 + (1 + (selected_event * 15)) + 7 + 2)
	num_active_events = get_num_active_events()
	max_entities[1] = tunables.get_int("FMREMAXRESERVEDPEDS")
	max_entities[2] = tunables.get_int("FMREMAXRESERVEDVEHICLES")
	max_entities[3] = tunables.get_int("FMREMAXRESERVEDOBJECTS")
	max_events = tunables.get_int("FMREMAXACTIVATEDEVENTS")
	event_cooldown = locals.get_int("freemode", fmre_data + (1 + (selected_event * 12)) + 6)
	event_availability = locals.get_int("freemode", fmre_data + (1 + (selected_event * 12)) + 7)
	session_time = get_session_time()
	
	if disable_all_events then
		tunables.set_bool("SUM_RANDOM_EVENT_DRUG_VEHICLE_ENABLE", false)
		tunables.set_bool("COLLECTABLES_MOVIE_PROPS", false)
		globals.set_float(gsbd_re + 1 + (1 + (re_data.instances.GOLDEN_GUN * 15)) + 13, 0.0)
		globals.set_float(gsbd_re + 1 + (1 + (re_data.instances.VEHICLE_LIST * 15)) + 13, 0.0)
		tunables.set_int("STANDARDCONTROLLERVOLUME", -1)
		tunables.set_int("STANDARDTARGETTINGTIME", -1)
		tunables.set_int("SSP2POSIX", -1)
		tunables.set_bool("ENABLE_SU22_SMUGGLER_TRAIL", false)
		tunables.set_int("NC_SOURCE_TRUCK_HEAD_COUNT", 1)
		tunables.set_bool("ENABLE_SU22_SMUGGLER_PLANE", false)
		tunables.set_bool("ENABLE_SUM22_CRIME_SCENES", false)
		tunables.set_bool("COLLECTABLES_BURIED_STASH", false)
		tunables.set_bool("ENABLE_GANGCONVOY_DLC22022", false)
		tunables.set_bool("XM22_ROBBERY_ENABLE", false)
		tunables.set_int("STANDARD_KEYBIND_SELECTION", -1)
		tunables.set_bool("ENABLE_MAZEBANKSHOOTOUT_DLC22022", false)
		tunables.set_bool("ENABLE_RANDOM_EVENT_ARMORED_TRUCK", false)
		tunables.set_bool("ENABLE_HALLOWEEN_POSSESSED_ANIMAL", false)
		tunables.set_int("ENABLE_HALLOWEEN_GHOSTHUNT", 0)
		tunables.set_bool(2093114948, false)	
	end
	if set_target_player then
		globals.set_int(gsbd_re + 304, target_id) -- Phantom Car Target (Also the Slasher target, but it doesn't work)
		globals.set_int(gsbd_re + 304 + 1, target_id) -- Gooch Target
	end	
	if enable_special_events then
		tunables.set_int("STANDARDCONTROLLERVOLUME", 1) -- Slashers
		tunables.set_int("STANDARDTARGETTINGTIME", 1) -- Phantom Car
		tunables.set_int("SSP2POSIX", 1697101200) -- Thursday, 12 October 2023 09:00:00 GMT
		tunables.set_bool("ENABLE_SU22_SMUGGLER_TRAIL", true) -- R* has disabled it in 1.68 for some reason (was too buggy?)
		tunables.set_int("NC_SOURCE_TRUCK_HEAD_COUNT", 3) -- Cerberus
		tunables.set_int("STANDARD_KEYBIND_SELECTION", 1) -- Gooch
		tunables.set_bool("ENABLE_MAZEBANKSHOOTOUT_DLC22022", true)
		tunables.set_bool("ENABLE_HALLOWEEN_POSSESSED_ANIMAL", true)
		tunables.set_int("ENABLE_HALLOWEEN_GHOSTHUNT", 1)
		tunables.set_bool(2093114948, true) -- Happy Holidays Hauler
	end
end

function looped_notify_player()
    for i = 0, 19 do
        local state = globals.get_int(gsbd_re + 1 + (1 + (i * 15)))
        
        if state == re_data.states.AVAILABLE then
            if not notified_events[i] then
                gui.show_message("Random Events", "" .. re_data.names[i + 1] .. " is available.")
                notified_events[i] = true
            end
        elseif state ~= re_data.states.AVAILABLE and notified_events[i] then
            notified_events[i] = false
        end
    end
end

function looped_render_esp()
	local distance = MISC.GET_DISTANCE_BETWEEN_COORDS(self.get_pos().x, self.get_pos().y, self.get_pos().z, event_coords.x, event_coords.y, event_coords.z, false)
	local km_or_m = (distance < 1000) and "m" or "km"
	local formatted_distance = (distance < 1000) and distance or (distance / 1000.0)
	local screen_coords_x = 0.0
	local screen_coords_y = 0.0
	
	_, screen_coords_x, screen_coords_y = GRAPHICS.GET_SCREEN_COORD_FROM_WORLD_COORD(event_coords.x, event_coords.y, event_coords.z, screen_coords_x, screen_coords_y)
	if enable_line then
		GRAPHICS.DRAW_LINE(self.get_pos().x, self.get_pos().y, self.get_pos().z, event_coords.x, event_coords.y, event_coords.z, 93, 182, 229, 255)
		GRAPHICS.REQUEST_STREAMED_TEXTURE_DICT("CommonMenu", false)
		GRAPHICS.DRAW_SPRITE("CommonMenu", "Common_Medal", screen_coords_x, screen_coords_y, 0.03, 0.06, 0.0, 93, 182, 229, 255, false, 0)			
	end
	HUD.BEGIN_TEXT_COMMAND_DISPLAY_TEXT("STRING")
	HUD.ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(string.format("%s (%.2f%s)", (event_state == re_data.states.ACTIVE and "~HUD_COLOUR_GREEN~" or "") .. re_data.names[selected_event + 1] .. "~s~", formatted_distance, km_or_m))
	HUD.SET_TEXT_RENDER_ID(1)
	HUD.SET_TEXT_OUTLINE()
	HUD.SET_TEXT_CENTRE(true)
	HUD.SET_TEXT_DROP_SHADOW()
	HUD.SET_TEXT_SCALE(0, 0.3)
	HUD.SET_TEXT_FONT(4)
	HUD.SET_TEXT_COLOUR(255, 255, 255, 240)
	HUD.END_TEXT_COMMAND_DISPLAY_TEXT(screen_coords_x, screen_coords_y + -0.03, 0)
	if enable_spheres then
		GRAPHICS.DRAW_MARKER(28, event_coords.x, event_coords.y, event_coords.z, 0, 0, 0, 0, 180, 0, trigger_range, trigger_range, trigger_range, 0, 153, 51, 40, true, true, 2, false, nil, nil, false)		
		if blip_ranges[selected_event + 1] ~= nil then
			GRAPHICS.DRAW_MARKER(28, event_coords.x, event_coords.y, event_coords.z, 0, 0, 0, 0, 180, 0, blip_ranges[selected_event + 1], blip_ranges[selected_event + 1], blip_ranges[selected_event + 1], 93, 182, 229, 40, true, true, 2, false, nil, nil, false)
		end
	end
end

event.register_handler(menu_event.PlayerMgrInit, function()
	selected_target = 1
	target_id = 0
end)

script.register_looped("Random Events", function(script)
	looped_update_re_info()
	if enable_notifications then
		looped_notify_player()
	end
	if enable_esp and event_coords ~= vec3:new(0.0, 0.0, 0.0) then
		looped_render_esp()
	end
end)

random_events_tab:add_imgui(function()
	if re_initialized then
		if ImGui.BeginCombo("Select Event", re_data.names[selected_event + 1]) then
			for i = 1, #re_data.names do
				local state = globals.get_int(gsbd_re + 1 + (1 + ((i - 1) * 15)))
				
				if state == re_data.states.INACTIVE then
					ImGui.PushStyleColor(ImGuiCol.Text, 1, 0, 0, 1)
				elseif state == re_data.states.AVAILABLE then
					ImGui.PopStyleColor()
				elseif state == re_data.states.ACTIVE then
					ImGui.PushStyleColor(ImGuiCol.Text, 0, 1, 0, 1)
				end

				if ImGui.Selectable(re_data.names[i], i - 1 == selected_event) then
					selected_event = i - 1
					selected_loc = 0
					set_cd = re_data.cd_defaults[selected_event + 1]
					set_ab = re_data.ab_defaults[selected_event + 1]
				end

				ImGui.PopStyleColor()
			end

			ImGui.EndCombo()
		end
		
		if set_target_player then
			selected_target = math.max(1, math.min(selected_target, #get_targets()))

			if ImGui.BeginCombo("Select Target", #get_targets() > 0 and get_targets()[selected_target].name or "NONE") then
				for i, player_info in ipairs(get_targets()) do
					if ImGui.Selectable(player_info.name .. " (ID: " .. player_info.id .. ")", i == selected_target) then
						selected_target = i
						target_id = player_info.id
					end
				end
				
				ImGui.EndCombo()
			end
		end
		
		if not is_event_exception() and selected_event ~= re_data.instances.VEHICLE_LIST and selected_event ~= re_data.instances.BANK_SHOOTOUT and selected_event ~= re_data.instances.XMAS_TRUCK then
			selected_loc, modified_loc = ImGui.InputInt("Select Location (0-" .. max_locations[selected_event + 1] .. ")", selected_loc)
			
			if modified_loc then
				selected_loc = math.min(math.max(selected_loc, 0), max_locations[selected_event + 1])
			end
		else
			ImGui.BeginDisabled()
			ImGui.InputInt("Select Location (0-" .. max_locations[selected_event + 1] .. ")", selected_loc)
			ImGui.EndDisabled()
		end
		
		if num_active_events >= max_events then
			ImGui.TextColored(1, 0, 0, 1, "Active Events: " .. num_active_events .. "/" .. max_events)
		else
			ImGui.Text("Active Events: " .. num_active_events .. "/" .. max_events)
		end
		help_marker("Shows the current number of active events (locally) out of the maximum allowed.")
		
		if SCRIPT.GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH(joaat("freemode")) ~= 0 then
			ImGui.Text("Session Time: " .. session_time)
			help_marker("Shows the amount of time passed since the current session is created.")
		end
		
		if ImGui.Button("Launch Event") then
			script.run_in_fiber(function(script)
				if NETWORK.NETWORK_GET_HOST_OF_SCRIPT("freemode", -1, 0) ~= self.get_id() then
					network.force_script_host("freemode")
					script:sleep(1000)
				end
				if event_state ~= re_data.states.ACTIVE then
					request_random_event(fmmc_types[selected_event + 1], selected_loc)
					script:sleep(1000)
					if event_state >= re_data.states.AVAILABLE and event_loc == selected_loc then
						gui.show_message("Random Events", "The event has been launched successfully.")
					else
						gui.show_message("Random Events", "There has been an error while launching the event.")
					end
				else
					gui.show_message("Random Events", "The event is already active.")
				end
			end)
		end
		
		ImGui.SameLine()
		
		if not is_event_exception() then
			if ImGui.Button("Teleport to Event") then
				script.run_in_fiber(function(script)
					if event_state >= re_data.states.AVAILABLE then
						if event_coords ~= vec3:new(0.0, 0.0, 0.0) then
							PED.SET_PED_COORDS_KEEP_VEHICLE(self.get_ped(), event_coords.x, event_coords.y, event_coords.z)
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
			ImGui.Button("Teleport to Event")
			ImGui.EndDisabled()
		end
		
		ImGui.Separator()
		
		ImGui.Text("State: " .. (event_state == re_data.states.INACTIVE and "Inactive" or event_state == re_data.states.AVAILABLE and "Available" or event_state == re_data.states.ACTIVE and "Active" or event_state == re_data.states.CLEANUP and "Cleanup" or "None"))
		help_marker("Shows the current state of the event:\n- Inactive\n- Available\n- Active\n- Cleanup")
		
		ImGui.Text("Location: " .. (event_loc ~= -1 and event_loc or "None"))
		help_marker("Shows the current location of the event or indicates 'None' if no location is available.")
		
		ImGui.Text("Trigger Range: " .. (event_state >= re_data.states.AVAILABLE and math.floor(trigger_range) .. " meters" or "None"))
		help_marker("Specifies the distance required to trigger the event when available, or shows 'None' if the event is inactive.")
		
		ImGui.Text("Blip Appearance Range: " .. ((event_state >= re_data.states.AVAILABLE and blip_ranges[selected_event + 1] ~= nil) and math.floor(blip_ranges[selected_event + 1]) .. " meters" or "None"))
		help_marker("Specifies the distance for the blip to appear when approaching the event, or shows 'None' if not applicable.")
		
		ImGui.Text("Entities: " .. num_entities[1] + num_entities[2] + num_entities[3] .. "/" .. max_entities[1] + max_entities[2]+ max_entities[3])
		help_marker("Shows the amount of reserved entities for the event out of the maximum allowed.")
		
		ImGui.Text("Cooldown: " .. event_cooldown .. "ms (" .. math.floor(event_cooldown / 60000) .. " minutes)")
		help_marker("Shows the time that must pass since session creation for the event to be available.\nDisplayed in milliseconds and minutes.")
		
		ImGui.Text("Availability: " .. event_availability .. "ms (" .. math.floor(event_availability / 60000) .. " minutes)")
		help_marker("Shows the duration the event will be in the available state.\nDisplayed in milliseconds and minutes.")
		
		if ImGui.CollapsingHeader("Cooldown & Availability Editor") then
			set_cd = ImGui.InputInt("Cooldown##cd", set_cd)
			
			if ImGui.Button("Apply##apply_cd") then
				locals.set_int("freemode", fmre_data + (1 + (selected_event * 12)) + 6, set_cd)
			end
			
			set_ab = ImGui.InputInt("Availability##ab", set_ab)
			
			if ImGui.Button("Apply##apply_ab") then
				locals.set_int("freemode", fmre_data + (1 + (selected_event * 12)) + 7, set_ab)
			end
		end
		
		if ImGui.CollapsingHeader("Settings") then
			if not is_event_exception() and event_state ~= re_data.states.INACTIVE then
				enable_esp = ImGui.Checkbox("ESP", enable_esp)
				if enable_esp then
					ImGui.SameLine()
					enable_spheres = ImGui.Checkbox("Spheres", enable_spheres)
					ImGui.SameLine()
					enable_line = ImGui.Checkbox("Line", enable_line)
				end
			else
				enable_esp = false
				ImGui.BeginDisabled()
				ImGui.Checkbox("ESP", enable_esp)
				ImGui.EndDisabled()
			end
			
			ImGui.Separator()
			
			disable_all_events, pressed = ImGui.Checkbox("Disable all Events", disable_all_events)
			help_marker("Prevents all the events from being triggered. You might need to switch session for the changes to take full effect.")
			
			if pressed then
				if not disable_all_events then
					tunables.set_bool("SUM_RANDOM_EVENT_DRUG_VEHICLE_ENABLE", true)
					tunables.set_bool("COLLECTABLES_MOVIE_PROPS", true)
					tunables.set_bool("ENABLE_SU22_SMUGGLER_PLANE", true)
					tunables.set_bool("ENABLE_SUM22_CRIME_SCENES", true)
					tunables.set_bool("COLLECTABLES_BURIED_STASH", true)
					tunables.set_bool("ENABLE_GANGCONVOY_DLC22022", true)
					tunables.set_bool("XM22_ROBBERY_ENABLE", true)
					tunables.set_bool("ENABLE_RANDOM_EVENT_ARMORED_TRUCK", true)
				end
			end
			
			if not disable_all_events then
				enable_special_events, pressed = ImGui.Checkbox("Enable Special Events", enable_special_events)
				
				if pressed then
					if not enable_special_events then
						tunables.set_int("STANDARDCONTROLLERVOLUME", -1)
						tunables.set_int("STANDARDTARGETTINGTIME", -1)
						tunables.set_int("SSP2POSIX", -1)
						tunables.set_bool("ENABLE_SU22_SMUGGLER_TRAIL", false)
						tunables.set_int("NC_SOURCE_TRUCK_HEAD_COUNT", 1)
						tunables.set_int("STANDARD_KEYBIND_SELECTION", -1)
						tunables.set_bool("ENABLE_MAZEBANKSHOOTOUT_DLC22022", false)
						tunables.set_bool("ENABLE_HALLOWEEN_POSSESSED_ANIMAL", false)
						tunables.set_int("ENABLE_HALLOWEEN_GHOSTHUNT", 0)
						tunables.set_bool(2093114948, false)
					end
				end
			else
				enable_special_events = false
				ImGui.BeginDisabled()
				ImGui.Checkbox("Enable Special Events", enable_special_events)
				ImGui.EndDisabled()
			end
			help_marker("Enables the special events that are normally disabled:\n- Slashers\n- Phantom Car\n- Sightseeing\n- Smuggler Trail\n- Cerberus\n- Gooch\n- Weazel Bank Shootout\n- Ghosts Exposed\n- Possessed Animals\n- Happy Holidays Hauler")
			
			if selected_event == re_data.instances.PHANTOM_CAR or selected_event == re_data.instances.XMAS_MUGGER then
				set_target_player = ImGui.Checkbox("Set Target Player", set_target_player)
			else
				set_target_player = false
				ImGui.BeginDisabled()
				ImGui.Checkbox("Set Target Player", set_target_player)
				ImGui.EndDisabled()
			end
			help_marker("Allows you to set the target of Phantom Car and Gooch.")
			
			enable_notifications = ImGui.Checkbox("Notifications", enable_notifications)
		end
	else
		ImGui.Text("Random Events aren't initialized yet.")
	end
end)