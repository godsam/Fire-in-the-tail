extends KinematicBody2D

var player = 0
var vel = 80
var dir = Vector2()
var pmorte = Vector2()
var movendo = false

signal morreu

func _ready():
	set_process(true)

func _process(delta):
	dir = Vector2()
	movendo = false
	
	if player == 1: # Movimentação do player 1
		if Input.is_action_pressed("play1r"):
			dir = Vector2(1,0)
			pmorte = get_node("PosL").get_global_pos()
			movendo = true
		elif Input.is_action_pressed("play1l"):
			dir = Vector2(-1,0)
			pmorte = get_node("PosR").get_global_pos()
			movendo = true
		elif Input.is_action_pressed("play1u"):
			dir = Vector2(0,-1)
			pmorte = get_node("PosD").get_global_pos()
			movendo = true
		elif Input.is_action_pressed("play1d"):
			dir = Vector2(0,1)
			pmorte = get_node("PosU").get_global_pos()
			movendo = true
		
		set_global_pos(get_global_pos() + dir * vel * delta)
		
	elif player == 2: # Movimentação do player 2
		if Input.is_action_pressed("play2r"):
			dir = Vector2(1,0)
			pmorte = get_node("PosL").get_global_pos()
			movendo = true
		elif Input.is_action_pressed("play2l"):
			dir = Vector2(-1,0)
			pmorte = get_node("PosR").get_global_pos()
			movendo = true
		elif Input.is_action_pressed("play2u"):
			dir = Vector2(0,-1)
			pmorte = get_node("PosD").get_global_pos()
			movendo = true
		elif Input.is_action_pressed("play2d"):
			dir = Vector2(0,1)
			pmorte = get_node("PosU").get_global_pos()
			movendo = true
		
		set_global_pos(get_global_pos() + dir * vel * delta)

func morte(): # Sinal de morte do jogador e elimina o objeto da memóra
	emit_signal("morreu")
	queue_free()
