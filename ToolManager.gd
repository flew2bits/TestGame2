extends CanvasLayer

@onready var timer = $Timer

signal tool_selected

signal south_tool_held

var south_tool_held_triggered = false

enum Tool { NORTH, EAST, SOUTH, WEST}

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _input(inputEvent):
	if inputEvent.is_action_released("tool_up"):
		tool_selected.emit(Tool.NORTH)
	elif inputEvent.is_action_released("tool_left"):
		tool_selected.emit(Tool.WEST)
	elif inputEvent.is_action_released("tool_right"):
		tool_selected.emit(Tool.EAST)
	elif inputEvent.is_action_pressed("tool_down"):
		print("tool_down pressed")
		south_tool_held_triggered = false
		timer.start(0.5)
		await timer.timeout
		if not Input.is_action_pressed("tool_down"): return
		south_tool_held.emit()
		south_tool_held_triggered = true
	elif inputEvent.is_action_released("tool_down"):
		print("tool_down released")
		if not timer.is_stopped() and not south_tool_held_triggered:
			tool_selected.emit(Tool.SOUTH)
			timer.stop()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


#
#func _on_timer_timeout():
#	south_tool_held.emit()
#	south_tool_held_triggered = true
