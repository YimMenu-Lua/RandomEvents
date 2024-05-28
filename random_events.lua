local re_tab = gui.get_tab("GUI_TAB_NETWORK"):add_tab("Random Events")

local RE = {
    CORE = {
    	REQUEST_RE_HASH = -126218586,
    	GSBD_RE         = 1882037,
    	GPBD_FM_2       = 1882422,
    	FMRE_DATA       = 15544,
    	VECTOR_ZERO     = vec3:new(0.0, 0.0, 0.0),
    	MAX_LOCATIONS   = { 29, 8, 9, 0, 7, 0, 0, 14, 11, 4, 9, 9, 6, 24, 0, 0, 9, 17, 9, 0 }
    },
    IDS = {
    	DRUG_VEHICLE      = 0,
    	MOVIE_PROPS       = 1,
    	GOLDEN_GUN        = 2,
    	VEHICLE_LIST      = 3,
    	SLASHER           = 4,
    	PHANTOM_CAR       = 5,
    	SIGHTSEEING       = 6,
    	SMUGGLER_TRAIL    = 7,
    	CERBERUS          = 8,
    	SMUGGLER_PLANE    = 9,
    	CRIME_SCENE       = 10,
    	METAL_DETECTOR    = 11,
    	CONVOY            = 12,
    	ROBBERY           = 13,
    	XMAS_MUGGER       = 14,
    	BANK_SHOOTOUT     = 15,
    	ARMOURED_TRUCK    = 16,
    	POSSESSED_ANIMALS = 17,
    	GHOSTHUNT         = 18,
    	XMAS_TRUCK        = 19
    },
    STATES = {
    	INACTIVE  = 0,
    	AVAILABLE = 1,
    	ACTIVE    = 2,
    	CLEANUP   = 3
    },
    LOCALS = {
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
        COORD_DELAYS = {
            { 1733, 145 },
            { 1859, 167 },
            { 1730, 127 },
            { 1539, 113 },
            { 1568, 113 },
            { 1548, 113 },
            { 1790, 114 },
            { 2170, 248 },
            { 1560, 121 },
            { 1807, 208 },
            { 1916, 185 },
            { 1778, 128 },
            { 2704, 469 },
            { 1694, 123 },
            { 1591, 113 },
            { 2175, 255 },
            { 1868, 147 },
            { 1564, 113 },
            { 1522, 118 },
            { 1432, 121 }
        }
    },
    FUNC_HOOKS = {
        FM_RETURN_TRUE  = 29788,  -- func_144 - 0x745C, freemode
        FM_RETURN_FALSE = 504300, -- func_1034 - 0x7B1EC, freemode
        SHOULD_TRIGGER = {
            2767956, -- func_8742 - 0x2A3C54, freemode
            2767720, -- func_8737 - 0x2A3B68, freemode
            2767675, -- func_8735 - 0x2A3B3B, freemode
            2767613, -- func_8733 - 0x2A3AFD, freemode
            2764516, -- func_8726 - 0x2A2EE4, freemode
            2763652, -- func_8718 - 0x2A2B84, freemode (should be available check)
            2763420, -- func_8714 - 0x2A2A9C, freemode
            2763350, -- func_8713 - 0x2A2A56, freemode
            2762838, -- func_8707 - 0x2A2856, freemode
            2762747, -- func_8704 - 0x2A27FB, freemode
            2762669, -- func_8702 - 0x2A27AD, freemode
            2762594, -- func_8700 - 0x2A2762, freemode
            2762516, -- func_8698 - 0x2A2714, freemode
            2762438, -- func_8696 - 0x2A26C6, freemode
            2761589, -- func_8686 - 0x2A2375, freemode (should be available check)
            2761461, -- func_8683 - 0x2A22F5, freemode
            2761371, -- func_8680 - 0x2A229B, freemode
            2760882, -- func_8671 - 0x2A20B2, freemode
            2760044, -- func_8668 - 0x2A1D6C, freemode
            2759990  -- func_8667 - 0x2A1D36, freemode (should be available check)
        },
        REAL_COORDS = {
            2147715, -- func_7792 - 0x20C583, fm_content_slasher
            2149112, -- func_7784 - 0x20CAF8, fm_content_phantom_car
            1881702, -- func_5988 - 0x1CB666, fm_content_sightseeing (returns the closest UFO's coords, aka the one closer than 300f)
            2165541, -- func_7802 - 0x210B25, fm_content_cerberus
            2152762, -- func_7810 - 0x20D93A, fm_content_xmas_mugger
            2150150  -- func_7800 - 0x20CF06, fm_content_possessed_animals
        }
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
    }
}

local selected_event       = 0
local selected_target      = 0
local selected_loc         = 0
local set_cooldown         = 1800000
local set_availability     = 900000
local enable_esp           = true
local enable_line          = true
local enable_sphere        = true
local enable_notifications = true
local force_freemode_host  = true
local apply_in_minutes     = false
local set_target_player    = false
local enable_tunables      = false
local bypass_requirements  = false
local disable_all_events   = false
local logging              = false
local notified_available   = {}
local notified_active      = {}
local is_tunable_active    = {}

local event_coords           = RE.CORE.VECTOR_ZERO
local event_state            = RE.STATES.INACTIVE
local event_trigger_range    = 0.0
local event_timer            = 0
local event_variation        = 0
local event_cooldown         = 0
local event_availability     = 0
local max_num_re             = 0
local max_events             = 0
local num_active_events      = 0
local event_host_id          = 0
local target_player_id       = 0
local re_initialized         = false
local cooldown_time_left     = "00:00:00"
local availability_time_left = "00:00:00"
local event_host_name        = "**Invalid**"
local target_players         = {}

local function IS_SCRIPT_ACTIVE(script_name)
    return SCRIPT.GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH(joaat(script_name)) > 0
end

local function CLAMP(value, min, max)
    return math.min(math.max(value, min), max)
end

local function COMBO_CLEANUP()
    selected_loc = 0
    if selected_event == RE.IDS.ARMOURED_TRUCK then
    	set_cooldown     = globals.get_int(RE.COOLDOWNS[selected_event + 1])
    	set_availability = globals.get_int(RE.AVAILABILITIES[selected_event + 1])
    else
    	set_cooldown     = tunables.get_int(RE.COOLDOWNS[selected_event + 1])
    	set_availability = tunables.get_int(RE.AVAILABILITIES[selected_event + 1])
    end
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

-- This script event enables the first bit of Global_1882037.f_1[event /*15*/].f_3, which the script ignores all the checks if it is enabled.
local function REQUEST_RANDOM_EVENT(event, variation)
    local fmmc_type = locals.get_int("freemode", RE.CORE.FMRE_DATA + 241 + 1 + (event + 1))
    local args      = { RE.CORE.REQUEST_RE_HASH, 0, -1, fmmc_type, 0, variation, 0 }
    
    network.trigger_script_event(-1, args)
end

local function HOOK_SHOULD_TRIGGER_FUNCTIONS(value)
    for i = 0, max_num_re - 1 do
        if i == RE.IDS.PHANTOM_CAR or i == RE.IDS.XMAS_MUGGER or i == RE.IDS.XMAS_TRUCK then
            locals.set_int("freemode", RE.CORE.FMRE_DATA + (1 + (i * 12)) + 5, value)
        else
            locals.set_int("freemode", RE.CORE.FMRE_DATA + (1 + (i * 12)) + 1 + 1, value)
        end
    end
end

local function RESTORE_SHOULD_TRIGGER_FUNCTIONS()
    for i = 0, max_num_re - 1 do
        if i == RE.IDS.PHANTOM_CAR or i == RE.IDS.XMAS_MUGGER or i == RE.IDS.XMAS_TRUCK then
            locals.set_int("freemode", RE.CORE.FMRE_DATA + (1 + (i * 12)) + 5, RE.FUNC_HOOKS.SHOULD_TRIGGER[i + 1])
        else
            locals.set_int("freemode", RE.CORE.FMRE_DATA + (1 + (i * 12)) + 1 + 1, RE.FUNC_HOOKS.SHOULD_TRIGGER[i + 1])
        end
    end
end

-- The original functions return a null vector, resulting in the script event not updating the value of Global_1882037.f_1[event /*15*/].f_10. To fix this issue, I replace the value of local pointers with the actual functions that return the coordinates of the event.
local function PATCH_EVENT_COORDS()
    -- The game crashes on session change if I set the values in a loop when script is not active for some reason.
    if IS_SCRIPT_ACTIVE("fm_content_slasher") then
        locals.set_int("fm_content_slasher", 403 + 100, RE.FUNC_HOOKS.REAL_COORDS[1])
    end
    if IS_SCRIPT_ACTIVE("fm_content_phantom_car") then
    	locals.set_int("fm_content_phantom_car", 386 + 100, RE.FUNC_HOOKS.REAL_COORDS[2])
    end
    if IS_SCRIPT_ACTIVE("fm_content_sightseeing") then
    	locals.set_int("fm_content_sightseeing", 484 + 100, RE.FUNC_HOOKS.REAL_COORDS[3])
    end
    if IS_SCRIPT_ACTIVE("fm_content_cerberus") then
    	locals.set_int("fm_content_cerberus", 401 + 100, RE.FUNC_HOOKS.REAL_COORDS[4])
    end
    if IS_SCRIPT_ACTIVE("fm_content_xmas_mugger") then
    	locals.set_int("fm_content_xmas_mugger", 415 + 100, RE.FUNC_HOOKS.REAL_COORDS[5])
    end
    if IS_SCRIPT_ACTIVE("fm_content_possessed_animals") then
    	locals.set_int("fm_content_possessed_animals", 399 + 100, RE.FUNC_HOOKS.REAL_COORDS[6])
    end
end

local function RESET_UPDATE_EVENT_COORDS_DELAY()
    for i = 0, max_num_re - 1 do
        if IS_SCRIPT_ACTIVE(RE.SCRIPTS[i + 1]) then
            local base_address = RE.LOCALS.COORD_DELAYS[i + 1][1]
            local offset       = RE.LOCALS.COORD_DELAYS[i + 1][2]
            
            locals.set_int(RE.SCRIPTS[i + 1], base_address + offset + 1, 1) -- There will be a race condition here since the script will set the value back to 0 just before sending the script event, but this shouldn't be a big problem.
        end
    end
end

local function SET_EVENT_STATE(event, state)
    globals.set_int(RE.CORE.GSBD_RE + 1 + (1 + (event * 15)), state)
end

local function SET_EVENT_COOLDOWN(event, value)
    locals.set_int("freemode", RE.CORE.FMRE_DATA + (1 + (event * 12)) + 6, value)
end

local function SET_EVENT_AVAILABILITY(event, value)
    locals.set_int("freemode", RE.CORE.FMRE_DATA + (1 + (event * 12)) + 7, value)
end

local function SET_EVENT_TARGET(target_id)
    globals.set_int(RE.CORE.GSBD_RE + 304, target_id) -- Phantom Car Target (Also the Slasher target, but it doesn't work)
    globals.set_int(RE.CORE.GSBD_RE + 304 + 1, target_id) -- Gooch Target
end

local function SET_EVENT_END_REASON(event, reason)
    local base_address = RE.LOCALS.END_REASONS[event][1]
    local offset 	   = RE.LOCALS.END_REASONS[event][2]
    
    locals.set_int(RE.SCRIPTS[event], base_address + offset, reason)
end

local function SET_SPECIAL_EVENT_TUNABLES(toggle)
    tunables.set_int("STANDARDCONTROLLERVOLUME", toggle and 1 or -1)
    tunables.set_int("STANDARDTARGETTINGTIME", toggle and 1 or -1)
    tunables.set_int("SSP2POSIX", toggle and NETWORK.GET_CLOUD_TIME_AS_INT() or -1) -- Make the posix match with the seed (it will get stuck on day 1, though).
    tunables.set_bool("ENABLE_SU22_SMUGGLER_TRAIL", toggle)
    tunables.set_int("NC_SOURCE_TRUCK_HEAD_COUNT", toggle and 3 or 1)
    tunables.set_int("STANDARD_KEYBIND_SELECTION", toggle and 1 or -1)
    tunables.set_bool("ENABLE_MAZEBANKSHOOTOUT_DLC22022", toggle)
    tunables.set_bool("ENABLE_HALLOWEEN_POSSESSED_ANIMAL", toggle)
    tunables.set_bool("ENABLE_HALLOWEEN_GHOSTHUNT", toggle)
    tunables.set_bool(2093114948, toggle)
end

local function CHECK_EVENT_TUNABLES()
    is_tunable_active[RE.IDS.DRUG_VEHICLE + 1]      = tunables.get_bool("SUM_RANDOM_EVENT_DRUG_VEHICLE_ENABLE")
    is_tunable_active[RE.IDS.MOVIE_PROPS + 1]       = tunables.get_bool("COLLECTABLES_MOVIE_PROPS")
    is_tunable_active[RE.IDS.GOLDEN_GUN + 1]        = true -- Sleeping Guard (no tunable)
    is_tunable_active[RE.IDS.VEHICLE_LIST + 1]      = true -- Exotic Exports (no tunable)
    is_tunable_active[RE.IDS.SLASHER + 1]           = tunables.get_int("STANDARDCONTROLLERVOLUME") ~= -1
    is_tunable_active[RE.IDS.PHANTOM_CAR + 1]       = tunables.get_int("STANDARDTARGETTINGTIME") ~= -1
    is_tunable_active[RE.IDS.SIGHTSEEING + 1]       = tunables.get_int("SSP2POSIX") > 0
    is_tunable_active[RE.IDS.SMUGGLER_TRAIL + 1]    = tunables.get_bool("ENABLE_SU22_SMUGGLER_TRAIL")
    is_tunable_active[RE.IDS.CERBERUS + 1]          = tunables.get_int("NC_SOURCE_TRUCK_HEAD_COUNT") == 3
    is_tunable_active[RE.IDS.SMUGGLER_PLANE + 1]    = tunables.get_bool("ENABLE_SU22_SMUGGLER_PLANE")
    is_tunable_active[RE.IDS.CRIME_SCENE + 1]       = tunables.get_bool("ENABLE_SUM22_CRIME_SCENES")
    is_tunable_active[RE.IDS.METAL_DETECTOR + 1]    = tunables.get_bool("COLLECTABLES_BURIED_STASH")
    is_tunable_active[RE.IDS.CONVOY + 1]            = tunables.get_bool("ENABLE_GANGCONVOY_DLC22022")
    is_tunable_active[RE.IDS.ROBBERY + 1]           = tunables.get_bool("XM22_ROBBERY_ENABLE")
    is_tunable_active[RE.IDS.XMAS_MUGGER + 1]       = tunables.get_int("STANDARD_KEYBIND_SELECTION") ~= -1
    is_tunable_active[RE.IDS.BANK_SHOOTOUT + 1]     = tunables.get_bool("ENABLE_MAZEBANKSHOOTOUT_DLC22022")
    is_tunable_active[RE.IDS.ARMOURED_TRUCK + 1]    = tunables.get_bool("ENABLE_RANDOM_EVENT_ARMORED_TRUCK")
    is_tunable_active[RE.IDS.POSSESSED_ANIMALS + 1] = tunables.get_bool("ENABLE_HALLOWEEN_POSSESSED_ANIMAL")
    is_tunable_active[RE.IDS.GHOSTHUNT + 1]         = tunables.get_bool("ENABLE_HALLOWEEN_GHOSTHUNT")
    is_tunable_active[RE.IDS.XMAS_TRUCK + 1]        = tunables.get_bool(2093114948)
end

local function ARE_EVENTS_INITIALIZED()
    return globals.get_int(RE.CORE.GPBD_FM_2 + (1 + (self.get_id() * 142)) + 78) == 1
end

local function GET_MAX_NUMBER_OF_EVENTS()
    return locals.get_int("freemode", RE.CORE.FMRE_DATA + 241)
end

local function GET_PLAYER_STATE(event, player_id)
    return globals.get_int(RE.CORE.GPBD_FM_2 + (1 + (player_id * 142)) + 78 + 1 + (1 + (event * 3)))
end

local function GET_EVENT_STATE(event)
    return globals.get_int(RE.CORE.GSBD_RE + 1 + (1 + (event * 15)))
end

local function GET_EVENT_VARIATION(event)
    return globals.get_int(RE.CORE.GSBD_RE + 1 + (1 + (event * 15)) + 6)
end

local function GET_EVENT_COORDS(event)
    if event == RE.IDS.GHOSTHUNT then
    	return locals.get_vec3(RE.SCRIPTS[RE.IDS.GHOSTHUNT + 1], 230 + 85 + 1 + (1 + (0 * 12)) + 4)
    else
    	return globals.get_vec3(RE.CORE.GSBD_RE + 1 + (1 + (event * 15)) + 10)
    end
end

local function GET_EVENT_TRIGGER_RANGE(event)
    return globals.get_float(RE.CORE.GSBD_RE + 1 + (1 + (event * 15)) + 13)
end

local function GET_EVENT_TIMER(event)
    return globals.get_int(RE.CORE.GSBD_RE + 1 + (1 + (event * 15)) + 1)
end

local function GET_EVENT_COOLDOWN(event)
    return locals.get_int("freemode", RE.CORE.FMRE_DATA + (1 + (event * 12)) + 6)
end

local function GET_EVENT_AVAILABILITY(event)
    return locals.get_int("freemode", RE.CORE.FMRE_DATA + (1 + (event * 12)) + 7)
end

local function GET_NUM_LOCALLY_ACTIVE_EVENTS()
    local num_events = 0
    
    for i = 0, max_num_re - 1 do
        local local_state = GET_PLAYER_STATE(i, self.get_id())
        
        if local_state ~= RE.STATES.INACTIVE then
            num_events = num_events + 1
        end
    end
    
    return num_events
end

local function GET_TRIGGERER_INDEX(event)
    for i = 0, 31 do
        local player_state = GET_PLAYER_STATE(event, i)
        
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

local function GET_EVENT_TIME_LEFT(event_time, timer)
    local time_passed   = MISC.ABSI(NETWORK.GET_TIME_DIFFERENCE(NETWORK.GET_NETWORK_TIME(), timer))
    local diff 	        = NETWORK.GET_TIME_DIFFERENCE(event_time, time_passed)
    local total_seconds = math.floor(diff / 1000)
    local hours         = math.floor(total_seconds / 3600)
    local minutes       = math.floor((total_seconds % 3600) / 60)
    local seconds       = total_seconds % 60
    local formatted     = ""
    
    if hours < 1 then
        formatted = string.format("%02d:%02d", minutes, seconds)
    else
        formatted = string.format("%02d:%02d:%02d", hours, minutes, seconds)
    end
    
    return formatted
end

local function LOOPED_UPDATE_RE_INFO()
    re_initialized         = ARE_EVENTS_INITIALIZED()
    max_num_re             = GET_MAX_NUMBER_OF_EVENTS()
    num_active_events      = GET_NUM_LOCALLY_ACTIVE_EVENTS()
    target_players         = GET_TARGET_PLAYERS()
    event_state            = GET_EVENT_STATE(selected_event)
    event_coords           = GET_EVENT_COORDS(selected_event)
    event_variation        = GET_EVENT_VARIATION(selected_event)
    event_trigger_range    = GET_EVENT_TRIGGER_RANGE(selected_event)
    event_timer            = GET_EVENT_TIMER(selected_event)
    event_cooldown         = GET_EVENT_COOLDOWN(selected_event)
    event_availability     = GET_EVENT_AVAILABILITY(selected_event)
    cooldown_time_left     = GET_EVENT_TIME_LEFT(event_cooldown, event_timer)
    availability_time_left = GET_EVENT_TIME_LEFT(event_availability, event_timer)
    event_host_id          = NETWORK.NETWORK_GET_HOST_OF_SCRIPT(RE.SCRIPTS[selected_event + 1], selected_event, 0)
    event_host_name 	   = PLAYER.GET_PLAYER_NAME(event_host_id)
    max_active_events      = tunables.get_int("FMREMAXACTIVATEDEVENTS")
end

local function LOOPED_RENDER_ESP()
    if IS_SCRIPT_ACTIVE("appinternet") or
    HUD.IS_PAUSE_MENU_ACTIVE() or
    NETWORK.NETWORK_IS_IN_MP_CUTSCENE() or not
    CAM.IS_GAMEPLAY_CAM_RENDERING() or
    HUD.IS_HUD_COMPONENT_ACTIVE(16) or -- HUD_RADIO_STATIONS
    HUD.IS_HUD_COMPONENT_ACTIVE(19) or -- HUD_WEAPON_WHEEL
    globals.get_int(23572 + 4) == 1 then -- is selector UI rendering
        return
    end
    
    for i = 0, max_num_re - 1 do
    	local state         = GET_EVENT_STATE(i)
    	local coords        = GET_EVENT_COORDS(i)
    	local timer         = GET_EVENT_TIMER(i)
    	local availability  = GET_EVENT_AVAILABILITY(i)
    	local time_left     = GET_EVENT_TIME_LEFT(availability, timer)
    	local trigger_range = GET_EVENT_TRIGGER_RANGE(i)	
    	local colors        = state == RE.STATES.ACTIVE and { 0, 153, 51 } or { 93, 182, 229 }
    
    	if state ~= RE.STATES.INACTIVE and coords ~= RE.CORE.VECTOR_ZERO then
            local distance           = MISC.GET_DISTANCE_BETWEEN_COORDS(self.get_pos().x, self.get_pos().y, self.get_pos().z, coords.x, coords.y, coords.z, false)
            local km_or_m            = (distance < 1000) and "m" or "km"
            local formatted_distance = (distance < 1000) and distance or (distance / 1000.0)
            local text               = string.format("%s (%.2f%s) %s", (state == RE.STATES.ACTIVE and "~HUD_COLOUR_GREEN~" or "") .. RE.NAMES[i + 1] .. "~s~", formatted_distance, km_or_m, (state == RE.STATES.AVAILABLE and "~n~" .. time_left or ""))
            local screen_x           = 0.0
            local screen_y           = 0.0
            
            _, screen_x, screen_y = GRAPHICS.GET_SCREEN_COORD_FROM_WORLD_COORD(coords.x, coords.y, coords.z, screen_x, screen_y)
            
            if enable_line then
            	GRAPHICS.DRAW_LINE(self.get_pos().x, self.get_pos().y, self.get_pos().z, coords.x, coords.y, coords.z, colors[1], colors[2], colors[3], 255)
            end
            
            HUD.BEGIN_TEXT_COMMAND_DISPLAY_TEXT("STRING")
            HUD.ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(text)
            HUD.SET_TEXT_RENDER_ID(1)
            HUD.SET_TEXT_OUTLINE()
            HUD.SET_TEXT_CENTRE(true)
            HUD.SET_TEXT_DROP_SHADOW()
            HUD.SET_TEXT_SCALE(0, 0.3)
            HUD.SET_TEXT_FONT(4)
            HUD.SET_TEXT_COLOUR(255, 255, 255, 240)
            HUD.END_TEXT_COMMAND_DISPLAY_TEXT(screen_x, screen_y - 0.03, 0)
            
            if enable_sphere and state ~= RE.STATES.ACTIVE then
            	GRAPHICS.DRAW_MARKER(28, coords.x, coords.y, coords.z, 0, 0, 0, 0, 180, 0, trigger_range, trigger_range, trigger_range, colors[1], colors[2], colors[3], 40, true, true, 2, false, nil, nil, false)
            end
    	end
    end
end

local function LOOPED_NOTIFY_PLAYER()
    for i = 0, max_num_re - 1 do
        local state = GET_EVENT_STATE(i)
        
        if state == RE.STATES.ACTIVE then
            if not notified_active[i] then
                local triggerer_index = GET_TRIGGERER_INDEX(i)
            
                if triggerer_index ~= -1 then
                    local triggerer_name = PLAYER.GET_PLAYER_NAME(triggerer_index)
                
                    gui.show_message("Random Events", "" .. RE.NAMES[i + 1] .. " is triggered by " .. triggerer_name .. ".")
                    if logging then log.info("" .. RE.NAMES[i + 1] .. " is triggered by " .. triggerer_name .. ".") end
                    notified_active[i] = true
                end
            end
        end
        
        if state == RE.STATES.AVAILABLE then
            if not notified_available[i] then
            	if is_tunable_active[i + 1] then
                    gui.show_message("Random Events", "" .. RE.NAMES[i + 1] .. " is available.")
                    if logging then log.info("" .. RE.NAMES[i + 1] .. " is available.") end
            	else
                    gui.show_warning("Random Events", "" .. RE.NAMES[i + 1] .. " is available.\nWarning: Tunable is not active.")
                    if logging then log.warning("" .. RE.NAMES[i + 1] .. " is available (tunable is not active).") end
            	end
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
    	if enable_esp then
            LOOPED_RENDER_ESP()
        end
    
    	if enable_tunables then
            SET_SPECIAL_EVENT_TUNABLES(true)
    	end
    
    	if bypass_requirements then
            HOOK_SHOULD_TRIGGER_FUNCTIONS(RE.FUNC_HOOKS.FM_RETURN_TRUE)
    	end
    
    	if disable_all_events then
            HOOK_SHOULD_TRIGGER_FUNCTIONS(RE.FUNC_HOOKS.FM_RETURN_FALSE)
    	end
    
    	if set_target_player then
            SET_EVENT_TARGET(target_player_id)
    	end
    
    	if force_freemode_host and NETWORK.NETWORK_GET_HOST_OF_SCRIPT("freemode", -1, 0) ~= self.get_id() then
            network.force_script_host("freemode")
    	end
    
        if enable_notifications then
            CHECK_EVENT_TUNABLES()
            LOOPED_NOTIFY_PLAYER()
        end
    
        PATCH_EVENT_COORDS()
        RESET_UPDATE_EVENT_COORDS_DELAY()
    end
end)

re_tab:add_imgui(function()
    if not re_initialized then
        ImGui.Text("Random Events are not initialized.")
    	return
    end
	
    if ImGui.BeginCombo("Select Event", RE.NAMES[selected_event + 1]) then
        for i = 1, #RE.NAMES do
            local is_selected = (i - 1 == selected_event)
            local state       = GET_EVENT_STATE(i - 1)
        
            if state == RE.STATES.INACTIVE then
                ImGui.PushStyleColor(ImGuiCol.Text, 1, 0, 0, 1)
            elseif state == RE.STATES.AVAILABLE then
            	ImGui.PushStyleColor(ImGuiCol.Text, 1, 1, 1, 1)
            elseif state == RE.STATES.ACTIVE then
            	ImGui.PushStyleColor(ImGuiCol.Text, 0, 1, 0, 1)
            end
            
            if ImGui.Selectable(RE.NAMES[i], is_selected) then
            	selected_event = i - 1
            	COMBO_CLEANUP()
            end
            
            if is_selected then
            	ImGui.SetItemDefaultFocus()
            end
            
            ImGui.PopStyleColor()
        end
        ImGui.EndCombo()
    end
	
    selected_loc, on_modified = ImGui.InputInt("Select Location (0-" .. RE.CORE.MAX_LOCATIONS[selected_event + 1] .. ")", selected_loc)
    
    if on_modified then
    	selected_loc = CLAMP(selected_loc, 0, RE.CORE.MAX_LOCATIONS[selected_event + 1])
    end
    
    if num_active_events >= max_active_events then
    	ImGui.TextColored(1, 0, 0, 1, "Active Events: " .. num_active_events .. "/" .. max_active_events)
    else
    	ImGui.Text("Active Events: " .. num_active_events .. "/" .. max_active_events)
    end
    HELP_MARKER("Shows the current number of active events (locally) out of the maximum allowed.")
	
    if ImGui.Button("Launch Event") then
    	script.run_in_fiber(function(script)
            if event_state ~= RE.STATES.ACTIVE then
            	REQUEST_RANDOM_EVENT(selected_event, selected_loc)
            	script:sleep(500)
            	if event_state == RE.STATES.INACTIVE and event_variation ~= selected_loc then
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
    
    if ImGui.Button("Teleport to Event") then
        script.run_in_fiber(function()
            if event_state >= RE.STATES.AVAILABLE then
            	if event_coords ~= RE.CORE.VECTOR_ZERO then
                    PED.SET_PED_COORDS_KEEP_VEHICLE(self.get_ped(), event_coords.x, event_coords.y, event_coords.z)
            	else
                    gui.show_error("Random Events", "Failed to teleport to event. Wait for coordinates to be updated.")
            	end
            else
                gui.show_error("Random Events", "Event is not active.")
            end
        end)
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
                    if IS_SCRIPT_ACTIVE(RE.SCRIPTS[selected_event + 1]) then
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
	
    ImGui.Text("Location: " .. (event_variation ~= -1 and event_variation or "N/A"))
    HELP_MARKER("Shows the current location of the event.")
    
    ImGui.Text("Trigger Range: " .. (event_state >= RE.STATES.AVAILABLE and math.floor(event_trigger_range) .. " meters" or "N/A"))
    HELP_MARKER("Shows the distance required to trigger the event when available.")
    
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
                if event_availability ~= value then
                    gui.show_error("Random Events", "Failed to set event availability. Are you freemode host?")
                end
            end)
        end
        
        apply_in_minutes = ImGui.Checkbox("Apply in Minutes", apply_in_minutes)
    end
    
    if ImGui.CollapsingHeader("Settings") then
        enable_esp = ImGui.Checkbox("ESP", enable_esp)
        if enable_esp then
            ImGui.SameLine()
            enable_sphere = ImGui.Checkbox("Sphere", enable_sphere)
            ImGui.SameLine()
            enable_line = ImGui.Checkbox("Line", enable_line)
        end
        
        ImGui.Separator()
        
        set_target_player, on_tick = ImGui.Checkbox("Set Target Player", set_target_player)
        HELP_MARKER("Allows you to set the target of Phantom Car and Gooch.")
        
        if on_tick then
            if not set_target_player then
            	SET_EVENT_TARGET(-1)
            end
        end
        
        if set_target_player then
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
            
            ImGui.Separator()
        end
        
        enable_tunables, on_tick = ImGui.Checkbox("Enable Tunables", enable_tunables)
        HELP_MARKER("Enables the tunables of special events such as Cerberus, Sightseeing, etc.")
        
        if on_tick then
            if not enable_tunables then
            	SET_SPECIAL_EVENT_TUNABLES(false)
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
        
        disable_all_events, on_tick = ImGui.Checkbox("Disable All Events", disable_all_events)
        HELP_MARKER("Prevents all the events from being triggered.")
        
        if on_tick then
            if not disable_all_events then
            	RESTORE_SHOULD_TRIGGER_FUNCTIONS()
            end
        end
        
        enable_notifications = ImGui.Checkbox("Notifications", enable_notifications)
        HELP_MARKER("Notifies you whenever an event is available or triggered.")        
        if enable_notifications then
            ImGui.SameLine()           
            logging = ImGui.Checkbox("Also Log", logging)
        else
            logging = false
        end
        
        force_freemode_host = ImGui.Checkbox("Force Freemode Host", force_freemode_host)
        HELP_MARKER("Forces you to always become freemode host. It is required for script to work correctly.")
    end	
end)