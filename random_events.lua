local re_tab = gui.get_tab("GUI_TAB_NETWORK"):add_tab("Random Events")

local RE = {
	REQUEST_RE_HASH = -126218586,
	GSBD_RE		    = 1882037,
	GPBD_FM_2	    = 1882422,
	FMRE_DATA	    = 15544,
	RETURN_FALSE	= 504300, -- func_1034 - 0x7B1EC
	RETURN_TRUE	    = 29788,  -- func_144  - 0x745C
    VECTOR_ZERO     = vec3:new(0.0, 0.0, 0.0),
	MAX_LOCATIONS	= { 29, 8, 9, 49, 7, 0, 25, 14, 11, 4, 9, 9, 6, 24, 0, 0, 9, 17, 8, 0 },
	BLIP_RANGES	    = { 200.0, nil, 200.0, nil, nil, nil, nil, 400.0, nil, nil, 200.0, 200.0, 200.0, 100.0, nil, nil, 200.0, nil, nil, nil },	
	INSTANCES = {
		DRUG_VEHICLE	  = 0,
		MOVIE_PROPS	      = 1,
		GOLDEN_GUN	      = 2,
		VEHICLE_LIST	  = 3,
		SLASHER	          = 4,
		PHANTOM_CAR	      = 5,
		SIGHTSEEING	      = 6,
		SMUGGLER_TRAIL	  = 7,
		CERBERUS	      = 8,
		SMUGGLER_PLANE	  = 9,
		CRIME_SCENE	      = 10,
		METAL_DETECTOR    = 11,
		CONVOY		      = 12,
		ROBBERY		      = 13,
		XMAS_MUGGER	      = 14,
		BANK_SHOOTOUT	  = 15,
		ARMOURED_TRUCK	  = 16,
		POSSESSED_ANIMALS = 17,
		GHOSTHUNT	      = 18,
		XMAS_TRUCK	      = 19
	},
	STATES = {
		INACTIVE  = 0,
		AVAILABLE = 1,
		ACTIVE    = 2,
		CLEANUP   = 3
	},
	FUNC_HASHES = {
		2767956, -- func_8742 - 0x2A3C54
		2767720, -- func_8737 - 0x2A3B68
		2767675, -- func_8735 - 0x2A3B3B
		2767613, -- func_8733 - 0x2A3AFD
		2764516, -- func_8726 - 0x2A2EE4
		2763652, -- func_8718 - 0x2A2B84 -- Should be available check
		2763420, -- func_8714 - 0x2A2A9C
		2763350, -- func_8713 - 0x2A2A56
		2762838, -- func_8707 - 0x2A2856
		2762747, -- func_8704 - 0x2A27FB
		2762669, -- func_8702 - 0x2A27AD
		2762594, -- func_8700 - 0x2A2762
		2762516, -- func_8698 - 0x2A2714
		2762438, -- func_8696 - 0x2A26C6
		2761589, -- func_8686 - 0x2A2375 -- Should be available check
		2761461, -- func_8683 - 0x2A22F5
		2761371, -- func_8680 - 0x2A229B
		2760882, -- func_8671 - 0x2A20B2
		2760044, -- func_8668 - 0x2A1D6C
		2759990  -- func_8667 - 0x2A1D36 -- Should be available check	
	},
	END_REASONS = {
		{ 1733, 115 },
		{ 1859, 137 },
		{ 1730, 93  },
		{ 1539, 83  },
		{ 1568, 83  },
		{ 1548, 83  },
		{ 1790, 84  },
		{ 2170, 213 },
		{ 1560, 91  },
		{ 1807, 178 },
		{ 1916, 151 },
		{ 1778, 93  },
		{ 2704, 437 },
		{ 1694, 87  },
		{ 1591, 83  },
		{ 2175, 221 },
		{ 1868, 113 },
		{ 1564, 83  },
		{ 1522, 88  },
		{ 1432, 91  }
	},
	NAMES = {
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
    SCRIPTS = {
		"fm_content_drug_vehicle",
		"fm_content_movie_props",
		"fm_content_golden_gun",
		"fm_content_vehicle_list",
		"fm_content_slasher",
		"fm_content_phantom_car",
		"fm_content_sightseeing",
		"fm_content_smuggler_trail",
		"fm_content_cerberus",
		"fm_content_smuggler_plane",
		"fm_content_crime_scene",
		"fm_content_metal_detector",
		"fm_content_convoy",
		"fm_content_robbery",
		"fm_content_xmas_mugger",
		"fm_content_bank_shootout",
		"fm_content_armoured_truck",
		"fm_content_possessed_animals",
		"fm_content_ghosthunt",
		"fm_content_xmas_truck"
    },
	COOLDOWNS = {
		"SUM22_RE_DRUG_VEHICLE_INACTIVE_TIME",
		"SUM22_RE_MOVIE_PROPS_INACTIVE_TIME",
		"SUM22_RE_GOLDEN_GUN_INACTIVE_TIME",
		"SUM22_RE_VEHICLE_LIST_INACTIVE_TIME",
		"STANDARDCONTROLLERVOLUME_COOLDOWN",
		"STANDARDTARGETTINGTIME_COOLDOWN",
		"SSP2_COOLDOWN",
		"SUM22_RE_SMUGGLER_TRAIL_INACTIVE_TIME",
		"NC_SOURCE_TRUCK_COOLDOWN",
		"SUM22_RE_SMUGGLER_PLANE_INACTIVE_TIME",
		"SUM22_RE_CRIME_SCENE_INACTIVE_TIME",
		"SUM22_RE_METAL_DETECTOR_INACTIVE_TIME",
		"XM22_RE_GANG_CONVOY_INACTIVE_TIME",
		"XM22_RE_ROBBERY_INACTIVE_TIME",
		"STANDARD_KEYBIND_COOLDOWN",
		"XM22_RE_BANK_SHOOTOUT_INACTIVE_TIME",
		296417, -- Global_262145.f_34272 - Armored Truck (doesn't have a tunable)
		"STANDARDCONTROLLERVOLUME_COOLDOWN",
		"SUM23_RE_GHOSTHUNT_INACTIVE_TIME",
		"XMAS_TRUCK_INACTIVE_TIME"	
	},
	AVAILABILITIES = {
		"SUM22_RE_DRUG_VEHICLE_AVAILABLE_TIME",
		"SUM22_RE_MOVIE_PROPS_AVAILABLE_TIME",
		"SUM22_RE_GOLDEN_GUN_AVAILABLE_TIME",
		"SUM22_RE_VEHICLE_LIST_AVAILABLE_TIME",
		"STANDARDCONTROLLERVOLUME_AVAILABILITY",
		"STANDARDTARGETTINGTIME_AVAILABILITY",
		"SSP2_AVAILABILITY",
		"SUM22_RE_SMUGGLER_TRAIL_AVAILABLE_TIME",
		"NC_SOURCE_TRUCK_AVAILABILITY",
		"SUM22_RE_SMUGGLER_PLANE_AVAILABLE_TIME",
		"SUM22_RE_CRIME_SCENE_AVAILABLE_TIME",
		"SUM22_RE_METAL_DETECTOR_AVAILABLE_TIME",
		"XM22_RE_GANG_CONVOY_AVAILABLE_TIME",
		"XM22_RE_ROBBERY_AVAILABLE_TIME",
		"STANDARD_KEYBIND_AVAILABILITY",
		"XM22_RE_BANK_SHOOTOUT_AVAILABLE_TIME",
		296418, -- Global_262145.f_34273 - Armored Truck (doesn't have a tunable)
		"STANDARDCONTROLLERVOLUME_AVAILABILITY",
		"SUM23_RE_GHOSTHUNT_AVAILABLE_TIME",
		"XMAS_TRUCK_AVAILABLE_TIME"	
	}
}

local selected_event       = 0
local selected_target      = 0
local selected_loc         = 0
local set_cooldown         = 1800000
local set_availability     = 900000
local apply_in_minutes     = false
local enable_esp           = false
local disable_all_events   = false
local bypass_requirements  = false
local set_target_player    = false
local enable_line          = true
local enable_spheres       = true
local enable_notifications = true
local force_freemode_host  = true
local notified_available   = {}
local notified_active      = {}

local event_coords           = RE.VECTOR_ZERO
local event_state            = RE.STATES.INACTIVE
local event_trigger_range    = 0.0
local event_blip_range       = 0.0
local event_timer            = 0
local event_variant          = 0
local event_cooldown         = 0
local event_availability     = 0
local max_num_re             = 0
local max_events             = 0
local num_active_events      = 0
local event_host_id 		 = 0
local target_player_id       = 0
local re_initialized         = false
local cooldown_time_left     = "00:00:00"
local availability_time_left = "00:00:00"
local event_host_name 		 = "**Invalid**"
local max_entities           = {}
local num_entities           = {}
local target_players         = {}

local function REQUEST_RANDOM_EVENT(event, variant)
    local fmmc_type = locals.get_int("freemode", RE.FMRE_DATA + 241 + 1 + (event + 1))
    local args      = { RE.REQUEST_RE_HASH, 0, -1, fmmc_type, 0, variant, 0 }
	
    network.trigger_script_event(-1, args)
end

local function HOOK_SHOULD_TRIGGER_FUNCTIONS(value)
    for i = 0, max_num_re - 1 do
        if i == RE.INSTANCES.PHANTOM_CAR or i == RE.INSTANCES.XMAS_MUGGER or i == RE.INSTANCES.XMAS_TRUCK then
            locals.set_int("freemode", RE.FMRE_DATA + (1 + (i * 12)) + 5, value)
        else
            locals.set_int("freemode", RE.FMRE_DATA + (1 + (i * 12)) + 1 + 1, value)
        end
    end
end

local function RESTORE_SHOULD_TRIGGER_FUNCTIONS()
    for i = 0, max_num_re - 1 do
        if i == RE.INSTANCES.PHANTOM_CAR or i == RE.INSTANCES.XMAS_MUGGER or i == RE.INSTANCES.XMAS_TRUCK then
            locals.set_int("freemode", RE.FMRE_DATA + (1 + (i * 12)) + 5, RE.FUNC_HASHES[i + 1])
        else
            locals.set_int("freemode", RE.FMRE_DATA + (1 + (i * 12)) + 1 + 1, RE.FUNC_HASHES[i + 1])
        end
    end
end

local function SET_EVENT_STATE(event, state)
	globals.set_int(RE.GSBD_RE + 1 + (1 + (event * 15)), state)
end

local function SET_EVENT_COOLDOWN(event, value)
    locals.set_int("freemode", RE.FMRE_DATA + (1 + (event * 12)) + 6, value)
end

local function SET_EVENT_AVAILABILITY(event, value)
    locals.set_int("freemode", RE.FMRE_DATA + (1 + (event * 12)) + 7, value)
end

local function SET_EVENT_TARGET(target_id)
	globals.set_int(RE.GSBD_RE + 304, target_id) -- Phantom Car Target (Also the Slasher target, but it doesn't work)
	globals.set_int(RE.GSBD_RE + 304 + 1, target_id) -- Gooch Target
end

local function SET_EVENT_END_REASON(event, reason)
	local base_address = RE.END_REASONS[event][1]
	local offset 	   = RE.END_REASONS[event][2]
	
	locals.set_int(RE.SCRIPTS[event], base_address + offset, reason)
end

local function IS_EVENT_EXCEPTION()
    return selected_event == RE.INSTANCES.PHANTOM_CAR or selected_event == RE.INSTANCES.SIGHTSEEING or selected_event == RE.INSTANCES.XMAS_MUGGER or selected_event == RE.INSTANCES.GHOSTHUNT
end

local function GET_NUM_LOCALLY_ACTIVE_EVENTS()
    local num_events = 0

    for i = 0, max_num_re - 1 do
        local local_state = globals.get_int(RE.GPBD_FM_2 + (1 + (self.get_id() * 142)) + 78 + 1 + (1 + (i * 3)))

        if local_state ~= RE.STATES.INACTIVE then
            num_events = num_events + 1
        end
    end
    
    return num_events
end

local function GET_TRIGGERER_INDEX(event)
    for i = 0, 31 do
        local player_state = globals.get_int(RE.GPBD_FM_2 + (1 + (i * 142)) + 78 + 1 + (1 + (event * 3)))

        if player_state == RE.STATES.ACTIVE then
            return i
        end
    end
	
    return -1
end

local function GET_TARGET_PLAYERS()
    local player_table = {}

    for i = 0, 31 do
        local player_name = PLAYER.GET_PLAYER_NAME(i)

        if player_name ~= "**Invalid**" then
            table.insert(player_table, {id = i, name = player_name})
        end
    end

    return player_table
end

local function GET_EVENT_TIME_LEFT(event_time)
    local time_passed   = MISC.ABSI(NETWORK.GET_TIME_DIFFERENCE(NETWORK.GET_NETWORK_TIME(), event_timer))
    local diff 	        = NETWORK.GET_TIME_DIFFERENCE(event_time, time_passed)
    local total_seconds = math.floor(diff / 1000)
    local hours         = math.floor(total_seconds / 3600)
    local minutes       = math.floor((total_seconds % 3600) / 60)
    local seconds       = total_seconds % 60
    local formatted     = string.format("%02d:%02d:%02d", hours, minutes, seconds)
    
    return formatted
end

local function HELP_MARKER(text)
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

local function CLAMP(value, min, max)
    return math.min(math.max(value, min), max)
end

local function LOOPED_UPDATE_RE_INFO()
    event_coords           = globals.get_vec3(RE.GSBD_RE + 1 + (1 + (selected_event * 15)) + 10)
    event_trigger_range    = globals.get_float(RE.GSBD_RE + 1 + (1 + (selected_event * 15)) + 13)
    event_state            = globals.get_int(RE.GSBD_RE + 1 + (1 + (selected_event * 15)))
    event_timer            = globals.get_int(RE.GSBD_RE + 1 + (1 + (selected_event * 15)) + 1)
    event_variant          = globals.get_int(RE.GSBD_RE + 1 + (1 + (selected_event * 15)) + 6)
    num_entities[1]        = globals.get_int(RE.GSBD_RE + 1 + (1 + (selected_event * 15)) + 7)
    num_entities[2]        = globals.get_int(RE.GSBD_RE + 1 + (1 + (selected_event * 15)) + 7 + 1)
    num_entities[3]        = globals.get_int(RE.GSBD_RE + 1 + (1 + (selected_event * 15)) + 7 + 2)
    re_initialized         = globals.get_int(RE.GPBD_FM_2 + (1 + (self.get_id() * 142)) + 78) == 1
    max_num_re             = locals.get_int("freemode", RE.FMRE_DATA + 241)
    event_cooldown         = locals.get_int("freemode", RE.FMRE_DATA + (1 + (selected_event * 12)) + 6)
    event_availability     = locals.get_int("freemode", RE.FMRE_DATA + (1 + (selected_event * 12)) + 7)
    max_events             = tunables.get_int("FMREMAXACTIVATEDEVENTS")
    max_entities[1]        = tunables.get_int("FMREMAXRESERVEDPEDS")
    max_entities[2]        = tunables.get_int("FMREMAXRESERVEDVEHICLES")
    max_entities[3]        = tunables.get_int("FMREMAXRESERVEDOBJECTS")
    event_host_id 		   = NETWORK.NETWORK_GET_HOST_OF_SCRIPT(RE.SCRIPTS[selected_event + 1], selected_event, 0)
	event_host_name 	   = PLAYER.GET_PLAYER_NAME(event_host_id)
	num_active_events      = GET_NUM_LOCALLY_ACTIVE_EVENTS()
    cooldown_time_left     = GET_EVENT_TIME_LEFT(event_cooldown)
    availability_time_left = GET_EVENT_TIME_LEFT(event_availability)
    target_players         = GET_TARGET_PLAYERS()
    event_blip_range       = RE.BLIP_RANGES[selected_event + 1]
end

local function LOOPED_RENDER_ESP()
    local distance           = MISC.GET_DISTANCE_BETWEEN_COORDS(self.get_pos().x, self.get_pos().y, self.get_pos().z, event_coords.x, event_coords.y, event_coords.z, false)
    local km_or_m            = (distance < 1000) and "m" or "km"
    local formatted_distance = (distance < 1000) and distance or (distance / 1000.0)
    local screen_coords_x    = 0.0
    local screen_coords_y    = 0.0

    _, screen_coords_x, screen_coords_y = GRAPHICS.GET_SCREEN_COORD_FROM_WORLD_COORD(event_coords.x, event_coords.y, event_coords.z, screen_coords_x, screen_coords_y)
    if enable_line then
        GRAPHICS.DRAW_LINE(self.get_pos().x, self.get_pos().y, self.get_pos().z, event_coords.x, event_coords.y, event_coords.z, 93, 182, 229, 255)
		GRAPHICS.REQUEST_STREAMED_TEXTURE_DICT("CommonMenu", false)
		GRAPHICS.DRAW_SPRITE("CommonMenu", "Common_Medal", screen_coords_x, screen_coords_y, 0.03, 0.06, 0.0, 93, 182, 229, 255, false, 0)
    end
    HUD.BEGIN_TEXT_COMMAND_DISPLAY_TEXT("STRING")
    HUD.ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(string.format("%s (%.2f%s)", (event_state == RE.STATES.ACTIVE and "~HUD_COLOUR_GREEN~" or "") .. RE.NAMES[selected_event + 1] .. "~s~", formatted_distance, km_or_m))
    HUD.SET_TEXT_RENDER_ID(1)
    HUD.SET_TEXT_OUTLINE()
    HUD.SET_TEXT_CENTRE(true)
    HUD.SET_TEXT_DROP_SHADOW()
    HUD.SET_TEXT_SCALE(0, 0.3)
    HUD.SET_TEXT_FONT(4)
    HUD.SET_TEXT_COLOUR(255, 255, 255, 240)
    HUD.END_TEXT_COMMAND_DISPLAY_TEXT(screen_coords_x, screen_coords_y - 0.03, 0)
    if enable_spheres then
        GRAPHICS.DRAW_MARKER(28, event_coords.x, event_coords.y, event_coords.z, 0, 0, 0, 0, 180, 0, event_trigger_range, event_trigger_range, event_trigger_range, 0, 153, 51, 40, true, true, 2, false, nil, nil, false)
        if event_blip_range ~= nil then
            GRAPHICS.DRAW_MARKER(28, event_coords.x, event_coords.y, event_coords.z, 0, 0, 0, 0, 180, 0, event_blip_range, event_blip_range, event_blip_range, 93, 182, 229, 40, true, true, 2, false, nil, nil, false)
        end
    end
end

local function LOOPED_NOTIFY_PLAYER()
    for i = 0, max_num_re - 1 do
        local state = globals.get_int(RE.GSBD_RE + 1 + (1 + (i * 15)))

        if state == RE.STATES.ACTIVE then
            if not notified_active[i] then
                local triggerer_index = GET_TRIGGERER_INDEX(i)

                if triggerer_index ~= -1 then
					local triggerer_name = PLAYER.GET_PLAYER_NAME(triggerer_index)
					
                    gui.show_message("Random Events", "" .. RE.NAMES[i + 1] .. " is triggered by " .. triggerer_name .. ".")
                    notified_active[i] = true
                end
            end
		end

		if state == RE.STATES.AVAILABLE then
			if not notified_available[i] then
				gui.show_message("Random Events", "" .. RE.NAMES[i + 1] .. " is available.")
				notified_available[i] = true
			end
		end

		if state == RE.STATES.INACTIVE then
			notified_available[i] = false
			notified_active[i] 	  = false
		end
    end
end

event.register_handler(menu_event.PlayerMgrInit, function()
    selected_target  = 0
    target_player_id = 0
end)

event.register_handler(menu_event.ScriptsReloaded, function()
	RESTORE_SHOULD_TRIGGER_FUNCTIONS()
end)

event.register_handler(menu_event.MenuUnloaded, function()
	RESTORE_SHOULD_TRIGGER_FUNCTIONS()
end)

script.register_looped("Random Events", function()
    LOOPED_UPDATE_RE_INFO()

    if re_initialized then
        if enable_esp and event_coords ~= RE.VECTOR_ZERO then
            LOOPED_RENDER_ESP()
        end

		if disable_all_events then
			HOOK_SHOULD_TRIGGER_FUNCTIONS(RE.RETURN_FALSE)
		end
		
		if bypass_requirements then
			HOOK_SHOULD_TRIGGER_FUNCTIONS(RE.RETURN_TRUE)
		end
		
		if set_target_player then
			SET_EVENT_TARGET(target_player_id)
		end
		
		if force_freemode_host and NETWORK.NETWORK_GET_HOST_OF_SCRIPT("freemode", -1, 0) ~= self.get_id() then
			network.force_script_host("freemode")
		end

        if enable_notifications then
            LOOPED_NOTIFY_PLAYER()
        end
    end
end)

re_tab:add_imgui(function()
    if re_initialized then
        if ImGui.BeginCombo("Select Event", RE.NAMES[selected_event + 1]) then
            for i = 1, #RE.NAMES do
                local is_selected = (i - 1 == selected_event)
                local state = globals.get_int(RE.GSBD_RE + 1 + (1 + ((i - 1) * 15)))

                if state == RE.STATES.INACTIVE then
                    ImGui.PushStyleColor(ImGuiCol.Text, 1, 0, 0, 1)
                elseif state == RE.STATES.AVAILABLE then
                    ImGui.PushStyleColor(ImGuiCol.Text, 1, 1, 1, 1)
                elseif state == RE.STATES.ACTIVE then
                    ImGui.PushStyleColor(ImGuiCol.Text, 0, 1, 0, 1)
                end

                if ImGui.Selectable(RE.NAMES[i], is_selected) then
                    selected_event = i - 1
                    selected_loc   = 0
                    if selected_event == RE.INSTANCES.ARMOURED_TRUCK then
                        set_cooldown     = globals.get_int(RE.COOLDOWNS[selected_event + 1])
                        set_availability = globals.get_int(RE.AVAILABILITIES[selected_event + 1])
                    else
                        set_cooldown     = tunables.get_int(RE.COOLDOWNS[selected_event + 1])
                        set_availability = tunables.get_int(RE.AVAILABILITIES[selected_event + 1])
                    end
                end

                if is_selected then
                    ImGui.SetItemDefaultFocus()
                end

                ImGui.PopStyleColor()
            end
            ImGui.EndCombo()
        end

        if set_target_player and (selected_event == RE.INSTANCES.PHANTOM_CAR or selected_event == RE.INSTANCES.XMAS_MUGGER) then
            selected_target = CLAMP(selected_target, 0, #target_players - 1)

            if ImGui.BeginCombo("Select Target", target_players[selected_target + 1].name) then
                for i, player in ipairs(target_players) do
                    local is_selected = (i - 1 == selected_target)

                    if ImGui.Selectable(player.name .. " (ID: " .. player.id ..")", is_selected) then
                        selected_target  = i - 1
                        target_player_id = player.id
                    end

                    if is_selected then
                        ImGui.SetItemDefaultFocus()
                    end
                end
                ImGui.EndCombo()
            end
        end

        if not IS_EVENT_EXCEPTION() and selected_event ~= RE.INSTANCES.VEHICLE_LIST and selected_event ~= RE.INSTANCES.BANK_SHOOTOUT and selected_event ~= RE.INSTANCES.XMAS_TRUCK then
            selected_loc, on_modified = ImGui.InputInt("Select Location (0-" .. RE.MAX_LOCATIONS[selected_event + 1] .. ")", selected_loc)

            if on_modified then
                selected_loc = CLAMP(selected_loc, 0, RE.MAX_LOCATIONS[selected_event + 1])
            end
        else
            ImGui.BeginDisabled()
            ImGui.InputInt("Select Location (0-" .. RE.MAX_LOCATIONS[selected_event + 1] .. ")", selected_loc)
            ImGui.EndDisabled()
        end

        if num_active_events >= max_events then
            ImGui.TextColored(1, 0, 0, 1, "Active Events: " .. num_active_events .. "/" .. max_events)
        else
            ImGui.Text("Active Events: " .. num_active_events .. "/" .. max_events)
        end
        HELP_MARKER("Shows the current number of active events (locally) out of the maximum allowed.")

        if ImGui.Button("Launch Event") then
            script.run_in_fiber(function(script)
                if event_state ~= RE.STATES.ACTIVE then
                    REQUEST_RANDOM_EVENT(selected_event, selected_loc)
                    script:sleep(500)
                    if event_state >= RE.STATES.AVAILABLE and event_variant == selected_loc then
                        gui.show_message("Random Events", "Successfully launched event.")
                    else
                        gui.show_error("Random Events", "Failed to launch event. Are you freemode host?")
                    end
                else
                    gui.show_error("Random Events", "Event is already active.")
                end
            end)
        end

        ImGui.SameLine()
		
		if ImGui.Button("Kill Event") then
			if event_state == RE.STATES.AVAILABLE then
				SET_EVENT_STATE(selected_event, RE.STATES.CLEANUP)
			elseif event_state == RE.STATES.ACTIVE then
				if event_host_id == self.get_id() then
					SET_EVENT_END_REASON(selected_event + 1, 3)
				else
					gui.show_error("Random Events", "Failed to kill event. You must be event host.")
				end
			else
				gui.show_error("Random Events", "Event is not active.")
			end
		end
		
        ImGui.SameLine()

        if not IS_EVENT_EXCEPTION() then
			if ImGui.Button("Teleport to Event") then
				script.run_in_fiber(function()
					if event_state >= RE.STATES.AVAILABLE then
						if event_coords ~= RE.VECTOR_ZERO then
							PED.SET_PED_COORDS_KEEP_VEHICLE(self.get_ped(), event_coords.x, event_coords.y, event_coords.z)
						else
							gui.show_error("Random Events", "Failed to teleport to event. Wait for coordinates to be updated.")
						end
					else
						gui.show_error("Random Events", "Event is not active.")
					end
				end)
			end
		else
			ImGui.BeginDisabled()
			ImGui.Button("Teleport to Event")
			ImGui.EndDisabled()
		end

        ImGui.Separator()

        ImGui.Text("State: " ..
			(event_state == RE.STATES.INACTIVE and "Inactive - launching in " .. cooldown_time_left or
			event_state == RE.STATES.AVAILABLE and "Available - deactivating in " .. availability_time_left or
			event_state == RE.STATES.ACTIVE and "Active" or
			event_state == RE.STATES.CLEANUP and "Cleanup" or
			"None"))
        HELP_MARKER("Shows the current state of the event.\n- Inactive\n- Available\n- Active\n- Cleanup")
		
		if event_state == RE.STATES.ACTIVE then
			ImGui.Text("Host: " .. event_host_name)
			
			ImGui.SameLine()
			
			if event_host_id ~= self.get_id() then
				if ImGui.SmallButton("Take Control") then
					script.run_in_fiber(function()
						if SCRIPT.GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH(joaat(RE.SCRIPTS[selected_event + 1])) ~= 0 then
							network.force_script_host(RE.SCRIPTS[selected_event + 1])
						else
							gui.show_error("Random Events", "Event script is not active. Are you a participant?")
						end
					end)
				end
			else
				ImGui.BeginDisabled()
				ImGui.SmallButton("Take Control")
				ImGui.EndDisabled()
			end
		end

        ImGui.Text("Location: " .. (event_variant ~= -1 and event_variant or "N/A"))
        HELP_MARKER("Shows the current location of the event.")

        ImGui.Text("Trigger Range: " .. (event_state >= RE.STATES.AVAILABLE and math.floor(event_trigger_range) .. " meters" or "N/A"))
        HELP_MARKER("Shows the distance required to trigger the event when available.")

        ImGui.Text("Blip Range: " .. ((event_state >= RE.STATES.AVAILABLE and event_blip_range ~= nil) and math.floor(event_blip_range) .. " meters" or "N/A"))
        HELP_MARKER("Shows the distance for the blip to appear when approaching the event (if applicable).")

        ImGui.Text("Entities: "  .. num_entities[1] + num_entities[2] + num_entities[3] .. "/" .. max_entities[1] + max_entities[2]+ max_entities[3])
        HELP_MARKER("Shows the amount of reserved entities for the event out of the maximum allowed.")

        ImGui.Text("Cooldown: "  .. math.floor(event_cooldown / 60000) .. " minutes")
        HELP_MARKER("Shows the duration that the event will be in the inactive state.")

        ImGui.Text("Availability: " .. math.floor(event_availability / 60000) .. " minutes")
        HELP_MARKER("Shows the duration that the event will be in the available state.")

        ImGui.Separator()

        if ImGui.CollapsingHeader("Cooldown & Availability Editor") then
            set_cooldown = ImGui.InputInt("Cooldown##cooldown", set_cooldown)

            if ImGui.Button("Apply##apply_cooldown") then
                script.run_in_fiber(function(script)
					local value = apply_in_minutes and (set_cooldown * 60000) or set_cooldown
					SET_EVENT_COOLDOWN(selected_event, value)
					script:sleep(500)
					if event_cooldown ~= value then
						gui.show_error("Random Events", "Failed to set event cooldown. Are you freemode host?")
					end
				end)
            end

            set_availability = ImGui.InputInt("Availability##availability", set_availability)

            if ImGui.Button("Apply##apply_availability") then
                script.run_in_fiber(function(script)
					local value = apply_in_minutes and (set_availability * 60000) or set_availability
					SET_EVENT_AVAILABILITY(selected_event, value)
					script:sleep(500)
					if event_cooldown ~= value then
						gui.show_error("Random Events", "Failed to set event availability. Are you freemode host?")
					end
				end)
            end
        
            apply_in_minutes = ImGui.Checkbox("Apply in Minutes", apply_in_minutes)
        end

        if ImGui.CollapsingHeader("Settings") then
            if not IS_EVENT_EXCEPTION() and event_state ~= RE.STATES.INACTIVE then
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

            disable_all_events, on_tick = ImGui.Checkbox("Disable All Events", disable_all_events)
            HELP_MARKER("Prevents all the events from being triggered.")

            if on_tick then
                if not disable_all_events then
                    RESTORE_SHOULD_TRIGGER_FUNCTIONS()
                end
            end

            if not disable_all_events then
                bypass_requirements, on_tick = ImGui.Checkbox("Bypass Requirements", bypass_requirements)

                if on_tick then
                    if not bypass_requirements then
                        RESTORE_SHOULD_TRIGGER_FUNCTIONS()
                    end
                end
            else
                bypass_requirements = false
                ImGui.BeginDisabled()
                ImGui.Checkbox("Bypass Requirements", bypass_requirements)
                ImGui.EndDisabled()
            end
            HELP_MARKER("Bypasses all the requirements to trigger an event such as is tunable enabled, number of players, time of day, etc. Use with caution.")

            if selected_event == RE.INSTANCES.PHANTOM_CAR or selected_event == RE.INSTANCES.XMAS_MUGGER then
                set_target_player, on_tick = ImGui.Checkbox("Set Target Player", set_target_player)
				
				if on_tick then
					if not set_target_player then
						SET_EVENT_TARGET(-1)
					end
				end
            else
                set_target_player = false
                ImGui.BeginDisabled()
                ImGui.Checkbox("Set Target Player", set_target_player)
                ImGui.EndDisabled()
            end
            HELP_MARKER("Allows you to set the target of Phantom Car and Gooch.")

            enable_notifications = ImGui.Checkbox("Notifications", enable_notifications)
            HELP_MARKER("Notifies you whenever an event is available or active.")
			
			force_freemode_host = ImGui.Checkbox("Force Freemode Host", force_freemode_host)
			HELP_MARKER("Forces you to always become freemode host. It is REQUIRED for script to work correctly.")
        end
    else
        ImGui.Text("Random Events aren't initialized yet.")
    end
end)
