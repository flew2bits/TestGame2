extends CharacterBody2D


const SPEED = 100.0
const ACCELERATION = 200.0

@onready var reticleHolder = $ReticleHolder
@onready var reticle = $ReticleHolder/Reticle

func _ready():
	#TimeManager.minute_passed.connect(do_something)
	pass

func do_something():
	print("something")


func _physics_process(delta):
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if direction:
		velocity = velocity.move_toward(direction * SPEED, delta * ACCELERATION)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, SPEED)

	if direction.length_squared() > 0:
		reticleHolder.rotation = direction.angle()
		reticle.rotation = -direction.angle()
	

	move_and_slide()
