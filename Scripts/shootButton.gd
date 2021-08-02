extends TextureButton

onready var inv = get_node('/root/Mundo/TextureRect/Inventory')
var lista = []


func _on_shootButton_button_up():
	lista = inv.list
	if lista.find(1) != -1:
		search(lista.find(1), null)
		
	
func lancarcoiso(poder):
	var spell = load('res://Scenes/spell.tscn').instance()
	var player = get_node('/root/Mundo/Node2D/Player')
	get_parent().add_child(spell)
	spell.direction = player.direcao
	spell.set_position(player.get_global_position() + (player.direcao * 16))
	if poder == 'Agua':
		spell.get_node('Sprite').set_frame(3)
	elif poder == 'Fogo':
		spell.get_node('Sprite').set_frame(2)
	elif poder == 'Acido':
		spell.get_node('Sprite').set_frame(5)


func search(x, poder):
	var child = inv.get_child(x)
	if child == null: return
	elif child.get_node('Sprite').get_frame() == 4:
		print(poder)
		lancarcoiso(poder)
		return 
		
	print(x)
	if child.get_node('Sprite').get_frame() == 2:
		poder = 'Fogo'
	elif child.get_node('Sprite').get_frame() == 3:
		poder = 'Agua'
	elif child.get_node('Sprite').get_frame() == 5:
		poder = 'Acido'
		
	
	if x % 5 == 0 and child.direitaToggle == 1:
		search(x + 1, poder)

	elif (x + 1) % 5 == 0 and child.esquerdaToggle == 1:
		search(x - 1, poder)
		
	else:
		if child.direitaToggle == 1:
			search(x + 1, poder)
		if child.esquerdaToggle == 1:
			search(x - 1, poder)

	if x - 5 < 0 and child.cimaToggle == 1:
		search(x - 5, poder)
			
	elif x + 5 > 24 and child.baixoToggle == 1:
		search(x + 5, poder)
			
	else:
		if child.cimaToggle == 1:
			search(x - 5, poder)
			
		if child.baixoToggle == 1:
			search(x + 5, poder)

