fm_scripts = { "fm_content_drug_vehicle", "fm_content_movie_props", "fm_content_golden_gun", "fm_content_slasher", "fm_content_phantom_car", "fm_content_smuggler_trail", "fm_content_cerberus", "fm_content_smuggler_plane", "fm_content_crime_scene", "fm_content_metal_detector", "fm_content_convoy", "fm_content_robbery", "fm_content_xmas_mugger", "fm_content_bank_shootout", "fm_content_armoured_truck", "fm_content_possessed_animals" }

-- Random Events are controlled by the freemode script host (cooldown, availablity etc)
-- 3 Random Events can be triggered at once

event_ids = {
-- See func_8397 in freemode
24,  -- Drug Vehicle 
26,  -- Movie Props 
259, -- Sleeping Guard 
--273, Exotic Exports 
270, -- Slashers 
269, -- Phantom Car
--275, -- Sightseeing 
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
320 -- Possessed Animals 
--313 Ghosts Exposed
}

instance_ids = {
-- fm_script instance IDs. Also the random events array.
0,
1,
2,
-- INSTANCE_VEHICLE_LIST = 3, 
4,
5,
-- INSTANCE_SIGHTSEEING = 6,
7,
8,
9,
10,
11,
12,
13,
14,
15,
16,
17
-- INSTANCE_GHOSTHUNT = 18
}

force_offsets = {
-- I found these incidentally while testing. IDK where they come from
441, -- Drug Vehicle
444, -- Movie Props
447, -- Sleeping Guard
--450, -- Exotic Exports
453, -- Slashers
456, -- Phantom Car
--459, -- Sightseeing
462, -- Smuggler Trail (kinda buggy)
465, -- Cerberus
468, -- Smuggler Plane
471, -- Crime Scene
474, -- Metal Detector
477, -- Gang Convoy
480, -- Store Robbery
482, -- Gooch
486, -- Weazel Bank Shootout
489, -- Armored Truck
492 -- Possessed Animals
--495 Ghosts Exposed
}

cd_tuna_hashes = {
--The time must be passed to get out of "waiting" state, aka cooldown.
-1267850277, -- Drug Vehicle Cooldown (1800000ms, 30 minutes)
1195265128, -- Movie Props Cooldown (900000ms, 15 minutes)
-1933940219, -- Sleeping Guard Cooldown (1200000ms, 20 minutes)
---1200886739, -- Exotic Exports Cooldown (90000ms, 1,5 minutes)
495685551, -- Slasher Cooldown (960000ms, 16 minutes)
-1123249717, -- Phantom Car Cooldown (960000ms, 16 minutes)
--286614918, -- Sightseeing Cooldown (300000ms, 5 minutes)
795465415, -- Smuggler Trail Cooldown (1200000ms, 20 minutes)
975859501, -- Cerberus Cooldown (960000ms, 16 minutes)
-2147182425, -- Smuggler Plane Cooldown (2100000ms, 35 minutes)
-916078577, --  Crime Scene Cooldown (1800000ms, 30 minutes)
-1704717530, -- Metal Detector Cooldown (1320000ms, 22 minutes)
-917017440, -- Gang Convoy Cooldown (1200000ms, 20 minutes)
1373860254, -- Store Robbery Cooldown (1200000ms, 20 minutes)
1849316276, -- Gooch Cooldown (2880000ms, 48 minutes)
1839585304, --  Bank Shootout Cooldown (1200000ms, 20 minutes)
nil, --  Armoured Truck Cooldown (1200000ms, 20 minutes) - No tunable
495685551 -- Possessed Animal Cooldown (960000ms, 16 minutes)
-- -98345554 Ghosts Exposed (1000ms, 1 second)
}

ab_tuna_hashes = {
--These determine the time that the event will be active once it is in the "ready" state.
-197276867, -- Drug Vehicle Availability (900000ms, 15 minutes)
2069239953, -- Movie Prop Availability (600000ms, 10 minutes)
1308280504, -- Sleeping Guard Availability (600000ms, 10 minutes)
--22553139, -- Exotic Exports Availability (900000ms, 15 minutes)
1760669530, -- Slasher Availability (1200000ms, 20 minutes)
-1123249717, -- Phantom Car Availability (1200000ms, 20 minutes)
---1133509941, -- Sightseeing Availability (1200000ms, 20 minutes)
450803869, -- Smuggler Trail Availability (600000ms, 10 minutes)
-143509570, -- Cerberus Availability (1200000ms, 20 minutes)
-961850057, -- Smuggler Plane Availability (600000ms, 10 minutes)
1180396244, -- Crime Scene Availability (900000ms, 15 minutes)
-1818085093, -- Metal Detector Availability (600000ms, 10 minutes)
1525434060, -- Gang Convoy Availability (600000ms, 10 minutes)
-1900341221, -- Store Robbery Availability (600000ms, 10 minutes)
521699684, -- Gooch Availability (1200000ms, 20 minutes)
-1555137323, -- Bank Shootout Availability (600000ms, 10 minutes)
nil, --  Armored Truck (doesn't have a tunable)
1760669530 -- Possessed Animal Availability (1200000ms, 20 minutes)
-- 710010135 Ghosts Exposed Availability (119000ms, 1,98 minutes)
}

ab2_locals = {
-- These determine the time that the event will be active once it is in the "triggered" state. -1 means event doesn't use a availablity 2 time by default. But you can of course modify it.
230 + 130, -- Drug Vehicle, 15 minutes - Tunable: 98399706 / fm_content_drug_vehicle
228 + 151, -- Movie Props, 10 minutes - Tunable: -1775483157 / fm_content_movie_props
232 + 126, -- Sleeping Guard, 10 minutes - Tunable: -640326072 / fm_content_golden_gun
243 + 102, -- Slashers, -1 - fm_content_slasher
--226 + 302, -- Exotic Exports, -1 - fm_content_vehicle_list
226 + 102, -- Phantom Car, -1 - fm_content_phantom_car
--226 + 102, -- Sightseeing, -1 - fm_content_sightseeing
266 + 252, -- Smuggler Trail, 15 minutes - fm_content_smuggler_trail
226 + 117, -- Cerberus, -1 - fm_content_cerberus
231 + 252, -- Smuggler Plane, 10 minutes - fm_content_smuggler_plane
237 + 212, -- Crime Scene, 10 minutes - fm_content_crime_scene
234 + 126, -- Metal Detector, 10 minutes - fm_content_metal_detector
238 + 513, -- Gang Convoy, 15 minutes - fm_content_convoy
234 + 116, -- Store Robbery, 10 minutes - fm_content_robbery
255 + 102, -- Gooch, -1 - fm_content_xmas_mugger
234 + 239, -- Weazel Bank Shootout, 15 minutes - fm_content_bank_shootout
226 + 142, -- Armoured Truck, 15 minutes - fm_content_armoured_truck
239 + 102, -- Possessed Animals, -1 - fm_content_possessed_animals
--228 + 114 Ghosts Exposed, -1 - fm_content_ghosthunt
}