extends Node2D

@export var tilledTexture: Texture2D

@onready var activated = $Activated

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_area_entered(area):
	print("entered")
	activated.show()
	pass # Replace with function body.

func _on_area_2d_area_exited(area):
	activated.hide()
	print("exited")
