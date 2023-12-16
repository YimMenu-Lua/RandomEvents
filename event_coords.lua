function drug_vehicle_coordinates(location)
	if location == 0 then return vec3:new(-95.215, 6395.659, 30.452)
	elseif location == 1 then return vec3:new(1665.939, 4970.212, 41.259)
	elseif location == 2 then return vec3:new(2647.317, 4255.757, 43.776)
	elseif location == 3 then return vec3:new(1434.347, 3662.849, 33.120)
	elseif location == 4 then return vec3:new(857.869, 2849.551, 56.575)
	elseif location == 5 then return vec3:new(-1901.913, 2055.253, 139.693)
	elseif location == 6 then return vec3:new(2310.338, 2542.258, 45.668)
	elseif location == 7 then return vec3:new(-2230.174, 4225.861, 45.799)
	elseif location == 8 then return vec3:new(-2952.948, 408.613, 14.152)
	elseif location == 9 then return vec3:new(1909.135, 573.296, 174.822)
	elseif location == 10 then return vec3:new(-292.182, 2525.068, 73.653)
	elseif location == 11 then return vec3:new(768.252, 4176.665, 39.710)
	elseif location == 12 then return vec3:new(3333.365, 5159.849, 17.303)
	elseif location == 13 then return vec3:new(-1513.606, 1483.649, 115.370)
	elseif location == 14 then return vec3:new(2479.418, 3427.102, 48.893)
	elseif location == 15 then return vec3:new(1451.420, -2233.088, 60.226)
	elseif location == 16 then return vec3:new(165.564, -2652.463, 4.996)
	elseif location == 17 then return vec3:new(236.349, 22.535, 82.574)
	elseif location == 18 then return vec3:new(-1371.957, -329.900, 38.131)
	elseif location == 19 then return vec3:new(-935.675, 308.411, 70.220)
	elseif location == 20 then return vec3:new(-961.396, -1102.007, 1.150)
	elseif location == 21 then return vec3:new(1038.375, -774.271, 57.014)
	elseif location == 22 then return vec3:new(339.462, -2126.446, 14.337)
	elseif location == 23 then return vec3:new(-27.376, -1494.304, 29.362)
	elseif location == 24 then return vec3:new(-355.798, -60.705, 53.428)
	elseif location == 25 then return vec3:new(472.475, -1237.580, 28.749)
	elseif location == 26 then return vec3:new(1395.489, -1533.557, 56.572)
	elseif location == 27 then return vec3:new(35.097, -882.845, 29.255)
	elseif location == 28 then return vec3:new(-1001.537, -2528.857, 12.831)
	elseif location == 29 then return vec3:new(2674.505, 1568.294, 23.501)
	else return vec3:new(0.0, 0.0, 0.0)
	end
end

function movie_prop_coordinates(location)
	if location == 0 then return vec3:new(-297.603, 6298.312, 35.492) -- RE_MovieProps_DrinksGlobe_1 - 0
	elseif location == 1 then return vec3:new(-77.110, 6537.942, 30.491) -- RE_MovieProps_DrinksGlobe_2 - 1
	elseif location == 2 then return vec3:new(1254.091, 6483.862, 19.618) -- RE_MovieProps_DrinksGlobe_3 - 2
	elseif location == 3 then return vec3:new(-667.250, 80.216, 50.139) -- RE_MovieProps_Sarcophagus_1 - 3
	elseif location == 4 then return vec3:new(-2316.255, 280.381, 168.467) -- RE_MovieProps_Sarcophagus_2 - 4
	elseif location == 5 then return vec3:new(-1861.402, 150.232, 79.223) -- RE_MovieProps_Sarcophagus_3 - 5
	elseif location == 6 then return vec3:new(744.011, -971.328, 23.585) -- RE_MovieProps_TigerRug_1 - 6
	elseif location == 7 then return vec3:new(463.492, -737.440, 26.362) -- RE_MovieProps_TigerRug_2 - 7
	elseif location == 8 then return vec3:new(514.737, -859.692, 38.819) -- RE_MovieProps_TigerRug_3 - 8
	else return vec3:new(0.0, 0.0, 0.0)
	end
end

function sleeping_guard_coordinates(location)
	if location == 0 then return vec3:new(265.312, -996.705, 28.292)
	elseif location == 1 then return vec3:new(489.628, -1542.045, 28.285)
	elseif location == 2 then return vec3:new(226.375, 319.140, 104.575)
	elseif location == 3 then return vec3:new(-1402.103, -595.513, 29.387)
	elseif location == 4 then return vec3:new(-299.708, 6275.330, 30.492)
	elseif location == 5 then return vec3:new(1998.195, 3051.007, 46.214)
	elseif location == 6 then return vec3:new(-1656.949, -1001.917, 12.017)
	elseif location == 7 then return vec3:new(-2197.160, 4293.779, 47.517)
	elseif location == 8 then return vec3:new(-2967.847, 397.355, 14.073)
	elseif location == 9 then return vec3:new(2458.480, 4065.339, 37.065)
	else return vec3:new(0.0, 0.0, 0.0)
	end
end

function slashers_coordinates(location)
	if location == 0 then return vec3:new(129.95541, 6505.709, 30.476068) -- Sackslasher
	elseif location == 1 then return vec3:new(-324.33734, -1968.5961, 65.99007) -- Driver
	elseif location == 2 then return vec3:new(1012.1857, 2395.798, 49.937706) -- Driver
	elseif location == 3 then return vec3:new(-2348.0051, 1913.8635, 182.84479) -- Psycho
	elseif location == 4 then return vec3:new(-327.6382, 2563.356, 80.74749) -- Psycho
	elseif location == 5 then return vec3:new(-396.99896, 802.0306, 221.84807) -- Psycho
	elseif location == 6 then return vec3:new(-1403.8593, 620.4597, 130.36086) -- Psycho
	elseif location == 7 then return vec3:new(-231.64139, -1224.5112, 36.158558) -- Clown
	else return vec3:new(0.0, 0.0, 0.0)
	end
end

function smuggler_trail_coordinates(location)
	if location == 0 then return vec3:new(-405.021, 1197.675, 324.952)
	elseif location == 1 then return vec3:new(-405.021, 1197.675, 324.952)
	elseif location == 2 then return vec3:new(-405.021, 1197.675, 324.952)
	elseif location == 3 then return vec3:new(1549.944, 6641.784, 1.559)
	elseif location == 4 then return vec3:new(1549.944, 6641.784, 1.559)
	elseif location == 5 then return vec3:new(1549.944, 6641.784, 1.559)
	elseif location == 6 then return vec3:new(3335.480, 5142.842, 17.646)
	elseif location == 7 then return vec3:new(3335.480, 5142.842, 17.646)
	elseif location == 8 then return vec3:new(3335.480, 5142.842, 17.646)
	elseif location == 9 then return vec3:new(-325.600, 2757.728, 63.581)
	elseif location == 10 then return vec3:new(-325.600, 2757.728, 63.581)
	elseif location == 11 then return vec3:new(-325.600, 2757.728, 63.581)
	elseif location == 12 then return vec3:new(-1632.176, 4736.634, 52.363)
	elseif location == 13 then return vec3:new(-1632.176, 4736.634, 52.363)
	elseif location == 14 then return vec3:new(-1632.176, 4736.634, 52.363)
	else return vec3:new(0.0, 0.0, 0.0)
	end
end

function smuggler_plane_coordinates(location)
	if location == 0 then return vec3:new(2631.946, 4829.299, 31.608)
	elseif location == 1 then return vec3:new(807.557, 1162.739, 319.713)
	elseif location == 2 then return vec3:new(931.308, -335.397, 65.418)
	elseif location == 3 then return vec3:new(2145.098, 1073.616, 134.261)
	elseif location == 4 then return vec3:new(-1284.038, 4357.453, 6.256)
	else return vec3:new(0.0, 0.0, 0.0)
	end
end

function cerberus_coordinates(location)
	if location == 0 then return vec3:new(278.031, -1241.684, 28.197)
	elseif location == 1 then return vec3:new(1191.367, -1414.697, 34.169)
	elseif location == 2 then return vec3:new(1141.684, -351.712, 65.898)
	elseif location == 3 then return vec3:new(-604.346, -2220.875, 4.993)
	elseif location == 4 then return vec3:new(-2109.699, -293.844, 12.047)
	elseif location == 5 then return vec3:new(106.245, -1063.283, 28.192)
	elseif location == 6 then return vec3:new(250.125, 2598.978, 43.970)
	elseif location == 7 then return vec3:new(1993.082, 3079.071, 46.026)
	elseif location == 8 then return vec3:new(2688.999, 3268.510, 54.241)
	elseif location == 9 then return vec3:new(-1227.963, -896.393, 11.202)
	elseif location == 10 then return vec3:new(1682.208, 4933.743, 41.077)
	elseif location == 11 then return vec3:new(-57.355, 6467.806, 30.349)
	else return vec3:new(0.0, 0.0, 0.0)
	end
end

function crime_scene_coordinates(location)
	if location == 0 then return vec3:new(-200.079, 6380.539, 30.837)
	elseif location == 1 then return vec3:new(1781.449, 4607.885, 36.183)
	elseif location == 2 then return vec3:new(908.591, 3649.237, 35.152)
	elseif location == 3 then return vec3:new(2531.249, 2582.620, 36.945)
	elseif location == 4 then return vec3:new(-2947.286, 439.728, 14.250)
	elseif location == 5 then return vec3:new(-425.969, 293.246, 82.229)
	elseif location == 6 then return vec3:new(816.199, -487.910, 29.457)
	elseif location == 7 then return vec3:new(-1519.122, -884.706, 9.108)
	elseif location == 8 then return vec3:new(-307.744, -1188.095, 23.091)
	elseif location == 9 then return vec3:new(655.858, -3010.920, 5.045)
	else return vec3:new(0.0, 0.0, 0.0)
	end
end

function metal_detector_coordinates(location)
	if location == 0 then return vec3:new(-3122.794, 199.902, 1.420)
	elseif location == 1 then return vec3:new(-1803.975, -973.325, 1.372)
	elseif location == 2 then return vec3:new(-833.321, -1634.551, 0.198)
	elseif location == 3 then return vec3:new(-1813.895, -2723.459, 3.790)
	elseif location == 4 then return vec3:new(-27.523, -2730.982, 0.768)
	elseif location == 5 then return vec3:new(69.661, -2196.433, 0.636)
	elseif location == 6 then return vec3:new(618.078, -2025.481, 8.483)
	elseif location == 7 then return vec3:new(1553.476, -2752.332, 0.725)
	elseif location == 8 then return vec3:new(2257.904, -2229.384, 1.327)
	elseif location == 9 then return vec3:new(2825.329, -682.342, 0.105)
	else return vec3:new(0.0, 0.0, 0.0)
	end
end

function gang_convoy_coordinates(location)
	if location == 0 then return vec3:new(-756.790, -2459.380, 13.391)
	elseif location == 1 then return vec3:new(-26.075, 6499.405, 30.279)
	elseif location == 2 then return vec3:new(988.938, -1786.698, 30.590)
	elseif location == 3 then return vec3:new(1316.392, 1105.316, 104.848)
	elseif location == 4 then return vec3:new(-472.308, -813.468, 29.523)
	elseif location == 5 then return vec3:new(-1364.018, -667.904, 25.293)
	elseif location == 6 then return vec3:new(-3111.042, 1059.566, 19.497)
	else return vec3:new(0.0, 0.0, 0.0)
	end
end

function store_robbery_coordinates(location)
	if location == 0 then return vec3:new(1392.898, 3603.552, 33.981)
	elseif location == 1 then return vec3:new(-2969.875, 390.158, 14.043)
	elseif location == 2 then return vec3:new(546.858, 2670.707, 41.157)
	elseif location == 3 then return vec3:new(2557.101, 383.268, 107.623)
	elseif location == 4 then return vec3:new(2679.072, 3281.878, 54.241)
	elseif location == 5 then return vec3:new(1730.022, 6415.156, 34.037)
	elseif location == 6 then return vec3:new(26.947, -1347.078, 28.497)
	elseif location == 7 then return vec3:new(374.737, 326.317, 102.566)
	elseif location == 8 then return vec3:new(-1223.680, -906.364, 11.326)
	elseif location == 9 then return vec3:new(1136.622, -981.720, 45.416)
	elseif location == 10 then return vec3:new(-1488.076, -380.626, 39.163)
	elseif location == 11 then return vec3:new(-49.386, -1756.646, 28.421)
	elseif location == 12 then return vec3:new(-819.435, -186.097, 36.569)
	elseif location == 13 then return vec3:new(-1822.093, 791.515, 137.149)
	elseif location == 14 then return vec3:new(-3167.273, 1058.755, 19.863)
	elseif location == 15 then return vec3:new(1197.330, 2701.204, 37.162)
	elseif location == 16 then return vec3:new(1692.311, 4821.223, 41.063)
	elseif location == 17 then return vec3:new(-820.489, -1074.163, 10.328)
	elseif location == 18 then return vec3:new(-161.795, -303.618, 38.733)
	elseif location == 19 then return vec3:new(-1099.165, 2710.133, 18.108)
	elseif location == 20 then return vec3:new(1932.797, 3727.459, 31.844)
	elseif location == 21 then return vec3:new(1209.449, -470.677, 65.208)
	elseif location == 22 then return vec3:new(-290.663, 6198.768, 30.487)
	elseif location == 23 then return vec3:new(-1154.001, -1424.924, 3.954)
	elseif location == 24 then return vec3:new(1322.942, -1651.510, 51.275)
	else return vec3:new(0.0, 0.0, 0.0)
	end
end

function bank_shootout_coordinates(location)
	if location == 0 then return vec3:new(-890.265, -436.314, 167.119)
	else return vec3:new(0.0, 0.0, 0.0)
	end
end

function armored_truck_coordinates(location)
	if location == 0 then return vec3:new(1176.230, 2694.723, 36.943)
	elseif location == 1 then return vec3:new(-122.722, 6460.453, 30.951)
	elseif location == 2 then return vec3:new(-3140.181, 1104.606, 20.237)
	elseif location == 3 then return vec3:new(1693.617, 4941.509, 41.821)
	elseif location == 4 then return vec3:new(881.889, 22.235, 77.807)
	elseif location == 5 then return vec3:new(-805.553, -2530.855, 13.412)
	elseif location == 6 then return vec3:new(41.378, -704.766, 43.116)
	elseif location == 7 then return vec3:new(1198.436, -1423.313, 34.151)
	elseif location == 8 then return vec3:new(-345.816, -26.168, 46.523)
	elseif location == 9 then return vec3:new(-1372.619, -435.557, 34.943)
	else return vec3:new(0.0, 0.0, 0.0)
	end
end

function possessed_animal_coordinates(location)
	if location == 0 then return vec3:new(465.6534, 5542.598, 784.0989)
	elseif location == 1 then return vec3:new(-669.4619, 4746.9707, 241.0176)
	elseif location == 2 then return vec3:new(1894.2861, 4825.718, 44.8799)
	elseif location == 3 then return vec3:new(1911.4639, 409.2322, 161.4543)
	elseif location == 4 then return vec3:new(3371.3752, 2647.5735, 1.2636)
	elseif location == 5 then return vec3:new(3416.1357, 4406.2515, 210.7046)
	elseif location == 6 then return vec3:new(2848.2322, 5905.251, 356.7778)
	elseif location == 7 then return vec3:new(-1264.6774, 1492.2589, 194.0739)
	elseif location == 8 then return vec3:new(813.5114, 1317.173, 361.6941)
	elseif location == 9 then return vec3:new(2066.0833, -1505.0044, 236.8391)
	elseif location == 10 then return vec3:new(1900.0275, 3455.923, 45.9536)
	elseif location == 11 then return vec3:new(2275.9355, 1989.132, 130.7074)
	elseif location == 12 then return vec3:new(-1934.5254, 860.4406, 197.7359)
	elseif location == 13 then return vec3:new(-556.0917, 5982.9746, 34.4424)
	elseif location == 14 then return vec3:new(-1441.8186, 4238.6284, 47.3929)
	elseif location == 15 then return vec3:new(-455.462, -400.2377, 32.6848)
	elseif location == 16 then return vec3:new(574.6756, 2656.2336, 40.9714)
	elseif location == 17 then return vec3:new(-209.7753, 6277.435, 30.4893)
	else return vec3:new(0.0, 0.0, 0.0)
	end
end

function xmas_truck_coordinates(location)
	if location == 0 then return vec3:new(258.225, -970.239, 28.281)
	else return vec3:new(0.0, 0.0, 0.0)
	end
end