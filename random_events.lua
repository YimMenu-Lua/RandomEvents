-- TO-DO:
-- Reset event tunables to their cloud value if available.
-- Cleanup script on reload or unload.

local re_tab = gui.get_tab("GUI_TAB_NETWORK"):add_tab("Random Events")

local RE = {
    CORE = {
    	REQUEST_RE_HASH = -126218586,
    	GSBD_RE         = 1882247,
    	GPBD_FM_2       = 1882632,
    	FMRE_DATA       = 15727
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
            [0]  = { 1762, 115 },
            [1]  = { 1888, 137 },
            [2]  = { 1762, 93  },
            [3]  = { 1568, 83  },
            [4]  = { 1597, 83  },
            [5]  = { 1577, 83  },
            [6]  = { 1822, 84  },
            [7]  = { 2051, 130 },
            [8]  = { 1589, 91  },
            [9]  = { 1838, 178 },
            [10] = { 1948, 151 },
            [11] = { 1810, 93  },
            [12] = { 2736, 437 },
            [13] = { 1732, 87  },
            [14] = { 1620, 83  },
            [15] = { 2209, 221 },
            [16] = { 1902, 113 },
            [17] = { 1593, 83  },
            [18] = { 1552, 88  },
            [19] = { 1461, 91  }
        },
        COORD_COOLDOWNS = {
            [0]  = { 1762, 145 },
            [1]  = { 1888, 167 },
            [2]  = { 1762, 127 },
            [3]  = { 1568, 113 },
            [4]  = { 1597, 113 },
            [5]  = { 1577, 113 },
            [6]  = { 1822, 114 },
            [7]  = { 2051, 165 },
            [8]  = { 1589, 121 },
            [9]  = { 1838, 208 },
            [10] = { 1948, 185 },
            [11] = { 1810, 128 },
            [12] = { 2736, 469 },
            [13] = { 1732, 123 },
            [14] = { 1620, 113 },
            [15] = { 2209, 255 },
            [16] = { 1902, 147 },
            [17] = { 1593, 113 },
            [18] = { 1552, 118 },
            [19] = { 1461, 121 }
        }
    },
    FUNC_POINTERS = {
        FM_RETURN_TRUE  = 0x75F9,
        FM_RETURN_FALSE = 0x7C828,
        SHOULD_TRIGGER = {
            -- *_SHOULD_TRIGGER functions determine if the event can progress to the Active state from the Available state.
            -- There are also the *_SHOULD_BE_AVAILABLE functions, which determine if the event can progress to the Available state from the Inactive state. The events that have this function don't have any special conditions to be triggered in their SHOULD_TRIGGER functions, they just return true.
            [0]  = 0x2B0F38,
            [1]  = 0x2B0E4C,
            [2]  = 0x2B0E1F,
            [3]  = 0x2B0DE1,
            [4]  = 0x2B01C8,
            [5]  = 0x2AFE67, -- PHANTOM_CAR_SHOULD_BE_AVAILABLE
            [6]  = 0x2AFD85,
            [7]  = 0x2AFD42,
            [8]  = 0x2AFA8B,
            [9]  = 0x2AFA33,
            [10] = 0x2AF9E8,
            [11] = 0x2AF99D,
            [12] = 0x2AF94F,
            [13] = 0x2AF901,
            [14] = 0x2AF5B0, -- XMAS_MUGGER_SHOULD_BE_AVAILABLE
            [15] = 0x2AF530,
            [16] = 0x2AF4D6,
            [17] = 0x2AF2ED,
            [18] = 0x2AEF81,
            [19] = 0x2AEF4B  -- XMAS_TRUCK_SHOULD_BE_AVAILABLE
        },
        REAL_COORDS = {
            [0] = 0x217235, -- The Slashers
            [1] = 0x217452, -- Phantom Car
            [2] = 0x21B4C0, -- Cerberus Surprise
            [3] = 0x217FCE, -- The Gooch
            [4] = 0x217B52, -- Possessed Animals
            [5] = 0xCDA7    -- Ghosts Exposed
        }
    },
    SCRIPTS = {
        [0]  = "fm_content_drug_vehicle",
        [1]  = "fm_content_movie_props",
        [2]  = "fm_content_golden_gun",
        [3]  = "fm_content_vehicle_list",
        [4]  = "fm_content_slasher",
        [5]  = "fm_content_phantom_car",
        [6]  = "fm_content_sightseeing",
        [7]  = "fm_content_smuggler_trail",
        [8]  = "fm_content_cerberus",
        [9]  = "fm_content_smuggler_plane",
        [10] = "fm_content_crime_scene",
        [11] = "fm_content_metal_detector",
        [12] = "fm_content_convoy",
        [13] = "fm_content_robbery",
        [14] = "fm_content_xmas_mugger",
        [15] = "fm_content_bank_shootout",
        [16] = "fm_content_armoured_truck",
        [17] = "fm_content_possessed_animals",
        [18] = "fm_content_ghosthunt",
        [19] = "fm_content_xmas_truck"
    },
    COOLDOWNS = {
        [0]  = "SUM22_RE_DRUG_VEHICLE_INACTIVE_TIME",
        [1]  = "SUM22_RE_MOVIE_PROPS_INACTIVE_TIME",
        [2]  = "SUM22_RE_GOLDEN_GUN_INACTIVE_TIME",
        [3]  = "SUM22_RE_VEHICLE_LIST_INACTIVE_TIME",
        [4]  = "STANDARDCONTROLLERVOLUME_COOLDOWN",
        [5]  = "STANDARDTARGETTINGTIME_COOLDOWN",
        [6]  = "SSP2_COOLDOWN",
        [7]  = "SUM22_RE_SMUGGLER_TRAIL_INACTIVE_TIME",
        [8]  = "NC_SOURCE_TRUCK_COOLDOWN",
        [9]  = "SUM22_RE_SMUGGLER_PLANE_INACTIVE_TIME",
        [10] = "SUM22_RE_CRIME_SCENE_INACTIVE_TIME",
        [11] = "SUM22_RE_METAL_DETECTOR_INACTIVE_TIME",
        [12] = "XM22_RE_GANG_CONVOY_INACTIVE_TIME",
        [13] = "XM22_RE_ROBBERY_INACTIVE_TIME",
        [14] = "STANDARD_KEYBIND_COOLDOWN",
        [15] = "XM22_RE_BANK_SHOOTOUT_INACTIVE_TIME",
        [16] = 295362, -- Global_262145.f_33217 - Armored Truck (doesn't have a tunable)
        [17] = "STANDARDCONTROLLERVOLUME_COOLDOWN",
        [18] = "SUM23_RE_GHOSTHUNT_INACTIVE_TIME",
        [19] = "XMAS_TRUCK_INACTIVE_TIME"
    },
    AVAILABILITIES = {
        [0]  = "SUM22_RE_DRUG_VEHICLE_AVAILABLE_TIME",
        [1]  = "SUM22_RE_MOVIE_PROPS_AVAILABLE_TIME",
        [2]  = "SUM22_RE_GOLDEN_GUN_AVAILABLE_TIME",
        [3]  = "SUM22_RE_VEHICLE_LIST_AVAILABLE_TIME",
        [4]  = "STANDARDCONTROLLERVOLUME_AVAILABILITY",
        [5]  = "STANDARDTARGETTINGTIME_AVAILABILITY",
        [6]  = "SSP2_AVAILABILITY",
        [7]  = "SUM22_RE_SMUGGLER_TRAIL_AVAILABLE_TIME",
        [8]  = "NC_SOURCE_TRUCK_AVAILABILITY",
        [9]  = "SUM22_RE_SMUGGLER_PLANE_AVAILABLE_TIME",
        [10] = "SUM22_RE_CRIME_SCENE_AVAILABLE_TIME",
        [11] = "SUM22_RE_METAL_DETECTOR_AVAILABLE_TIME",
        [12] = "XM22_RE_GANG_CONVOY_AVAILABLE_TIME",
        [13] = "XM22_RE_ROBBERY_AVAILABLE_TIME",
        [14] = "STANDARD_KEYBIND_AVAILABILITY",
        [15] = "XM22_RE_BANK_SHOOTOUT_AVAILABLE_TIME",
        [16] = 295363, -- Global_262145.f_33218 - Armored Truck (doesn't have a tunable)
        [17] = "STANDARDCONTROLLERVOLUME_AVAILABILITY",
        [18] = "SUM23_RE_GHOSTHUNT_AVAILABLE_TIME",
        [19] = "XMAS_TRUCK_AVAILABLE_TIME"
    },
    NAMES = {
        [0]  = "Drug Vehicle",
        [1]  = "Movie Props",
        [2]  = "Sleeping Guard",
        [3]  = "Exotic Exports",
        [4]  = "The Slashers",
        [5]  = "Phantom Car",
        [6]  = "Sightseeing",
        [7]  = "Smuggler Trail",
        [8]  = "Cerberus Surprise",
        [9]  = "Smuggler Plane",
        [10] = "Crime Scene",
        [11] = "Metal Detector",
        [12] = "Finders Keepers",
        [13] = "Shop Robbery",
        [14] = "The Gooch",
        [15] = "Weazel Plaza Shootout",
        [16] = "Armored Truck",
        [17] = "Possessed Animals",
        [18] = "Ghosts Exposed",
        [19] = "Happy Holidays Hauler"
    }
}

local selected_event                = 0
local selected_target               = 0
local selected_loc                  = 0
local set_cooldown                  = 1800000
local set_availability              = 900000
local enable_esp                    = true
local enable_line                   = true
local enable_sphere                 = true
local enable_notifications          = true
local force_freemode_host           = true
local apply_in_minutes              = false
local set_target_player             = false
local enable_tunables               = false
local bypass_requirements           = false
local disable_all_events            = false
local remove_activated_events_limit = false
local logging                       = false
local notified_available            = {}
local notified_active               = {}
local is_tunable_active             = {}

local event_coords           = vec3:new(0, 0, 0)
local event_state            = RE.STATES.INACTIVE
local event_trigger_range    = 0.0
local event_timer            = 0
local event_variation        = 0
local event_cooldown         = 0
local event_availability     = 0
local max_num_re             = 0
local max_activated_events   = 0
local num_active_events      = 0
local event_host_id          = 0
local target_player_id       = 0
local re_initialized         = false
local variations_registered  = false
local cooldown_time_left     = "00:00:00"
local availability_time_left = "00:00:00"
local event_host_name        = "**Invalid**"
local max_variations         = {}
local target_players         = {}

local function CLAMP(value, min, max)
    return math.min(math.max(value, min), max)
end

local function COMBO_CLEANUP()
    selected_loc = 0
    if selected_event == RE.IDS.ARMOURED_TRUCK then
    	set_cooldown     = globals.get_int(RE.COOLDOWNS[selected_event])
    	set_availability = globals.get_int(RE.AVAILABILITIES[selected_event])
    else
    	set_cooldown     = tunables.get_int(RE.COOLDOWNS[selected_event])
    	set_availability = tunables.get_int(RE.AVAILABILITIES[selected_event])
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

local function SHOULD_DISABLE_ESP()
    return script.is_active("appinternet") or
        script.is_active("appcamera") or
        HUD.IS_PAUSE_MENU_ACTIVE() or
        NETWORK.NETWORK_IS_IN_MP_CUTSCENE() or
        not CAM.IS_GAMEPLAY_CAM_RENDERING() or
        HUD.IS_HUD_COMPONENT_ACTIVE(16) or  -- HUD_RADIO_STATIONS
        HUD.IS_HUD_COMPONENT_ACTIVE(19) or  -- HUD_WEAPON_WHEEL
        globals.get_int(23692 + 4) == 1     -- Is selector UI rendering
end

local function GET_FMMC_TYPE_OF_EVENT(event)
    return locals.get_int("freemode", RE.CORE.FMRE_DATA + 241 + 1 + (event + 1))
end

local function REGISTER_MAX_VARIATIONS()
    if variations_registered then
        return
    end
    
    if script.is_active("freemode") and re_initialized then
        for event = 0, max_num_re do
            local fmmc_type     = GET_FMMC_TYPE_OF_EVENT(event)
            local max_variation = scr_function.call_script_function("freemode", "GMFV", "2D 02 04 00 00 38 00 55", "int", {
                { "int", fmmc_type },
                { "int", 0 }
            })
            
            max_variations[event] = max_variation - 1
        end
        
        variations_registered = true
    end
end

-- This script event enables the first bit of FMRE Client & Server Bitset, which makes the script ignore all the SHOULD_TRIGGER/SHOULD_BE_AVAILABLE conditions.
local function REQUEST_RANDOM_EVENT(event, variation)
    local fmmc_type = GET_FMMC_TYPE_OF_EVENT(event)
    local args      = { RE.CORE.REQUEST_RE_HASH, 0, -1, fmmc_type, 0, variation, 1 } -- The last argument makes the script set the client requested bit of all the other players in the session.
    
    network.trigger_script_event(-1, args)
end

local function HOOK_SHOULD_TRIGGER_FUNCTIONS(value)
    for event = 0, max_num_re do
        if event == RE.IDS.PHANTOM_CAR or event == RE.IDS.XMAS_MUGGER or event == RE.IDS.XMAS_TRUCK then
            locals.set_int("freemode", RE.CORE.FMRE_DATA + (1 + (event * 12)) + 5, value)
        else
            locals.set_int("freemode", RE.CORE.FMRE_DATA + (1 + (event * 12)) + 1 + 1, value)
        end
    end
end

local function RESTORE_SHOULD_TRIGGER_FUNCTIONS()
    for event = 0, max_num_re do
        if event == RE.IDS.PHANTOM_CAR or event == RE.IDS.XMAS_MUGGER or event == RE.IDS.XMAS_TRUCK then
            locals.set_int("freemode", RE.CORE.FMRE_DATA + (1 + (event * 12)) + 5, RE.FUNC_POINTERS.SHOULD_TRIGGER[event])
        else
            locals.set_int("freemode", RE.CORE.FMRE_DATA + (1 + (event * 12)) + 1 + 1, RE.FUNC_POINTERS.SHOULD_TRIGGER[event])
        end
    end
end

-- The original functions return a null vector, preventing the script event from updating the initial trigger point's value. To resolve this, event replace the local pointers with the addresses of functions that actually return the event's coordinates.
local function PATCH_EVENT_COORDS()
    -- The game crashes on session change if event set the values in a loop when script is not active for some reason.
    if script.is_active("fm_content_slasher") then
        locals.set_int("fm_content_slasher", 405 + 105, RE.FUNC_POINTERS.REAL_COORDS[0])
    end
    if script.is_active("fm_content_phantom_car") then
    	locals.set_int("fm_content_phantom_car", 388 + 105, RE.FUNC_POINTERS.REAL_COORDS[1])
    end
    if script.is_active("fm_content_cerberus") then
    	locals.set_int("fm_content_cerberus", 403 + 105, RE.FUNC_POINTERS.REAL_COORDS[2])
    end
    if script.is_active("fm_content_xmas_mugger") then
    	locals.set_int("fm_content_xmas_mugger", 417 + 105, RE.FUNC_POINTERS.REAL_COORDS[3])
    end
    if script.is_active("fm_content_possessed_animals") then
    	locals.set_int("fm_content_possessed_animals", 401 + 105, RE.FUNC_POINTERS.REAL_COORDS[4])
    end
    if script.is_active("fm_content_ghosthunt") then
        locals.set_int("fm_content_ghosthunt", 421 + 105, RE.FUNC_POINTERS.REAL_COORDS[5])
    end	
end

local function RESET_UPDATE_EVENT_COORDS_COOLDOWN()
    for event = 0, max_num_re do
        if script.is_active(RE.SCRIPTS[event]) then
            local base_address = RE.LOCALS.COORD_COOLDOWNS[event][1]
            local offset       = RE.LOCALS.COORD_COOLDOWNS[event][2]
            
            locals.set_int(RE.SCRIPTS[event], base_address + offset + 1, 1) -- There will be a race condition here since the script will set the value back to 0 just before sending the script event, but this shouldn't be a big problem.
        end
    end
end

local function SET_MAX_NUMBER_OF_ACTIVATED_EVENTS_COUNT(count)
    tunables.set_int("FMREMAXACTIVATEDEVENTS", count)
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
    globals.set_int(RE.CORE.GSBD_RE + 304, target_id) -- Phantom Car Target
    globals.set_int(RE.CORE.GSBD_RE + 304 + 1, target_id) -- The Gooch Target
end

local function SET_EVENT_END_REASON(event, reason)
    local base_address = RE.LOCALS.END_REASONS[event][1]
    local offset       = RE.LOCALS.END_REASONS[event][2]
    
    locals.set_int(RE.SCRIPTS[event], base_address + offset, reason)
end

local function SET_SPECIAL_EVENT_TUNABLES(toggle)
    tunables.set_int("STANDARDCONTROLLERVOLUME", toggle and 1 or -1)
    tunables.set_int("STANDARDTARGETTINGTIME", toggle and 1 or -1)
    tunables.set_int("SSP2POSIX", toggle and NETWORK.GET_CLOUD_TIME_AS_INT() or -1) -- Make the posix match with the seed (it will get stuck on day 1, though).
    tunables.set_int("NC_SOURCE_TRUCK_HEAD_COUNT", toggle and 3 or 1)
    tunables.set_int("STANDARD_KEYBIND_SELECTION", toggle and 1 or -1)
    tunables.set_bool("ENABLE_MAZEBANKSHOOTOUT_DLC22022", toggle)
    tunables.set_bool("ENABLE_HALLOWEEN_POSSESSED_ANIMAL", toggle)
    tunables.set_bool("ENABLE_HALLOWEEN_GHOSTHUNT", toggle)
    tunables.set_bool(-818123201, toggle) -- This will invalidate ENABLE_HALLOWEEN_GHOSTHUNT.
    tunables.set_bool(2093114948, toggle)
end

local function CHECK_EVENT_TUNABLES()
    is_tunable_active[RE.IDS.DRUG_VEHICLE]      = tunables.get_bool("SUM_RANDOM_EVENT_DRUG_VEHICLE_ENABLE")
    is_tunable_active[RE.IDS.MOVIE_PROPS]       = tunables.get_bool("COLLECTABLES_MOVIE_PROPS")
    is_tunable_active[RE.IDS.GOLDEN_GUN]        = true -- Sleeping Guard (no tunable)
    is_tunable_active[RE.IDS.VEHICLE_LIST]      = true -- Exotic Exports (no tunable)
    is_tunable_active[RE.IDS.SLASHER]           = tunables.get_int("STANDARDCONTROLLERVOLUME") ~= -1
    is_tunable_active[RE.IDS.PHANTOM_CAR]       = tunables.get_int("STANDARDTARGETTINGTIME") ~= -1
    is_tunable_active[RE.IDS.SIGHTSEEING]       = tunables.get_int("SSP2POSIX") > 0
    is_tunable_active[RE.IDS.SMUGGLER_TRAIL]    = tunables.get_bool("ENABLE_SU22_SMUGGLER_TRAIL")
    is_tunable_active[RE.IDS.CERBERUS]          = tunables.get_int("NC_SOURCE_TRUCK_HEAD_COUNT") == 3
    is_tunable_active[RE.IDS.SMUGGLER_PLANE]    = tunables.get_bool("ENABLE_SU22_SMUGGLER_PLANE")
    is_tunable_active[RE.IDS.CRIME_SCENE]       = tunables.get_bool("ENABLE_SUM22_CRIME_SCENES")
    is_tunable_active[RE.IDS.METAL_DETECTOR]    = tunables.get_bool("COLLECTABLES_BURIED_STASH")
    is_tunable_active[RE.IDS.CONVOY]            = tunables.get_bool("ENABLE_GANGCONVOY_DLC22022")
    is_tunable_active[RE.IDS.ROBBERY]           = tunables.get_bool("XM22_ROBBERY_ENABLE")
    is_tunable_active[RE.IDS.XMAS_MUGGER]       = tunables.get_int("STANDARD_KEYBIND_SELECTION") ~= -1
    is_tunable_active[RE.IDS.BANK_SHOOTOUT]     = tunables.get_bool("ENABLE_MAZEBANKSHOOTOUT_DLC22022")
    is_tunable_active[RE.IDS.ARMOURED_TRUCK]    = tunables.get_bool("ENABLE_RANDOM_EVENT_ARMORED_TRUCK")
    is_tunable_active[RE.IDS.POSSESSED_ANIMALS] = tunables.get_bool("ENABLE_HALLOWEEN_POSSESSED_ANIMAL")
    is_tunable_active[RE.IDS.GHOSTHUNT]         = tunables.get_bool("ENABLE_HALLOWEEN_GHOSTHUNT") or tunables.get_bool(-818123201)
    is_tunable_active[RE.IDS.XMAS_TRUCK]        = tunables.get_bool(2093114948)
end

local function ARE_EVENTS_INITIALIZED()
    return globals.get_int(RE.CORE.GPBD_FM_2 + (1 + (self.get_id() * 146)) + 82) == 1
end

local function GET_MAX_NUMBER_OF_EVENTS()
    return locals.get_int("freemode", RE.CORE.FMRE_DATA + 241) - 1
end

local function GET_MAX_NUMBER_OF_ACTIVATED_EVENTS_COUNT()
    return tunables.get_int("FMREMAXACTIVATEDEVENTS")
end

local function GET_PLAYER_STATE(event, player_id)
    return globals.get_int(RE.CORE.GPBD_FM_2 + (1 + (player_id * 146)) + 82 + 1 + (1 + (event * 3)))
end

local function GET_EVENT_STATE(event)
    return globals.get_int(RE.CORE.GSBD_RE + 1 + (1 + (event * 15)))
end

local function GET_EVENT_VARIATION(event)
    return globals.get_int(RE.CORE.GSBD_RE + 1 + (1 + (event * 15)) + 6)
end

local function GET_EVENT_COORDS(event)
    return globals.get_vec3(RE.CORE.GSBD_RE + 1 + (1 + (event * 15)) + 10)
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
    
    for event = 0, max_num_re do
        local local_state = GET_PLAYER_STATE(event, self.get_id())
        
        if local_state ~= RE.STATES.INACTIVE then
            num_events = num_events + 1
        end
    end
    
    return num_events
end

local function GET_TRIGGERER_INDEX(event)
    for event = 0, 31 do
        local player_state = GET_PLAYER_STATE(event, event)
        
        if player_state == RE.STATES.ACTIVE then
            return event
        end
    end
    
    return -1
end

local function GET_TARGET_PLAYERS()
    local player_table = {}
    
    for event = 0, 31 do
        local player_name = PLAYER.GET_PLAYER_NAME(event)
        
        if player_name ~= "**Invalid**" then
            table.insert(player_table, {id = event, name = player_name})
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

local function LOOPED_UPDATE_RE_DATA()
    re_initialized         = ARE_EVENTS_INITIALIZED()
    max_num_re             = GET_MAX_NUMBER_OF_EVENTS()
    max_activated_events   = GET_MAX_NUMBER_OF_ACTIVATED_EVENTS_COUNT()
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
    event_host_id          = NETWORK.NETWORK_GET_HOST_OF_SCRIPT(RE.SCRIPTS[selected_event], selected_event, 0)
    event_host_name 	   = PLAYER.GET_PLAYER_NAME(event_host_id)
end

local function LOOPED_RENDER_ESP()
    if SHOULD_DISABLE_ESP() then
        return
    end
    
    for event = 0, max_num_re do
    	local state         = GET_EVENT_STATE(event)
    	local coords        = GET_EVENT_COORDS(event)
    	local timer         = GET_EVENT_TIMER(event)
    	local availability  = GET_EVENT_AVAILABILITY(event)
    	local time_left     = GET_EVENT_TIME_LEFT(availability, timer)
    	local trigger_range = GET_EVENT_TRIGGER_RANGE(event)	
    	local colors        = state == RE.STATES.ACTIVE and { 0, 153, 51 } or { 93, 182, 229 }
    
    	if state ~= RE.STATES.INACTIVE and coords ~= vec3:new(0, 0, 0) then
            local distance           = MISC.GET_DISTANCE_BETWEEN_COORDS(self.get_pos().x, self.get_pos().y, self.get_pos().z, coords.x, coords.y, coords.z, false)
            local km_or_m            = (distance < 1000) and "m" or "km"
            local formatted_distance = (distance < 1000) and distance or (distance / 1000.0)
            local text               = string.format("%s (%.2f%s) %s", (state == RE.STATES.ACTIVE and "~HUD_COLOUR_GREEN~" or "") .. RE.NAMES[event] .. "~s~", formatted_distance, km_or_m, (state == RE.STATES.AVAILABLE and "~n~" .. time_left or ""))
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
    for event = 0, max_num_re do
        local state = GET_EVENT_STATE(event)
        
        if state == RE.STATES.ACTIVE then
            if not notified_active[event] then
                local triggerer_index = GET_TRIGGERER_INDEX(event)
            
                if triggerer_index ~= -1 then
                    local triggerer_name = PLAYER.GET_PLAYER_NAME(triggerer_index)
                
                    gui.show_message("Random Events", "" .. RE.NAMES[event] .. " is triggered by " .. triggerer_name .. ".")
                    if logging then log.info("" .. RE.NAMES[event] .. " is triggered by " .. triggerer_name .. ".") end
                    notified_active[event] = true
                end
            end
        end
        
        if state == RE.STATES.AVAILABLE then
            if not notified_available[event] then
            	if is_tunable_active[event] then
                    gui.show_message("Random Events", "" .. RE.NAMES[event] .. " is available.")
                    if logging then log.info("" .. RE.NAMES[event] .. " is available.") end
            	else
                    gui.show_warning("Random Events", "" .. RE.NAMES[event] .. " is available.\nWarning: Tunable is not active.")
                    if logging then log.warning("" .. RE.NAMES[event] .. " is available (tunable is not active).") end
            	end
            	notified_available[event] = true
            end
        end
        
        if state == RE.STATES.INACTIVE then
            notified_available[event] = false
            notified_active[event]    = false
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
    LOOPED_UPDATE_RE_DATA()
    REGISTER_MAX_VARIATIONS()

    if re_initialized then
    	if enable_esp then
            LOOPED_RENDER_ESP()
        end
    
    	if enable_tunables then
            SET_SPECIAL_EVENT_TUNABLES(true)
    	end
    
    	if bypass_requirements then
            HOOK_SHOULD_TRIGGER_FUNCTIONS(RE.FUNC_POINTERS.FM_RETURN_TRUE)
    	end
    
    	if disable_all_events then
            HOOK_SHOULD_TRIGGER_FUNCTIONS(RE.FUNC_POINTERS.FM_RETURN_FALSE)
    	end
		
        if remove_activated_events_limit then
            SET_MAX_NUMBER_OF_ACTIVATED_EVENTS_COUNT(max_num_re + 1)
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
        RESET_UPDATE_EVENT_COORDS_COOLDOWN()
    end
end)

re_tab:add_imgui(function()
    if not re_initialized then
        ImGui.Text("Random Events are not initialized.")
    	return
    end
	
    if ImGui.BeginCombo("Select Event", RE.NAMES[selected_event]) then
        for event = 0, #RE.NAMES do
            local is_selected = (event == selected_event)
            local state       = GET_EVENT_STATE(event)
        
            if state == RE.STATES.INACTIVE then
                ImGui.PushStyleColor(ImGuiCol.Text, 1, 0, 0, 1)
            elseif state == RE.STATES.AVAILABLE then
            	ImGui.PushStyleColor(ImGuiCol.Text, 1, 1, 1, 1)
            elseif state == RE.STATES.ACTIVE then
            	ImGui.PushStyleColor(ImGuiCol.Text, 0, 1, 0, 1)
            end
            
            if ImGui.Selectable(RE.NAMES[event], is_selected) then
            	selected_event = event
            	COMBO_CLEANUP()
            end
            
            if is_selected then
            	ImGui.SetItemDefaultFocus()
            end
            
            ImGui.PopStyleColor()
        end
        ImGui.EndCombo()
    end
	
    selected_loc, on_modified = ImGui.InputInt("Select Location (0-" .. max_variations[selected_event] .. ")", selected_loc)
    
    if on_modified then
    	selected_loc = CLAMP(selected_loc, 0, max_variations[selected_event])
    end
    
    if num_active_events >= max_activated_events then
    	ImGui.TextColored(1, 0, 0, 1, "Active Events: " .. num_active_events .. "/" .. max_activated_events)
    else
    	ImGui.Text("Active Events: " .. num_active_events .. "/" .. max_activated_events)
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
            	SET_EVENT_END_REASON(selected_event, 3) -- 3 means the fm_content_* script mission is completed and can be gracefully terminated.
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
            	if event_coords ~= vec3:new(0, 0, 0) then
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
    	"N/A"))
    HELP_MARKER("Shows the current state of the event.\n- Inactive\n- Available\n- Active\n- Cleanup")
    
    if event_state == RE.STATES.ACTIVE then
        ImGui.Text("Host: " .. event_host_name)
        
        ImGui.SameLine()
        
        if event_host_id ~= self.get_id() then
            if ImGui.SmallButton("Take Control") then
                script.run_in_fiber(function()
                    if script.is_active(RE.SCRIPTS[selected_event]) then
                    	network.force_script_host(RE.SCRIPTS[selected_event])
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
                for event, player in ipairs(target_players) do
                    local is_selected = (event - 1 == selected_target)
                    
                    if ImGui.Selectable(player.name .. " (ID: " .. player.id ..")", is_selected) then
                    	selected_target  = event - 1
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
		
        remove_activated_events_limit, on_tick = ImGui.Checkbox("Remove Max Activated Events Limit", remove_activated_events_limit)
        HELP_MARKER("Removes the limit on the maximum number of activated events you can have. Use with caution.")
		
        if on_tick then
            if not remove_activated_events_limit then
                SET_MAX_NUMBER_OF_ACTIVATED_EVENTS_COUNT(3)
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