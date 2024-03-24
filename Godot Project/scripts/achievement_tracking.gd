extends Node

################
#  Game State  #
################
var results_check_win = false
var number_of_shots = 0
var number_of_shields = 0
var number_of_swords = 0
var number_of_minions = 0
var time_taken = 0
var time_start = 0

################
# Achievements #
################
var sword = 0
var shield = 0
var heart = 0
var victory = 0

var heart_check = false
var shield_track = 0
var sword_track = 0

func reset_progress():
	shield_track = 0
	sword_track = 0

