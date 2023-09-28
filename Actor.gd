extends CharacterBody2D

@onready var sprite = $Sprite
@onready var startingMaterial = sprite.get_material()
const highlightMaterial = "res://outline.gdshader"


func _on_area_2d_area_entered(area):
	sprite.set_material(highlightMaterial)
	print("hi");

func _on_area_2d_area_exited(area):
	sprite.set_material(startingMaterial)
	print("bye)
