extends CharacterBody2D


const SPEED = 80.0
const ACCELERATION = 200.0
const FRICTION = 800.0

@onready var reticleHolder = $ReticleHolder
@onready var reticle = $ReticleHolder/Reticle

@onready var toolNameLabel = $ToolName

@onready var animationPlayer = $AnimationPlayer
@onready var animationTree = $AnimationTree
@onready var animationState = animationTree.get("parameters/playback")

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

func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	if direction:
		animationTree.set("parameters/Idles/blend_position", direction)
		animationTree.set("parameters/Movements/blend_position", direction)
		animationState.travel("Movements")
		velocity = velocity.move_toward(direction * SPEED, delta * ACCELERATION)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, delta * FRICTION)
		animationState.travel("Idles")

	if direction.length_squared() > 0:
		reticleHolder.rotation = direction.angle()
		reticle.rotation = -direction.angle()
	

	move_and_slide()
