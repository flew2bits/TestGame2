extends CharacterBody2D

@onready var sprite = $Sprite
@onready var startingMaterial =  sprite.get_material()
@onready var highlightMaterial = preload("res://MaterialsShaders/outlineMaterial.tres")

var ICanBeInteractedWith = true;
var beingHovered = false;

func _on_area_2d_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	beingHovered = true
	if ICanBeInteractedWith: 
		sprite.set_material(highlightMaterial)

func _on_area_2d_area_shape_exited(area_rid, area, area_shape_index, local_shape_index):
	beingHovered = false
	sprite.set_material(startingMaterial)

func _input(event):
	talk_to_me(event)

func talk_to_me(event):
	if Dialogic.current_timeline != null || !beingHovered:
		return
	
	if event is InputEventKey and event.keycode == KEY_SPACE and event.pressed:
		Dialogic.start('FirstQuest')
		get_viewport().set_input_as_handled()
