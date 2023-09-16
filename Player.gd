extends CharacterBody2D

const SPEED = 100.0
const ACCELERATION = 200.0

@onready var reticleHolder = $ReticleHolder
@onready var reticle = $ReticleHolder/Reticle
@onready var activationTarget = $ActivationTargetHolder/ActivationTarget

@onready var toolNameLabel = $ToolName

@export var tileMap : TileMap 

var cancelCount = 0

func _ready():
	#TimeManager.minute_passed.connect(do_something)
	ToolManager.tool_selected.connect(select_tool)

func _input(inputEvent):
	if Input.is_action_just_pressed("cancel"):
		call_deferred("do_something")

func do_something():
	print("doing something")
	var timer = Timer.new()
	timer.wait_time = 10
	get_tree().root.add_child(timer)
	timer.timeout.connect(create_callback(timer, cancelCount))
	cancelCount += 1
	timer.start()

func create_callback(theTimer, val):
	var timer = theTimer
	return func():
		print("did something: " + str(val))
		timer.queue_free()

func did_something():
	print("did something")

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
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if direction:
		velocity = velocity.move_toward(direction * SPEED, delta * ACCELERATION)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, SPEED)

	if direction.length_squared() > 0:
		reticleHolder.rotation = direction.angle()
		reticle.rotation = -direction.angle()
	

	move_and_slide()


func _on_reticle_target_area_entered(area):
	print("entered")
	var tilePosition = tileMap.local_to_map(reticle.global_position)
	activationTarget.position = tileMap.map_to_local(tilePosition)
	print(tilePosition)
	print(activationTarget.position)
	activationTarget.show()
	


func _on_reticle_target_area_exited(area):
	print("exited")
	activationTarget.hide() 
