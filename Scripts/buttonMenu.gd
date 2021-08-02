extends TextureButton

onready var parent = get_parent()
onready var sprite = $Sprite
var frame = null

func _ready():
	frame = parent.list
	sprite.set_frame(frame)
	parent.list += 1

func _on_TextureButton_button_up():
	get_parent().get_parent().get_parent().item = frame
