extends KinematicBody2D

const tilesize = 16
onready var S = $S
onready var D = $D
onready var W = $W
onready var A = $A
onready var timer = $Timer
onready var cooldown = false
var input_vector = Vector2.ZERO
var direcao = Vector2.DOWN


func _physics_process(delta):
	if not cooldown:
		cooldown = true
		timer.start(0.15)
		input_vector.x = (0 if $D.is_colliding() else int(Input.get_action_strength("ui_right"))) - (0 if $A.is_colliding() else int(Input.get_action_strength("ui_left")))
		input_vector.y = (0 if $S.is_colliding() else int(Input.get_action_strength("ui_down"))) - (0 if $W.is_colliding() else  int(Input.get_action_strength("ui_up")))
		match input_vector:
			Vector2.UP:
				direcao = Vector2.UP
			Vector2.LEFT:
				direcao = Vector2.LEFT
			Vector2.RIGHT:
				direcao = Vector2.RIGHT
			Vector2.DOWN:
				direcao = Vector2.DOWN
		
		global_position += input_vector * tilesize


func _on_Timer_timeout():
	cooldown = false
