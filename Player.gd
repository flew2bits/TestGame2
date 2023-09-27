extends CharacterBody2D


const SPEED = 80.0
const ACCELERATION = 500.0

@onready var reticleHolder = $ReticleHolder
@onready var reticle = $ReticleHolder/Reticle

@onready var toolNameLabel = $ToolName

func _ready():
	#TimeManager.minute_passed.connect(do_something)
	ToolManager.tool_selected.connect(select_tool)
	ToolManager.south_tool_held.connect(do_something)

func do_something():
	print("something")

func select_tool(tool):
	match tool:
		ToolManager.Tool.NORTH:
			toolNameLabel.text = "hoe"
		ToolManager.Tool.EAST:
			toolNameLabel.text = "spade"
		ToolManager.Tool.WEST:
			toolNameLabel.text = "water"
		ToolManager.Tool.SOUTH:
			toolNameLabel.text = "none"

func _process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	if direction:
		velocity = velocity.move_toward(direction * SPEED, delta * ACCELERATION)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, delta * ACCELERATION)

	if direction.length_squared() > 0:
		reticleHolder.rotation = direction.angle()
		reticle.rotation = -direction.angle()
	
	move_and_slide()
