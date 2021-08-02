extends KinematicBody2D

onready var timer = $Timer
onready var timer2 = $Timer2
onready var S = $S
onready var D = $D
onready var W = $W
onready var A = $A
var main = null
var direction = null setget aa
var cooldown = false

func aa(value):
	direction = value
	match direction:
		Vector2.LEFT:
			main = A
		Vector2.RIGHT:
			main = D
		Vector2.UP:
			main = W
		Vector2.DOWN:
			main = S

func _physics_process(delta):
	if not main.is_colliding():
		if not cooldown:
			cooldown = true
			timer2.start(0.1)
			global_position += direction * 16

func _ready():
	timer.start(2)

func _on_Timer_timeout():
	queue_free()


func _on_Timer2_timeout():
	cooldown = false
