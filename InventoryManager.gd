extends CanvasLayer

@onready var container = $InventoryMain

# Called when the node enters the scene tree for the first time.
func _ready():
	ToolManager.south_tool_held.connect(show_me) # Replace with function body.

func _input(inputEvent):
	if Input.is_action_just_pressed("cancel"):
		container.hide()
		get_tree().paused = false

func show_me():
	get_tree().paused = true
	container.show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
