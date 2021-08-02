extends Panel

onready var esquerda = $Label
onready var direita = $Label2
onready var cima = $Label3
onready var baixo = $Label4
onready var conexinhos = $Label5


func _ready():
	for x in 25:
		get_parent().get_node('Inventory').get_child(x).connect('chamarJanela', self, 'mostrar')


func mostrar(slot):
	var coiso = get_parent().get_node('Inventory').get_child(slot)
	esquerda.set_text("E: " + str(coiso.esquerdaToggle))
	direita.set_text("D: " + str(coiso.direitaToggle))
	cima.set_text("C: " + str(coiso.cimaToggle))
	baixo.set_text("B: " + str(coiso.baixoToggle))
	conexinhos.set_text("CO: " + str(coiso.conexoes))
	
