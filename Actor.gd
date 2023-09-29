extends CharacterBody2D

@onready var sprite = $Sprite
@onready var startingMaterial =  sprite.get_material()
@onready var highlightMaterial = preload("res://MaterialsShaders/outlineMaterial.tres")

func _on_area_2d_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	sprite.set_material(highlightMaterial)

func _on_area_2d_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	sprite.set_material(startingMaterial)
