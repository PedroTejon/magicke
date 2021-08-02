extends Panel

var item = null setget changed
var botaoclicado = null

func changed(value):
	item = value
	var selecionado = get_parent().get_child(botaoclicado)
	selecionado.get_node('Sprite').set_frame(item)
	selecionado.item = item
	self.queue_free()
	
