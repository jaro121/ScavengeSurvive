/*==============================================================================


	Southclaws' Scavenge and Survive

		Open Source File

		Original author: RazorGuigo

		Source: http://forum.sa-mp.com/showthread.php?p=3791767

		Modifications made by Southclaw, 2016-11-01


==============================================================================*/


enum e_OFFSET_STRUCT
{
	Float:offset_pos_x,
	Float:offset_pos_y,
	Float:offset_pos_z,
	Float:offset_rot_x,
	Float:offset_rot_y,
	Float:offset_rot_z,
	Float:offset_scale
}

static Float:Coordinates[300][e_OFFSET_STRUCT] =
{
	{0.098771, 0.030772, -0.000335, 85.342658, 84.122947, 4.236968, 1.000000}, // 000
	{0.100766, 0.028630, -0.003521, 87.936676, 82.110870, 4.236968, 1.000000}, // 001
	{0.083712, 0.033132, -0.003521, 87.936676, 82.110870, 4.236968, 1.000000}, // 002
	{0.099500, 0.047703, 0.000558, 280.687683, 90.938697, 169.126358, 1.000000}, // 003
	{0.126660, 0.017465, -0.004450, 281.516479, 103.193008, 168.312896, 1.167009}, // 004
	{0.109650, 0.017465, -0.004712, 281.516479, 106.686439, 168.312896, 1.167009}, // 005
	{0.101269, 0.028933, 0.000001, 281.516479, 91.839576, 168.312896, 1.000000}, // 006
	{0.090066, 0.043458, -0.006523, 87.936676, 82.110870, 4.236968, 1.000000}, // 007
	{0.087873, 0.038192, -0.003603, 281.516479, 91.839576, 168.312896, 1.020467}, // 008
	{0.070977, 0.028663, 0.000147, 81.164970, 92.128402, 4.236968, 1.000000}, // 009
	{0.072317, 0.032179, -0.002934, 86.843269, 84.196006, 4.236968, 1.000000}, // 010
	{0.072317, 0.035465, -0.002201, 86.843269, 84.196006, 4.236968, 1.000000}, // 011
	{0.072317, 0.028100, -0.002201, 86.843269, 84.196006, 4.236968, 1.000000}, // 012
	{0.076569, 0.028100, -0.002201, 86.843269, 84.196006, 4.236968, 1.000000}, // 013
	{0.091310, 0.049169, -0.002201, 86.843269, 84.196006, 4.236968, 1.000000}, // 014
	{0.073734, 0.006292, -0.002755, 86.843269, 84.196006, 4.236968, 1.000000}, // 015
	{0.092845, 0.040331, 0.000183, 86.843269, 82.864280, 4.236968, 1.000000}, // 016
	{0.088241, 0.030184, -0.000157, 86.843269, 82.864280, 4.236968, 1.000000}, // 017
	{0.061677, 0.029596, -0.007398, 86.843269, 82.864280, 4.236968, 1.000000}, // 018
	{0.079911, 0.029596, -0.002934, 86.843269, 82.864280, 4.236968, 1.000000}, // 019
	{0.095079, 0.029596, -0.001718, 85.261871, 86.296562, 4.236968, 1.000000}, // 020
	{0.093728, 0.042083, -0.005781, 85.261871, 81.636192, 4.236968, 1.000000}, // 021
	{0.079585, 0.042083, -0.005781, 85.261871, 81.636192, 4.236968, 1.000000}, // 022
	{0.090786, 0.041737, -0.005263, 85.261871, 81.636192, 4.236968, 1.000000}, // 023
	{0.085247, 0.026941, -0.000317, 85.261871, 81.636192, 4.236968, 1.000000}, // 024
	{0.081646, 0.031448, -0.001113, 89.393653, 81.665985, 4.236968, 1.000000}, // 025
	{0.083700, 0.033814, -0.001960, 86.436462, 81.665985, 4.236968, 1.000000}, // 026
	{0.092498, 0.037321, -0.001960, 86.436462, 85.568023, 4.236968, 1.000000}, // 027
	{0.097068, 0.041360, -0.007881, 86.771400, 85.568023, 4.236968, 1.000000}, // 028
	{0.083456, 0.050595, 0.001011, 86.771400, 77.201461, 4.236968, 1.000000}, // 029
	{0.076983, 0.047168, -0.006161, 86.771400, 74.329719, 4.236968, 1.000000}, // 030
	{0.083798, 0.042184, -0.001869, 86.771400, 83.181861, 4.236968, 1.000000}, // 031
	{0.053021, -0.000587, -0.001869, 86.771400, 66.859710, 4.236968, 1.000000}, // 032
	{0.034386, 0.013324, -0.001869, 86.771400, 80.314460, 4.236968, 1.000000}, // 033
	{0.104669, 0.037365, -0.001403, 86.771400, 87.178382, 4.236968, 1.000000}, // 034
	{0.102659, 0.037465, -0.000829, 86.771400, 93.020492, 4.236968, 1.000000}, // 035
	{0.107638, 0.037465, -0.000829, 86.771400, 93.020492, 4.236968, 1.000000}, // 036
	{0.107638, 0.035879, -0.000829, 86.771400, 93.020492, 4.236968, 1.000000}, // 037
	{0.107638, 0.041106, -0.000829, 86.771400, 93.020492, 4.236968, 1.000000}, // 038
	{0.080326, 0.035634, -0.000829, 86.771400, 93.020492, 4.236968, 1.000000}, // 039
	{0.080326, 0.027371, -0.000829, 86.771400, 93.020492, 4.236968, 1.000000}, // 040
	{0.084617, 0.039613, -0.001620, 86.771400, 93.020492, 4.236968, 1.000000}, // 041
	{0.087873, 0.037386, -0.003603, 281.516479, 91.839576, 168.312896, 1.093392}, // 042
	{0.040075, 0.025445, -0.000974, 86.771400, 92.964149, 4.236968, 1.000000}, // 043
	{0.077369, 0.028469, -0.000974, 86.771400, 78.435791, 4.236968, 1.000000}, // 044
	{0.064145, 0.028684, -0.000974, 86.771400, 84.762802, 4.236968, 1.000000}, // 045
	{0.091993, 0.056559, -0.000974, 86.771400, 84.762802, 4.236968, 1.000000}, // 046
	{0.084582, 0.051277, -0.005034, 86.771400, 84.762802, 4.236968, 1.000000}, // 047
	{0.092182, 0.042095, -0.003533, 86.771400, 84.762802, 4.236968, 1.000000}, // 048
	{0.086866, 0.032203, -0.001021, 86.771400, 84.762802, 4.236968, 1.000000}, // 049
	{0.099350, 0.009422, -0.005899, 86.771400, 84.762802, 4.236968, 1.000000}, // 050
	{0.099350, 0.030598, -0.005899, 86.771400, 84.762802, 4.236968, 1.000000}, // 051
	{0.099350, 0.030598, -0.003575, 86.771400, 84.762802, 4.236968, 1.000000}, // 052
	{0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, // 053
	{0.079123, 0.030598, -0.003575, 86.771400, 84.762802, 4.236968, 1.000000}, // 054
	{0.063159, 0.029641, -0.003575, 86.771400, 84.762802, 4.236968, 1.000000}, // 055
	{0.070293, 0.029641, -0.000570, 86.771400, 84.762802, 4.236968, 1.000000}, // 056
	{0.111305, 0.045368, -0.000570, 86.771400, 84.458084, 4.236968, 1.000000}, // 057
	{0.084901, 0.020965, -0.000570, 86.771400, 79.542411, 4.236968, 1.000000}, // 058
	{0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, // 059
	{0.090164, 0.044163, -0.004754, 86.771400, 79.542411, 4.236968, 1.000000}, // 060
	{0.087151, 0.041447, -0.000885, 90.928329, 89.598678, 0.000000, 1.000000}, // 061
	{0.094350, 0.041447, 0.005717, 90.928329, 89.598678, 0.000000, 1.000000}, // 062
	{0.075534, 0.041447, -0.001751, 90.928329, 89.598678, 0.000000, 1.000000}, // 063
	{0.075534, 0.041447, -0.001751, 90.928329, 89.598678, 0.000000, 1.000000}, // 064
	{0.087873, 0.032505, -0.003603, 281.516479, 91.839576, 168.312896, 0.965358}, // 065
	{0.104148, 0.034787, 0.001341, 90.928329, 89.598678, 0.000000, 1.000000}, // 066
	{0.104148, 0.034787, 0.001341, 90.928329, 89.598678, 0.000000, 1.000000}, // 067
	{0.087317, 0.039646, -0.004032, 90.928329, 89.598678, 0.000000, 1.000000}, // 068
	{0.074873, 0.039646, -0.003072, 90.928329, 89.598678, 0.000000, 1.000000}, // 069
	{0.090391, 0.042364, 0.005494, 90.928329, 89.598678, 0.000000, 1.000000}, // 070
	{0.090391, 0.022298, -0.001170, 90.928329, 89.598678, 0.000000, 1.000000}, // 071
	{0.090391, 0.039580, -0.001170, 90.928329, 89.598678, 0.000000, 1.000000}, // 072
	{0.090391, 0.038224, -0.001170, 90.928329, 89.598678, 0.000000, 1.000000}, // 073
	{0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, // 074
	{0.083113, 0.038224, -0.001170, 90.928329, 89.598678, 0.000000, 1.000000}, // 075
	{0.072957, 0.028956, -0.001170, 90.928329, 89.598678, 0.000000, 1.000000}, // 076
	{0.069398, 0.039981, -0.001170, 90.928329, 89.598678, 0.000000, 1.000000}, // 077
	{0.105738, 0.010001, 0.004508, 90.928329, 79.030494, 0.000000, 1.000000}, // 078
	{0.078264, 0.019668, 0.004508, 90.928329, 79.030494, 0.000000, 1.000000}, // 079
	{0.087377, 0.022096, -0.001993, 90.928329, 79.030494, 0.000000, 1.000000}, // 080
	{0.087377, 0.022096, -0.001635, 90.928329, 79.030494, 0.000000, 1.000000}, // 081
	{0.100623, 0.043063, -0.001635, 90.928329, 87.672645, 0.000000, 1.000000}, // 082
	{0.092528, 0.027493, -0.001635, 90.928329, 87.672645, 0.000000, 1.000000}, // 083
	{0.102086, 0.027493, -0.001635, 90.928329, 87.672645, 0.000000, 1.000000}, // 084
	{0.081954, 0.041672, -0.001635, 90.928329, 87.672645, 0.000000, 1.000000}, // 085
	{0.025608, -0.003408, 281.516479, 106.686721, 167.551193, 0.965358}, // 086
	{0.077010, 0.046925, -0.003438, 90.928329, 91.590301, 0.000000, 1.000000}, // 087
	{0.069952, 0.042635, -0.003438, 90.928329, 86.722587, 0.000000, 1.000000}, // 088
	{0.093827, 0.019258, -0.003438, 90.928329, 86.722587, 0.000000, 1.000000}, // 089
	{0.066464, 0.035685, -0.000843, 90.928329, 86.722587, 0.000000, 1.000000}, // 090
	{0.066464, 0.035685, -0.000843, 90.928329, 86.722587, 0.000000, 1.000000}, // 091
	{0.066464, 0.038135, -0.000843, 90.928329, 86.722587, 0.000000, 1.000000}, // 092
	{0.066464, 0.038135, -0.001690, 90.928329, 86.722587, 0.000000, 1.000000}, // 093
	{0.048124, 0.010598, -0.001690, 90.928329, 86.722587, 0.000000, 1.000000}, // 094
	{0.084997, 0.006773, -0.001690, 90.928329, 86.722587, 0.000000, 1.000000}, // 095
	{0.100076, 0.026633, -0.001690, 90.928329, 80.020179, 0.000000, 1.000000}, // 096
	{0.061686, 0.027537, -0.001690, 90.928329, 80.020179, 0.000000, 1.000000}, // 097
	{0.098318, 0.053993, -0.001690, 90.928329, 89.237678, 0.000000, 1.000000}, // 098
	{0.098318, 0.033702, -0.001690, 90.928329, 89.237678, 0.000000, 1.000000}, // 099
	{0.086149, 0.042526, -0.001690, 90.928329, 77.587478, 0.000000, 1.000000}, // 100
	{0.081864, 0.030555, -0.001690, 90.928329, 78.145759, 0.000000, 1.000000}, // 101
	{0.081864, 0.047914, -0.005079, 90.928329, 78.145759, 0.000000, 1.000000}, // 102
	{0.089607, 0.036717, -0.005079, 90.928329, 78.145759, 0.000000, 1.000000}, // 103
	{0.079655, 0.042021, -0.005079, 90.928329, 78.145759, 0.000000, 1.000000}, // 104
	{0.091779, 0.037620, -0.005079, 90.928329, 78.145759, 0.000000, 1.000000}, // 105
	{0.084179, 0.035251, -0.005079, 90.928329, 78.145759, 0.000000, 1.000000}, // 106
	{0.089387, 0.040297, -0.006006, 90.928329, 78.145759, 0.000000, 1.000000}, // 107
	{0.081930, 0.030756, 0.001523, 90.928329, 78.145759, 0.000000, 1.000000}, // 108
	{0.092857, 0.043070, -0.006084, 90.928329, 85.326652, 0.000000, 1.000000}, // 109
	{0.092857, 0.043070, -0.006084, 90.928329, 85.326652, 0.000000, 1.000000}, // 110
	{0.106601, 0.028021, -0.003537, 90.928329, 90.217376, 0.000000, 1.000000}, // 111
	{0.096335, 0.015873, -0.003537, 90.928329, 90.217376, 0.000000, 1.000000}, // 112
	{0.105827, 0.046620, -0.001395, 90.928329, 90.217376, 0.000000, 1.000000}, // 113
	{0.097520, 0.044296, -0.007286, 90.928329, 90.217376, 0.000000, 1.000000}, // 114
	{0.097408, 0.043470, -0.007286, 90.928329, 90.217376, 0.000000, 1.000000}, // 115
	{0.092588, 0.049832, -0.007286, 90.928329, 90.217376, 0.000000, 1.000000}, // 116
	{0.081444, 0.037602, -0.003125, 90.928329, 90.217376, 0.000000, 1.000000}, // 117
	{0.078678, 0.037602, -0.001816, 90.928329, 90.217376, 0.000000, 1.000000}, // 118
	{0.093011, 0.037032, -0.001987, 281.516479, 94.968688, 167.551193, 1.051324}, // 119
	{0.089214, 0.029291, -0.000784, 90.928329, 84.624763, 0.000000, 1.000000}, // 120
	{0.086825, 0.033424, -0.000784, 90.928329, 77.233818, 0.000000, 1.000000}, // 121
	{0.082869, 0.030783, -0.000950, 90.928329, 77.233818, 0.000000, 1.000000}, // 122
	{0.096117, 0.048957, -0.006245, 90.928329, 87.579650, 0.000000, 1.000000}, // 123
	{0.103663, 0.040022, 0.000449, 90.928329, 87.579650, 0.000000, 1.000000}, // 124
	{0.099326, 0.031202, -0.001180, 90.928329, 87.579650, 0.000000, 1.000000}, // 125
	{0.099326, 0.031132, -0.001180, 90.928329, 87.579650, 0.000000, 1.000000}, // 126
	{0.099326, 0.039279, -0.001180, 90.928329, 87.579650, 0.000000, 1.000000}, // 127
	{0.099326, 0.047422, -0.001180, 90.928329, 87.579650, 0.000000, 1.000000}, // 128
	{0.088817, 0.021210, 0.000730, 90.928329, 87.579650, 0.000000, 1.000000}, // 129
	{0.025784, 0.028323, 0.000730, 90.928329, 59.394767, 0.000000, 1.000000}, // 130
	{0.068455, 0.031841, -0.004470, 90.928329, 79.979003, 0.000000, 1.000000}, // 131
	{0.012930, 0.008392, -0.004470, 90.928329, 72.129173, 0.000000, 1.000000}, // 132
	{0.102457, 0.032260, -0.003338, 90.928329, 84.534217, 0.000000, 1.000000}, // 133
	{0.085976, 0.014956, -0.003338, 90.928329, 80.308830, 0.000000, 1.000000}, // 134
	{0.071574, 0.028186, -0.001588, 90.928329, 80.308830, 0.000000, 1.000000}, // 135
	{0.085219, 0.016666, -0.000738, 90.928329, 80.308830, 0.000000, 1.000000}, // 136
	{0.065114, 0.009318, -0.000738, 90.928329, 80.308830, 0.000000, 1.000000}, // 137
	{0.066890, 0.040024, -0.000738, 90.928329, 87.341934, 0.000000, 1.000000}, // 138
	{0.072037, 0.036141, -0.000702, 90.928329, 87.341934, 0.000000, 1.000000}, // 139
	{0.069108, 0.042194, -0.000436, 90.928329, 87.341934, 0.000000, 1.000000}, // 140
	{0.058717, 0.043547, -0.000436, 90.928329, 87.209770, 0.000000, 1.000000}, // 141
	{0.104196, 0.039601, -0.005481, 90.928329, 87.209770, 0.000000, 1.000000}, // 142
	{0.090929, 0.045881, -0.012780, 90.928329, 87.209770, 0.000000, 1.000000}, // 143
	{0.098291, 0.042464, -0.006952, 90.928329, 83.081665, 0.000000, 1.000000}, // 144
	{0.080087, 0.030122, 0.000606, 90.928329, 83.081665, 0.000000, 1.000000}, // 145
	{0.093500, 0.030690, -0.001545, 90.928329, 83.081665, 0.000000, 1.000000}, // 146
	{0.079566, 0.020138, 0.004838, 90.928329, 73.715591, 0.000000, 1.000000}, // 147
	{0.073564, 0.028430, -0.000527, 90.928329, 88.295433, 0.000000, 1.000000}, // 148
	{0.099901, 0.011976, 0.001273, 281.516479, 97.607620, 167.551193, 1.190787}, // 149
	{0.073564, 0.028430, -0.000527, 90.928329, 88.295433, 0.000000, 1.000000}, // 150
	{0.083426, 0.032359, -0.005717, 90.928329, 88.295433, 0.000000, 1.000000}, // 151
	{0.072349, 0.019623, -0.000747, 90.928329, 82.624351, 0.000000, 1.000000}, // 152
	{0.075065, 0.015351, 0.006545, 90.928329, 71.041442, 0.000000, 1.000000}, // 153
	{0.062227, 0.029731, -0.004938, 90.928329, 84.602760, 0.000000, 1.000000}, // 154
	{0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000}, // 155
	{0.079936, 0.049000, -0.000304, 90.928329, 82.926010, 0.000000, 1.000000}, // 156
	{0.067550, 0.035686, -0.000017, 90.928329, 82.926010, 0.000000, 1.000000}, // 157
	{0.090676, 0.039383, -0.001726, 90.928329, 88.667900, 0.000000, 1.000000}, // 158
	{0.090676, 0.039383, -0.003532, 90.928329, 88.667900, 0.000000, 1.000000}, // 159
	{0.098662, 0.017441, -0.001589, 90.928329, 88.667900, 0.000000, 1.000000}, // 160
	{0.105388, 0.038409, 0.003155, 90.928329, 88.667900, 0.000000, 1.000000}, // 161
	{0.097415, 0.036904, -0.000525, 90.928329, 88.667900, 0.000000, 1.000000}, // 162
	{0.088934, 0.023302, -0.004153, 90.928329, 80.393875, 0.000000, 1.000000}, // 163
	{0.088934, 0.023302, -0.004153, 90.928329, 80.393875, 0.000000, 1.000000}, // 164
	{0.087018, 0.051364, 0.000484, 90.928329, 94.584838, 0.000000, 1.000000}, // 165
	{0.087018, 0.051364, 0.000484, 90.928329, 94.584838, 0.000000, 1.000000}, // 166
	{0.095996, 0.038787, 0.000484, 90.928329, 84.315711, 0.000000, 1.000000}, // 167
	{0.089094, 0.034001, -0.006451, 90.928329, 84.315711, 0.000000, 1.000000}, // 168
	{0.075700, 0.028082, -0.006451, 90.928329, 84.315711, 0.000000, 1.000000}, // 169
	{0.093751, 0.041968, -0.005545, 90.928329, 84.315711, 0.000000, 1.000000}, // 170
	{0.090124, 0.031055, -0.000505, 90.928329, 84.315711, 0.000000, 1.000000}, // 171
	{0.066033, 0.032915, -0.002713, 90.928329, 84.315711, 0.000000, 1.000000}, // 172
	{0.088287, 0.045350, -0.005384, 90.928329, 84.315711, 0.000000, 1.000000}, // 173
	{0.087750, 0.042129, -0.005384, 90.928329, 84.315711, 0.000000, 1.000000}, // 174
	{0.092384, 0.039294, -0.005384, 90.928329, 84.315711, 0.000000, 1.000000}, // 175
	{0.097661, 0.039065, -0.006344, 90.928329, 80.736480, 0.000000, 1.000000}, // 176
	{0.097114, 0.039641, -0.006692, 90.928329, 80.736480, 0.000000, 1.000000}, // 177
	{0.069354, 0.039641, -0.000474, 90.928329, 80.736480, 0.000000, 1.000000}, // 178
	{0.091414, 0.039641, -0.005617, 90.928329, 80.736480, 0.000000, 1.000000}, // 179
	{0.094914, 0.039641, -0.005617, 90.928329, 80.736480, 0.000000, 1.000000}, // 180
	{0.117232, 0.033217, -0.001099, 90.928329, 82.396362, 0.000000, 1.000000}, // 181
	{0.082569, 0.032748, -0.003248, 90.928329, 87.394371, 0.000000, 1.000000}, // 182
	{0.095527, 0.027237, -0.001960, 90.928329, 86.443649, 0.000000, 1.000000}, // 183
	{0.095527, 0.040994, -0.006878, 90.928329, 86.443649, 0.000000, 1.000000}, // 184
	{0.085663, 0.030601, -0.002345, 90.928329, 81.496513, 0.000000, 1.000000}, // 185
	{0.085663, 0.030601, -0.001015, 90.928329, 81.496513, 0.000000, 1.000000}, // 186
	{0.076527, 0.027211, 0.008500, 90.928329, 74.401092, 0.000000, 1.000000}, // 187
	{0.096669, 0.032578, 0.001662, 90.928329, 83.502502, 0.000000, 1.000000}, // 188
	{0.098753, 0.032129, -0.001659, 90.928329, 90.153724, 0.000000, 1.000000}, // 189
	{0.092821, 0.035572, -0.001659, 90.928329, 90.153724, 0.000000, 1.000000}, // 190
	{0.092821, 0.035572, -0.001132, 90.928329, 90.153724, 0.000000, 1.000000}, // 191
	{0.092821, 0.035572, -0.001132, 90.928329, 90.153724, 0.000000, 1.000000}, // 192
	{0.092821, 0.035572, -0.001132, 90.928329, 90.153724, 0.000000, 1.000000}, // 193
	{0.092821, 0.035572, -0.001132, 90.928329, 90.153724, 0.000000, 1.000000}, // 194
	{0.092821, 0.035572, -0.001132, 90.928329, 90.153724, 0.000000, 1.000000}, // 195
	{0.092821, 0.035572, -0.001132, 90.928329, 90.153724, 0.000000, 1.000000}, // 196
	{0.100630, 0.020568, -0.001132, 90.928329, 90.153724, 0.000000, 1.000000}, // 197
	{0.077905, 0.028523, 0.000000, 89.675476, 89.270309, 0.000000, 1.000000}, // 198
	{0.099095, 0.022463, 0.000000, 89.675476, 89.270309, 0.000000, 1.000000}, // 199
	{0.103182, 0.031106, 0.000000, 89.675476, 89.270309, 0.000000, 1.000000}, // 200
	{0.078426, 0.038546, 0.000000, 89.675476, 89.270309, 0.000000, 1.000000}, // 201
	{0.101092, 0.035797, -0.002997, 89.675476, 82.081153, 0.000000, 1.000000}, // 202
	{0.092009, 0.042780, -0.005841, 89.675476, 84.463294, 0.000000, 1.000000}, // 203
	{0.092009, 0.042780, -0.005841, 89.675476, 84.463294, 0.000000, 1.000000}, // 204
	{0.092969, 0.027782, -0.002959, 89.675476, 84.463294, 0.000000, 1.000000}, // 205
	{0.105109, 0.036128, -0.000471, 89.675476, 84.463294, 0.000000, 1.000000}, // 206
	{0.066892, 0.024410, -0.002792, 89.675476, 84.463294, 0.000000, 1.000000}, // 207
	{0.088610, 0.043561, 0.001273, 281.516479, 89.674781, 167.551193, 1.000000}, // 208
	{0.084046, 0.013608, -0.002792, 89.675476, 81.667831, 0.000000, 1.000000}, // 209
	{0.084046, 0.013608, -0.001034, 89.675476, 81.667831, 0.000000, 1.000000}, // 210
	{0.067610, 0.033777, -0.001034, 89.675476, 85.214485, 0.000000, 1.000000}, // 211
	{0.094159, 0.020717, 0.000715, 89.675476, 85.214485, 0.000000, 1.000000}, // 212
	{0.098744, 0.036786, -0.001770, 89.675476, 85.214485, 0.000000, 1.000000}, // 213
	{0.068755, 0.036786, -0.001770, 89.675476, 85.214485, 0.000000, 1.000000}, // 214
	{0.068755, 0.026863, -0.001770, 89.675476, 85.214485, 0.000000, 1.000000}, // 215
	{0.068755, 0.026863, -0.001770, 89.675476, 85.214485, 0.000000, 1.000000}, // 216
	{0.095765, 0.030034, -0.001770, 89.675476, 85.214485, 0.000000, 1.000000}, // 217
	{0.085486, 0.039427, -0.003311, 89.675476, 85.214485, 0.000000, 1.000000}, // 218
	{0.068874, 0.027850, -0.001021, 89.675476, 85.214485, 0.000000, 1.000000}, // 219
	{0.052931, 0.050390, -0.002062, 89.675476, 88.113647, 0.000000, 1.000000}, // 220
	{0.094479, 0.034432, 0.000875, 89.675476, 83.572830, 0.000000, 1.000000}, // 221
	{0.094479, 0.034432, -0.000596, 89.675476, 83.572830, 0.000000, 1.000000}, // 222
	{0.094479, 0.062073, -0.003098, 89.675476, 83.572830, 0.000000, 1.000000}, // 223
	{0.064458, 0.029760, -0.001460, 89.675476, 83.572830, 0.000000, 1.000000}, // 224
	{0.064458, 0.029760, -0.001460, 89.675476, 83.572830, 0.000000, 1.000000}, // 225
	{0.072095, 0.029760, -0.001460, 89.675476, 83.572830, 0.000000, 1.000000}, // 226
	{0.110619, 0.043037, -0.001466, 89.675476, 86.927627, 0.000000, 1.000000}, // 227
	{0.099446, 0.050772, -0.001466, 89.675476, 85.103805, 0.000000, 1.000000}, // 228
	{0.078635, 0.023680, -0.000275, 89.675476, 73.445220, 0.000000, 1.000000}, // 229
	{0.043357, 0.028726, -0.000275, 89.675476, 73.445220, 0.000000, 1.000000}, // 230
	{0.092488, 0.049972, -0.000275, 89.675476, 88.981941, 0.000000, 1.000000}, // 231
	{0.092488, 0.016739, -0.000275, 89.675476, 88.981941, 0.000000, 1.000000}, // 232
	{0.071677, 0.037055, -0.002878, 89.675476, 88.981941, 0.000000, 1.000000}, // 233
	{0.082745, 0.004209, -0.002878, 89.675476, 88.981941, 0.000000, 1.000000}, // 234
	{0.057909, 0.021331, -0.002878, 89.675476, 88.981941, 0.000000, 1.000000}, // 235
	{0.079016, 0.021331, -0.000419, 89.675476, 77.678733, 0.000000, 1.000000}, // 236
	{0.074572, 0.021331, -0.000419, 89.675476, 84.527442, 0.000000, 1.000000}, // 237
	{0.074572, 0.038346, -0.001500, 89.675476, 84.527442, 0.000000, 1.000000}, // 238
	{0.111645, 0.011549, 0.006237, 89.675476, 84.527442, 0.000000, 1.000000}, // 239
	{0.090766, 0.044221, -0.000423, 89.675476, 89.461883, 0.000000, 1.000000}, // 240
	{0.069491, 0.049021, -0.000423, 89.675476, 89.461883, 0.000000, 1.000000}, // 241
	{0.059706, 0.031911, -0.000423, 89.675476, 89.461883, 0.000000, 1.000000}, // 242
	{0.065242, 0.031911, -0.000423, 89.675476, 89.461883, 0.000000, 1.000000}, // 243
	{0.065242, 0.051077, -0.001103, 89.675476, 89.461883, 0.000000, 1.000000}, // 244
	{0.082393, 0.038233, 0.000410, 89.675476, 89.461883, 0.000000, 1.000000}, // 245
	{0.079338, 0.044859, -0.002535, 89.675476, 89.461883, 0.000000, 1.000000}, // 246
	{0.101566, 0.037019, 0.000750, 89.675476, 83.514060, 0.000000, 1.000000}, // 247
	{0.091887, 0.047776, -0.000040, 89.675476, 83.514060, 0.000000, 1.000000}, // 248
	{0.089745, 0.044044, 0.004071, 89.675476, 83.514060, 0.000000, 1.000000}, // 249
	{0.094214, 0.044044, -0.007274, 89.675476, 83.514060, 0.000000, 1.000000}, // 250
	{0.072282, 0.044044, -0.001468, 89.675476, 90.444763, 0.000000, 1.000000}, // 251
	{0.095764, 0.034224, -0.000264, 89.675476, 82.959915, 0.000000, 1.000000}, // 252
	{0.087454, 0.026208, -0.000264, 89.675476, 82.959915, 0.000000, 1.000000}, // 253
	{0.099198, 0.037362, -0.000264, 89.675476, 82.959915, 0.000000, 1.000000}, // 254
	{0.070845, 0.019943, 0.003505, 89.675476, 73.529716, 0.000000, 1.000000}, // 255
	{0.065373, 0.033656, -0.001141, 89.675476, 83.002151, 0.000000, 1.000000}, // 256
	{0.070077, 0.033656, -0.001141, 89.675476, 83.002151, 0.000000, 1.000000}, // 257
	{0.089536, 0.041904, 0.000715, 89.675476, 83.002151, 0.000000, 1.000000}, // 258
	{0.084822, 0.041904, 0.000715, 89.675476, 83.002151, 0.000000, 1.000000}, // 259
	{0.093009, 0.031491, -0.001568, 89.675476, 83.002151, 0.000000, 1.000000}, // 260
	{0.093009, 0.015023, -0.001477, 89.675476, 83.002151, 0.000000, 1.000000}, // 261
	{0.076580, 0.039782, -0.001477, 89.675476, 88.620780, 0.000000, 1.000000}, // 262
	{0.076580, 0.028967, -0.001477, 89.675476, 88.620780, 0.000000, 1.000000}, // 263
	{0.075424, 0.043059, -0.001477, 89.675476, 88.620780, 0.000000, 1.000000}, // 264
	{0.089655, 0.021726, -0.001477, 89.675476, 88.620780, 0.000000, 1.000000}, // 265
	{0.096792, 0.014114, -0.003062, 89.675476, 85.166038, 0.000000, 1.000000}, // 266
	{0.094886, 0.024989, -0.003184, 89.675476, 85.166038, 0.000000, 1.000000}, // 267
	{0.094886, 0.024989, -0.003184, 89.675476, 85.166038, 0.000000, 1.000000}, // 268
	{0.102252, 0.024989, -0.003184, 89.675476, 85.166038, 0.000000, 1.000000}, // 269
	{0.102252, 0.024989, 0.000529, 89.675476, 85.166038, 0.000000, 1.000000}, // 270
	{0.096134, 0.025462, 0.000529, 89.675476, 79.225112, 0.000000, 1.000000}, // 271
	{0.099226, 0.032663, 0.000529, 89.675476, 79.225112, 0.000000, 1.000000}, // 272
	{0.080779, 0.028227, -0.001415, 281.516479, 91.776855, 167.551193, 1.061396}, // 273
	{0.089833, 0.022466, -0.001590, 89.675476, 88.636062, 0.000000, 1.000000}, // 274
	{0.089833, 0.022466, -0.001590, 89.675476, 88.636062, 0.000000, 1.000000}, // 275
	{0.089833, 0.022466, -0.001590, 89.675476, 88.636062, 0.000000, 1.000000}, // 276
	{0.082718, 0.062596, -0.000201, 89.675476, 88.636062, 0.000000, 1.000000}, // 277
	{0.082718, 0.062596, -0.000201, 89.675476, 88.636062, 0.000000, 1.000000}, // 278
	{0.087652, 0.059379, -0.000201, 89.675476, 88.636062, 0.000000, 1.000000}, // 279
	{0.087652, 0.023702, -0.003091, 89.675476, 88.636062, 0.000000, 1.000000}, // 280
	{0.087652, 0.023702, -0.003091, 89.675476, 88.636062, 0.000000, 1.000000}, // 281
	{0.090877, 0.026643, -0.003091, 89.675476, 88.636062, 0.000000, 1.000000}, // 282
	{0.090877, 0.026643, -0.003091, 89.675476, 88.636062, 0.000000, 1.000000}, // 283
	{0.090877, 0.053674, 0.009879, 89.675476, 88.636062, 0.000000, 1.000000}, // 284
	{0.104320, 0.041487, 0.008021, 89.675476, 88.636062, 0.000000, 1.000000}, // 285
	{0.087062, 0.021779, -0.003307, 89.675476, 88.636062, 0.000000, 1.000000}, // 286
	{0.073173, 0.048856, 0.005337, 89.675476, 92.561180, 0.000000, 1.000000}, // 287
	{0.090294, 0.027592, -0.003497, 89.675476, 92.561180, 0.000000, 1.000000}, // 288
	{0.081684, 0.015000, 0.001780, 281.516479, 108.106758, 169.790878, 1.042815}, // 289
	{0.086562, 0.042698, -0.000612, 89.675476, 92.561180, 0.000000, 1.000000}, // 290
	{0.096768, 0.039233, -0.000612, 89.675476, 83.550270, 0.000000, 1.000000}, // 291
	{0.079939, 0.020731, -0.005162, 89.675476, 83.550270, 0.000000, 1.000000}, // 292
	{0.097107, 0.027826, -0.005162, 89.675476, 88.505996, 0.000000, 1.000000}, // 293
	{0.097107, 0.037636, 0.000618, 89.675476, 88.505996, 0.000000, 1.000000}, // 294
	{0.079985, 0.035006, -0.000826, 89.675476, 87.533462, 0.000000, 1.000000}, // 295
	{0.088445, 0.024209, -0.002076, 89.675476, 73.285072, 0.000000, 1.000000}, // 296
	{0.094039, 0.035411, 0.000490, 89.675476, 84.277572, 0.000000, 1.000000}, // 297
	{0.099553, 0.024683, -0.002919, 89.675476, 84.277572, 0.000000, 1.000000}, // 298
	{0.099553, 0.044356, -0.000285, 89.675476, 84.277572, 0.000000, 1.000000} // 299
};

stock GetHeadAttachOffsets(skinid,
	Float:pos_x, Float:pos_y, Float:pos_z,
	Float:rot_x, Float:rot_y, Float:rot_z,
	Float:scl_x, Float:scl_y, Float:scl_z)
{
	new
		Float:x = (0.098771 - Coordinates[skinid][offset_pos_x]),
		Float:y = (0.030772 - Coordinates[skinid][offset_pos_y]),
		Float:z = (0.000335 + Coordinates[skinid][offset_pos_z]),
		Float:rx = (85.342658 - Coordinates[skinid][offset_rot_x]),
		Float:ry = (84.122947 - Coordinates[skinid][offset_rot_y]),
		Float:rz = (4.236968 - Coordinates[skinid][offset_rot_z]),
		Float:s = (1.000000 - Coordinates[skinid][offset_scale]);

	pos_x += x;
	pos_y += y;
	pos_z += z;
	rot_x += rx;
	rot_y += ry;
	rot_z += rz;
	scl_x += s;
	scl_y += s;
	scl_z += s;
}
