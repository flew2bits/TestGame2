extends Node

signal minute_passed
signal hour_passed

@export var seconds_per_minute = 0.25

var currentTime = 0.0
var currentMinute = 0
var currentHour = 0

func _process(delta):
	currentTime += delta;
	if currentTime < seconds_per_minute:
		return
		
	currentTime -= seconds_per_minute
	currentMinute += 1
	
	minute_passed.emit()
	
	if currentMinute < 60:
		return
		
	currentMinute -= 60
	currentHour += 1
	
	hour_passed.emit()
