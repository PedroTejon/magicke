extends GridContainer

onready var sprites = preload('res://Scenes/spritesItens.tscn').instance()
onready var itens = sprites.get_hframes()
var list = 0
const botao = preload("res://Scenes//buttonMenu.tscn")

func _ready():
	for x in range(itens):
		add_child(botao.instance())
		get_children()[-1].get_node('Sprite').set_frame(x)

