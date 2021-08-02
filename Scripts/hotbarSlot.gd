extends TextureButton

onready var menu = preload("res://Scenes//MenuSelecao.tscn")
onready var parent = get_parent()
export var item = 0

func _ready():
	get_node("Sprite").set_frame(item)


func _on_TextureButton_button_up():
	if parent.get_node_or_null('Panel') == null:
		var Menu = menu.instance()
		parent.add_child(Menu)
		Menu.set_global_position(rect_global_position + Vector2(2, -50))
		Menu.botaoclicado = get_index()
