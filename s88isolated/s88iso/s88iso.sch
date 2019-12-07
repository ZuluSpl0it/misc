EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Connector:RJ45 J?
U 1 1 5DEC0ABC
P 2100 2300
F 0 "J?" H 1771 2304 50  0000 R CNN
F 1 "RJ45" H 1771 2395 50  0000 R CNN
F 2 "" V 2100 2325 50  0001 C CNN
F 3 "~" V 2100 2325 50  0001 C CNN
	1    2100 2300
	1    0    0    1   
$EndComp
$Comp
L Connector:RJ45 J?
U 1 1 5DEC1D69
P 6650 2225
F 0 "J?" H 6320 2229 50  0000 R CNN
F 1 "RJ45" H 6320 2320 50  0000 R CNN
F 2 "" V 6650 2250 50  0001 C CNN
F 3 "~" V 6650 2250 50  0001 C CNN
	1    6650 2225
	-1   0    0    1   
$EndComp
Wire Wire Line
	2500 2200 2650 2200
Wire Wire Line
	6250 2125 6075 2125
$Comp
L power:GND #PWR?
U 1 1 5DECFE6B
P 2650 2875
F 0 "#PWR?" H 2650 2625 50  0001 C CNN
F 1 "GND" H 2655 2702 50  0000 C CNN
F 2 "" H 2650 2875 50  0001 C CNN
F 3 "" H 2650 2875 50  0001 C CNN
	1    2650 2875
	1    0    0    -1  
$EndComp
$Comp
L power:GNDD #PWR?
U 1 1 5DED040B
P 6075 2775
F 0 "#PWR?" H 6075 2525 50  0001 C CNN
F 1 "GNDD" H 6079 2620 50  0000 C CNN
F 2 "" H 6075 2775 50  0001 C CNN
F 3 "" H 6075 2775 50  0001 C CNN
	1    6075 2775
	1    0    0    -1  
$EndComp
NoConn ~ 2500 2700
NoConn ~ 6250 2625
Wire Wire Line
	2650 2200 2650 2400
Wire Wire Line
	2500 2400 2650 2400
Connection ~ 2650 2400
Wire Wire Line
	2650 2400 2650 2875
Wire Wire Line
	6075 2125 6075 2325
Wire Wire Line
	6250 2325 6075 2325
Connection ~ 6075 2325
Wire Wire Line
	6075 2325 6075 2775
Text Label 2800 2325 0    50   ~ 0
PSLoad
Text Label 2800 2425 0    50   ~ 0
Reset
$Comp
L 4xxx:4504 U?
U 1 1 5DEF4A26
P 5250 2625
F 0 "U?" H 5250 1636 50  0000 C CNN
F 1 "4504" H 5250 1545 50  0000 C CNN
F 2 "" H 5250 1325 50  0001 C CNN
F 3 "http://www.ti.com/lit/ds/symlink/cd4504b.pdf" H 4600 2275 50  0001 C CNN
	1    5250 2625
	1    0    0    -1  
$EndComp
$Comp
L power:+5VD #PWR?
U 1 1 5DEF9C88
P 5200 1450
F 0 "#PWR?" H 5200 1300 50  0001 C CNN
F 1 "+5VD" H 5215 1623 50  0000 C CNN
F 2 "" H 5200 1450 50  0001 C CNN
F 3 "" H 5200 1450 50  0001 C CNN
	1    5200 1450
	1    0    0    -1  
$EndComp
Text Label 2800 2225 0    50   ~ 0
Clock
$Comp
L Isolator:Si8641BB-B-IS1 U?
U 1 1 5DF06007
P 3900 2325
F 0 "U?" H 3900 2992 50  0000 C CNN
F 1 "Si8641BB-B-IS1" H 3900 2901 50  0000 C CNN
F 2 "Package_SO:SOIC-16_3.9x9.9mm_P1.27mm" H 3900 1775 50  0001 C CIN
F 3 "https://www.silabs.com/documents/public/data-sheets/si864x-datasheet.pdf" H 3900 2725 50  0001 C CNN
	1    3900 2325
	1    0    0    -1  
$EndComp
$Comp
L Device:R R?
U 1 1 5DF1483D
P 3300 2225
F 0 "R?" V 3225 2225 50  0000 C CNN
F 1 "47" V 3300 2225 50  0000 C CNN
F 2 "" V 3230 2225 50  0001 C CNN
F 3 "~" H 3300 2225 50  0001 C CNN
	1    3300 2225
	0    1    1    0   
$EndComp
$Comp
L Device:R R?
U 1 1 5DF15679
P 3300 2325
F 0 "R?" V 3275 2175 50  0000 C CNN
F 1 "47" V 3300 2325 50  0000 C CNN
F 2 "" V 3230 2325 50  0001 C CNN
F 3 "~" H 3300 2325 50  0001 C CNN
	1    3300 2325
	0    1    1    0   
$EndComp
$Comp
L Device:R R?
U 1 1 5DF15867
P 3300 2425
F 0 "R?" V 3275 2275 50  0000 C CNN
F 1 "47" V 3300 2425 50  0000 C CNN
F 2 "" V 3230 2425 50  0001 C CNN
F 3 "~" H 3300 2425 50  0001 C CNN
	1    3300 2425
	0    1    1    0   
$EndComp
Wire Wire Line
	3450 2225 3500 2225
Wire Wire Line
	3450 2325 3500 2325
Wire Wire Line
	3450 2425 3500 2425
Wire Wire Line
	2800 2425 3150 2425
Wire Wire Line
	2800 2325 3150 2325
Wire Wire Line
	2800 2225 3150 2225
Wire Wire Line
	3500 1925 3450 1925
Wire Wire Line
	3450 1925 3450 1675
Wire Wire Line
	3500 2025 3450 2025
Wire Wire Line
	3450 2025 3450 1925
Connection ~ 3450 1925
$Comp
L Device:R R?
U 1 1 5DF25F69
P 3300 2525
F 0 "R?" V 3375 2525 50  0000 C CNN
F 1 "47" V 3300 2525 50  0000 C CNN
F 2 "" V 3230 2525 50  0001 C CNN
F 3 "~" H 3300 2525 50  0001 C CNN
	1    3300 2525
	0    1    1    0   
$EndComp
Wire Wire Line
	3450 2525 3500 2525
$Comp
L power:GND #PWR?
U 1 1 5DF2C119
P 3425 2850
F 0 "#PWR?" H 3425 2600 50  0001 C CNN
F 1 "GND" H 3430 2677 50  0000 C CNN
F 2 "" H 3425 2850 50  0001 C CNN
F 3 "" H 3425 2850 50  0001 C CNN
	1    3425 2850
	1    0    0    -1  
$EndComp
Wire Wire Line
	3500 2725 3425 2725
Wire Wire Line
	3425 2725 3425 2850
Wire Wire Line
	4300 2325 4800 2325
Wire Wire Line
	4300 2425 4575 2425
Wire Wire Line
	4575 2425 4575 2125
Wire Wire Line
	4575 2125 4800 2125
Wire Wire Line
	4300 2225 4700 2225
Wire Wire Line
	4700 2225 4700 2525
Wire Wire Line
	4700 2525 4800 2525
Wire Wire Line
	4300 1925 4375 1925
Wire Wire Line
	4375 1925 4375 1575
Wire Wire Line
	4300 2025 4375 2025
Wire Wire Line
	4375 2025 4375 1925
Connection ~ 4375 1925
Wire Wire Line
	4300 2525 4575 2525
Wire Wire Line
	4575 2525 4575 3900
Wire Wire Line
	6075 3900 6075 3200
$Comp
L power:+5VD #PWR?
U 1 1 5DF32C75
P 4375 1575
F 0 "#PWR?" H 4375 1425 50  0001 C CNN
F 1 "+5VD" H 4390 1748 50  0000 C CNN
F 2 "" H 4375 1575 50  0001 C CNN
F 3 "" H 4375 1575 50  0001 C CNN
	1    4375 1575
	1    0    0    -1  
$EndComp
$Comp
L power:GNDD #PWR?
U 1 1 5DF332EC
P 4350 2850
F 0 "#PWR?" H 4350 2600 50  0001 C CNN
F 1 "GNDD" H 4354 2695 50  0000 C CNN
F 2 "" H 4350 2850 50  0001 C CNN
F 3 "" H 4350 2850 50  0001 C CNN
	1    4350 2850
	1    0    0    -1  
$EndComp
Wire Wire Line
	4300 2725 4350 2725
Wire Wire Line
	4350 2725 4350 2850
$Comp
L Connector:Barrel_Jack_MountingPin J?
U 1 1 5DF355B5
P 5950 1300
F 0 "J?" H 6007 1617 50  0000 C CNN
F 1 "Barrel_Jack_MountingPin" H 6007 1526 50  0000 C CNN
F 2 "" H 6000 1260 50  0001 C CNN
F 3 "~" H 6000 1260 50  0001 C CNN
	1    5950 1300
	1    0    0    -1  
$EndComp
$Comp
L Device:C C?
U 1 1 5DF386D6
P 3100 1825
F 0 "C?" H 3215 1871 50  0000 L CNN
F 1 "C" H 3215 1780 50  0000 L CNN
F 2 "" H 3138 1675 50  0001 C CNN
F 3 "~" H 3100 1825 50  0001 C CNN
	1    3100 1825
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5DF3A741
P 3100 2025
F 0 "#PWR?" H 3100 1775 50  0001 C CNN
F 1 "GND" H 2975 2000 50  0000 C CNN
F 2 "" H 3100 2025 50  0001 C CNN
F 3 "" H 3100 2025 50  0001 C CNN
	1    3100 2025
	1    0    0    -1  
$EndComp
Wire Wire Line
	3100 1975 3100 2025
Wire Wire Line
	3100 1675 3450 1675
Connection ~ 3450 1675
Wire Wire Line
	3450 1675 3450 1600
$Comp
L Device:R R?
U 1 1 5DF3FE63
P 5675 3900
F 0 "R?" V 5468 3900 50  0000 C CNN
F 1 "1k5" V 5559 3900 50  0000 C CNN
F 2 "" V 5605 3900 50  0001 C CNN
F 3 "~" H 5675 3900 50  0001 C CNN
	1    5675 3900
	0    1    1    0   
$EndComp
Wire Wire Line
	6075 3900 5825 3900
Wire Wire Line
	5525 3900 5200 3900
$Comp
L Device:C C?
U 1 1 5DF42D5F
P 5200 4050
F 0 "C?" H 5315 4096 50  0000 L CNN
F 1 "C" H 5315 4005 50  0000 L CNN
F 2 "" H 5238 3900 50  0001 C CNN
F 3 "~" H 5200 4050 50  0001 C CNN
	1    5200 4050
	1    0    0    -1  
$EndComp
Connection ~ 5200 3900
Wire Wire Line
	5200 3900 4575 3900
$Comp
L power:GNDD #PWR?
U 1 1 5DF4344A
P 5200 4275
F 0 "#PWR?" H 5200 4025 50  0001 C CNN
F 1 "GNDD" H 5204 4120 50  0000 C CNN
F 2 "" H 5200 4275 50  0001 C CNN
F 3 "" H 5200 4275 50  0001 C CNN
	1    5200 4275
	1    0    0    -1  
$EndComp
Wire Wire Line
	5200 4275 5200 4200
$EndSCHEMATC
