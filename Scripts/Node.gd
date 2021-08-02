extends Node

var selected = null
const unselslot = preload('res://Sprites//invslot.png')
const selslot = preload('res://Sprites//invselect2.png')
onready var parent = get_parent()
onready var slots = [get_parent().get_node("TextureButton"),
			 get_parent().get_node("TextureButton2"),
			 get_parent().get_node("TextureButton3"),
			 get_parent().get_node("TextureButton4"),
			 get_parent().get_node("TextureButton5")]


func _ready():
	change_sel(0)


func change_sel(value):
	selected = value
	for x in range(0, 5):
		slots[x].set_normal_texture(unselslot)
	slots[value].set_normal_texture(selslot)


func _input(event):
	if event.is_action_pressed('firstSlot'):
		change_sel(0)
	elif event.is_action_pressed('secondSlot'):
		change_sel(1)
	elif event.is_action_pressed('thirdSlot'):
		change_sel(2)
	elif event.is_action_pressed('fourthSlot'):
		change_sel(3)
	elif event.is_action_pressed('fifthSlot'):
		change_sel(4)
