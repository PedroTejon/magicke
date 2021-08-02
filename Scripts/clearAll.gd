extends TextureButton

onready var inventory = get_parent().get_node("Inventory")
const verticalOff = preload('res://Sprites//verticaloff.png')
const horizontalOff = preload('res://Sprites//horizontaloff.png')

func _on_clearAll_button_up():
	for x in range(25):
		inventory.list = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
		var child = inventory.get_child(x)
		child.conexoes = 0
		child.item.set_frame(0)
		child.cimaToggle = 0
		child.baixoToggle = 0
		child.esquerdaToggle = 0
		child.direitaToggle = 0
		child.selecteditem = 0
		child.caminhoBaixo.set_normal_texture(horizontalOff)
		child.caminhoCima.set_normal_texture(horizontalOff)
		child.caminhoEsquerda.set_normal_texture(verticalOff)
		child.caminhoDireita.set_normal_texture(verticalOff)
		child.caminhoBaixo.visible = false
		child.caminhoCima.visible = false
		child.caminhoDireita.visible = false
		child.caminhoEsquerda.visible = false

