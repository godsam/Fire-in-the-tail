extends KinematicBody2D

var player = 0
var vel = 80
var dir = Vector2()
var pmorte = Vector2()
var movendo = false
var rigido = true
var vert = false
var bParado = false
var bUp = false
var bDown = false
var bLeft = false
var bRight = false

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
			vert = false
		elif Input.is_action_pressed("play1l"):
			dir = Vector2(-1,0)
			pmorte = get_node("PosR").get_global_pos()
			movendo = true
			vert = false
		elif Input.is_action_pressed("play1u"):
			dir = Vector2(0,-1)
			pmorte = get_node("PosD").get_global_pos()
			movendo = true
			vert = true
		elif Input.is_action_pressed("play1d"):
			dir = Vector2(0,1)
			pmorte = get_node("PosU").get_global_pos()
			movendo = true
			vert = true
		
		move(dir * vel * delta)
		
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
		
		move(dir * vel * delta)
	
	if movendo:
		if dir.x > 0:
			if !bRight:
				get_node("Anim").stop_all()
				get_node("Sprite").set("Sprite/Flip_H",true)
				get_node("Anim").play("Walk")
				bRight = true
				bParado = false
				bUp = false
				bDown = false
				bLeft = false
		elif dir.x < 0:
			if !bLeft:
				get_node("Anim").stop_all()
				get_node("Sprite").set("Sprite/Flip_H",false)
				get_node("Anim").play("Walk")
				bLeft = true
				bParado = false
				bUp = false
				bDown = false
				bRight = false
		elif dir.y > 0:
			if !bDown:
				get_node("Anim").stop_all()
				get_node("Anim").play("Down")
				bDown = true
				bParado = false
				bUp = false
				bLeft = false
				bRight = false
		elif dir.y < 0:
			if !bUp:
				get_node("Anim").stop_all()
				get_node("Anim").play("Up")
				bUp = true
				bParado = false
				bDown = false
				bLeft = false
				bRight = false
	else:
		if !bParado:
			if vert:
				get_node("Anim").play("StandF")
			else:
				get_node("Anim").play("StandL")
			bParado = true
			bUp = false
			bDown = false
			bLeft = false
			bRight = false
	

func morte(): # Sinal de morte do jogador e elimina o objeto da memóra
	emit_signal("morreu")
	queue_free()

func elimina():
	queue_free()