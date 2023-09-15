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
	if Input.is_action_just_released("tool_up"):
		tool_selected.emit(Tool.NORTH)
	elif Input.is_action_just_released("tool_left"):
		tool_selected.emit(Tool.WEST)
	elif Input.is_action_just_released("tool_right"):
		tool_selected.emit(Tool.EAST)
	elif Input.is_action_just_pressed("tool_down"):
		timer.start()
	elif Input.is_action_just_released("tool_down"):
		if not timer.is_stopped() and not south_tool_held_triggered:
			tool_selected.emit(Tool.SOUTH)
			timer.stop()
		south_tool_held_triggered = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_timer_timeout():
	south_tool_held.emit()
	south_tool_held_triggered = true
