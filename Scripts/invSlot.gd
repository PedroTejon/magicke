extends TextureButton

const selectedSlot = preload("res://Sprites/invselect.png")
const unselectedSlot = preload("res://Sprites/invslot.png")
const horizontalOn = preload('res://Sprites//horizontal.png')
const horizontalOff = preload('res://Sprites//horizontaloff.png')
const horizontalBlock = preload('res://Sprites//horizontalBlock.png')
const horizontalHover = preload('res://Sprites//horizontalhover.png')
const verticalOn = preload('res://Sprites//vertical.png')
const verticalOff = preload('res://Sprites//verticaloff.png')
const verticalBlock = preload('res://Sprites//verticalBlock.png')
const verticalHover = preload('res://Sprites//verticalhover.png')

onready var thisIndex = get_index()
onready var item = $Sprite
onready var caminhoCima = $caminhoCima
onready var caminhoBaixo = $caminhoBaixo
onready var caminhoEsquerda = $caminhoEsquerda
onready var caminhoDireita = $caminhoDireita

signal chamarJanela(slot)

var conexoes = 0
var vizinhoDireita = null
var vizinhoEsquerda = null
var vizinhoBaixo = null
var vizinhoCima = null
var cimaToggle = 0
var baixoToggle = 0
var esquerdaToggle = 0
var direitaToggle = 0
var selecteditem = 0

enum{
	UNTOGGLED,
	TOGGLED,
	BLOCKED
}


func _ready():
	if thisIndex % 5 == 0:
		vizinhoDireita = get_parent().get_child(thisIndex + 1)
	elif (thisIndex + 1) % 5 == 0:
		vizinhoEsquerda = get_parent().get_child(thisIndex - 1)
	else:
		vizinhoEsquerda = get_parent().get_child(thisIndex - 1)
		vizinhoDireita = get_parent().get_child(thisIndex + 1)
		
	if thisIndex - 5 < 0:
		vizinhoBaixo = get_parent().get_child(thisIndex + 5)
	elif thisIndex + 5 > 24:
		vizinhoCima = get_parent().get_child(thisIndex - 5)
	else:
		vizinhoCima = get_parent().get_child(thisIndex - 5)
		vizinhoBaixo = get_parent().get_child(thisIndex + 5)


func activateshit(Index):
	if Index % 5 == 0:
		get_parent().get_child(Index).caminhoDireita.visible = true
	elif (Index + 1) % 5 == 0:
		get_parent().get_child(Index).caminhoEsquerda.visible = true
	else:
		get_parent().get_child(Index).caminhoDireita.visible = true
		get_parent().get_child(Index).caminhoEsquerda.visible = true
		
	if Index - 5 < 0:
		get_parent().get_child(Index).caminhoBaixo.visible = true
	elif Index + 5 > 24:
		get_parent().get_child(Index).caminhoCima.visible = true
	else:
		get_parent().get_child(Index).caminhoCima.visible = true
		get_parent().get_child(Index).caminhoBaixo.visible = true
		

func _on_Invetory_Slot_button_up():
	var invatual = get_parent().list
	var selected = get_parent().get_parent().get_node('Node').selected
	selecteditem = get_parent().get_parent().get_child(selected).item
	
	if selecteditem == 1 and not 1 in invatual:
		activateshit(thisIndex)
		item.set_frame(selecteditem)
		invatual[thisIndex] = selecteditem
		
	elif selecteditem != 1 and conexoes <= 1:
		cimaToggle = 0
		baixoToggle = 0
		esquerdaToggle = 0
		direitaToggle = 0
		conexoes = 0
		if caminhoBaixo.get_normal_texture().to_string() == '[StreamTexture:1220]':
			vizinhoBaixo.conexoes -= 1
			vizinhoBaixo.cimaToggle = 0
			vizinhoBaixo.get_child(1).set_normal_texture(horizontalOff)
			caminhoBaixo.set_normal_texture(horizontalOff)
		elif caminhoCima.get_normal_texture().to_string() == '[StreamTexture:1220]':
			vizinhoCima.conexoes -= 1
			vizinhoCima.baixoToggle = 0
			vizinhoCima.get_child(2).set_normal_texture(horizontalOff)
			caminhoCima.set_normal_texture(horizontalOff)
		elif caminhoEsquerda.get_normal_texture().to_string() == '[StreamTexture:1232]':
			vizinhoEsquerda.conexoes -= 1
			vizinhoEsquerda.direitaToggle = 0
			vizinhoEsquerda.get_child(4).set_normal_texture(verticalOff)
			caminhoEsquerda.set_normal_texture(verticalOff)
		elif caminhoDireita.get_normal_texture().to_string() == '[StreamTexture:1232]':
			vizinhoDireita.conexoes -= 1
			vizinhoDireita.esquerdaToggle = 0
			vizinhoDireita.get_child(3).set_normal_texture(verticalOff)
			caminhoDireita.set_normal_texture(verticalOff)
			
		caminhoBaixo.visible = false
		caminhoCima.visible = false
		caminhoDireita.visible = false
		caminhoEsquerda.visible = false
		item.set_frame(selecteditem)
		invatual[thisIndex] = selecteditem
	
	elif not selecteditem in [0, 1]:
		item.set_frame(selecteditem)
		invatual[thisIndex] = selecteditem
		

func _on_caminhoCima_button_up():
	if cimaToggle == TOGGLED:
		if vizinhoCima.conexoes == 1:
			for x in range(1, 5):
				vizinhoCima.get_child(x).visible = false
			caminhoCima.set_normal_texture(horizontalOff)
			cimaToggle = UNTOGGLED
			vizinhoCima.get_child(2).set_normal_texture(horizontalOff)
			vizinhoCima.baixoToggle = UNTOGGLED
			self.conexoes -= 1
			vizinhoCima.conexoes -= 1
		elif vizinhoCima.selecteditem == 1 or vizinhoCima.conexoes > 1:
			caminhoCima.set_normal_texture(horizontalOff)
			cimaToggle = UNTOGGLED
			vizinhoCima.get_child(2).set_normal_texture(horizontalOff)
			vizinhoCima.baixoToggle = UNTOGGLED
			self.conexoes -= 1
			vizinhoCima.conexoes -= 1
	elif cimaToggle == UNTOGGLED and vizinhoCima.selecteditem != 0:
		activateshit(vizinhoCima.get_index())
		caminhoCima.set_normal_texture(horizontalOn)
		cimaToggle = TOGGLED
		vizinhoCima.get_child(2).set_normal_texture(horizontalBlock)
		vizinhoCima.baixoToggle = BLOCKED
		self.conexoes += 1
		vizinhoCima.conexoes += 1


func _on_caminhoBaixo_button_up():
	if baixoToggle == TOGGLED:
		if vizinhoBaixo.conexoes == 1:
			for x in range(1, 5):
				vizinhoBaixo.get_child(x).visible = false
			caminhoBaixo.set_normal_texture(horizontalOff)
			baixoToggle = UNTOGGLED
			vizinhoBaixo.get_child(1).set_normal_texture(horizontalOff)
			vizinhoBaixo.cimaToggle = UNTOGGLED
			self.conexoes -= 1
			vizinhoBaixo.conexoes -= 1
		elif vizinhoBaixo.selecteditem == 1 or vizinhoBaixo.conexoes > 1:
			caminhoBaixo.set_normal_texture(horizontalOff)
			baixoToggle = UNTOGGLED
			vizinhoBaixo.get_child(1).set_normal_texture(horizontalOff)
			vizinhoBaixo.cimaToggle = UNTOGGLED
			self.conexoes -= 1
			vizinhoBaixo.conexoes -= 1
	elif baixoToggle == UNTOGGLED and vizinhoBaixo.selecteditem != 0:
		activateshit(vizinhoBaixo.get_index())
		caminhoBaixo.set_normal_texture(horizontalOn)
		baixoToggle = TOGGLED
		vizinhoBaixo.get_child(1).set_normal_texture(horizontalBlock)
		vizinhoBaixo.cimaToggle = BLOCKED
		self.conexoes += 1
		vizinhoBaixo.conexoes += 1


func _on_caminhoEsquerda_button_up():
	if esquerdaToggle == TOGGLED:
		if vizinhoEsquerda.conexoes == 1:
			for x in range(1, 5):
				vizinhoEsquerda.get_child(x).visible = false
			caminhoEsquerda.set_normal_texture(verticalOff)
			esquerdaToggle = UNTOGGLED
			vizinhoEsquerda.get_child(4).set_normal_texture(verticalOff)
			vizinhoEsquerda.direitaToggle = UNTOGGLED
			self.conexoes -= 1
			vizinhoEsquerda.conexoes -= 1
		elif vizinhoEsquerda.selecteditem == 1 or vizinhoEsquerda.conexoes > 1:
			caminhoEsquerda.set_normal_texture(verticalOff)
			esquerdaToggle = UNTOGGLED
			vizinhoEsquerda.get_child(4).set_normal_texture(verticalOff)
			vizinhoEsquerda.direitaToggle = UNTOGGLED
			self.conexoes -= 1
			vizinhoEsquerda.conexoes -= 1
	elif esquerdaToggle == UNTOGGLED and vizinhoEsquerda.selecteditem != 0:
		activateshit(vizinhoEsquerda.get_index())
		caminhoEsquerda.set_normal_texture(verticalOn)
		esquerdaToggle = TOGGLED
		vizinhoEsquerda.get_child(4).set_normal_texture(verticalBlock)
		vizinhoEsquerda.direitaToggle = BLOCKED
		self.conexoes += 1
		vizinhoEsquerda.conexoes += 1


func _on_caminhoDireita_button_up():
	if direitaToggle == TOGGLED:
		if vizinhoDireita.conexoes == 1:
			self.conexoes -= 1
			vizinhoDireita.conexoes -= 1
			for x in range(1, 5):
				vizinhoDireita.get_child(x).visible = false
			caminhoDireita.set_normal_texture(verticalOff)
			direitaToggle = UNTOGGLED
			vizinhoDireita.get_child(3).set_normal_texture(verticalOff)
			vizinhoDireita.esquerdaToggle = UNTOGGLED
		elif vizinhoDireita.selecteditem == 1 or vizinhoDireita.conexoes > 1:
			self.conexoes -= 1
			vizinhoDireita.conexoes -= 1
			caminhoDireita.set_normal_texture(verticalOff)
			direitaToggle = UNTOGGLED
			vizinhoDireita.get_child(3).set_normal_texture(verticalOff)
			vizinhoDireita.esquerdaToggle = UNTOGGLED
	elif direitaToggle == UNTOGGLED and vizinhoDireita.selecteditem != 0:
		activateshit(vizinhoDireita.get_index())
		caminhoDireita.set_normal_texture(verticalOn)
		direitaToggle = TOGGLED
		vizinhoDireita.get_child(3).set_normal_texture(verticalBlock)
		vizinhoDireita.esquerdaToggle = BLOCKED
		self.conexoes += 1
		vizinhoDireita.conexoes += 1


func _on_caminhoDireita_mouse_entered():
	caminhoDireita.set_normal_texture(verticalHover)


func _on_caminhoDireita_mouse_exited():
	if direitaToggle == TOGGLED:
		caminhoDireita.set_normal_texture(verticalOn)
	elif direitaToggle == UNTOGGLED:
		caminhoDireita.set_normal_texture(verticalOff)
	elif direitaToggle == BLOCKED:
		caminhoDireita.set_normal_texture(verticalBlock)


func _on_caminhoEsquerda_mouse_entered():
	caminhoEsquerda.set_normal_texture(verticalHover)


func _on_caminhoEsquerda_mouse_exited():
	if esquerdaToggle == TOGGLED:
		caminhoEsquerda.set_normal_texture(verticalOn)
	elif esquerdaToggle == UNTOGGLED:
		caminhoEsquerda.set_normal_texture(verticalOff)
	elif esquerdaToggle == BLOCKED:
		caminhoEsquerda.set_normal_texture(verticalBlock)


func _on_caminhoBaixo_mouse_entered():
	caminhoBaixo.set_normal_texture(horizontalHover)


func _on_caminhoBaixo_mouse_exited():
	if baixoToggle == TOGGLED:
		caminhoBaixo.set_normal_texture(horizontalOn)
	elif baixoToggle == UNTOGGLED:
		caminhoBaixo.set_normal_texture(horizontalOff)
	elif baixoToggle == BLOCKED:
		caminhoBaixo.set_normal_texture(horizontalBlock)


func _on_caminhoCima_mouse_entered():
	caminhoCima.set_normal_texture(horizontalHover)


func _on_caminhoCima_mouse_exited():
	if cimaToggle == TOGGLED:
		caminhoCima.set_normal_texture(horizontalOn)
	elif cimaToggle == UNTOGGLED:
		caminhoCima.set_normal_texture(horizontalOff)
	elif cimaToggle == BLOCKED:
		caminhoCima.set_normal_texture(horizontalBlock)


func _on_Invetory_Slot_mouse_entered():
	set_normal_texture(selectedSlot)
#	var Menu = get_parent().get_parent().get_node("Janelinha")
#	emit_signal('chamarJanela', thisIndex)
#	Menu.set_global_position(get_global_mouse_position())
	

func _on_Invetory_Slot_mouse_exited():
	set_normal_texture(unselectedSlot)
#	var Menu = get_parent().get_parent().get_node("Janelinha")
#	Menu.set_global_position(Vector2(-900, -900))
