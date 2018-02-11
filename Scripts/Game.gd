extends Node

var player = preload("res://Player.tscn") # Carrega cena player na memória
var premorte = preload("res://Morte.tscn") # Carrega cena morte na memória
var wall = preload("res://Wall.tscn") # Carrega moro na memória
var texture1 = preload("res://Resorces/player1.tex") # Textura do player 1
var texture2 = preload("res://Resorces/player2.tex") # Textura do player 2
var p1
var p2
var tm1 = true
var tm2 = true
var p1vivo = true
var p2vivo = true
var p1pontos = 0
var p2pontos = 0
var jogando = false

func _ready():
	carrega_jogador()
	cenario()
	set_process(true)

func carrega_jogador():
	# Carrega jogador 1
	p1 = player.instance()
	add_child(p1)
	p1.set_global_pos(get_node("PosP1").get_global_pos())
	p1.player = 1
	p1.get_node("Sprite").set_texture(texture1) # Carrega textura
	p1.connect("morreu",p1.get_parent(),"p1morreu")
	p1vivo = true
	
	# Carrega jogador 2
	p2 = player.instance()
	add_child(p2)
	p2.set_global_pos(get_node("PosP2").get_global_pos())
	p2.player = 2
	p2.get_node("Sprite").set_texture(texture2) # Carrega textura
	p2.connect("morreu",p2.get_parent(),"p2morreu")
	p2vivo = true
	
	jogando = true

func cenario():
	var i = 24
	var j = 26
	var alt = false
	
	while i < 256:
		j = 26
		
		while j < 224:
			if (i == 24) or (j == 26 and i <= 232) or (i <= 232 and j >= 216) or ( i >= 232 and i < 233 and j < 224):
				gera_muro(i,j)
			
			j += 14
			
			if alt:
				j += 4
				alt = false
			else:
				alt = true
		
		i += 16
	

func gera_muro(i,j):
	var wall1 = wall.instance()
	add_child(wall1)
	wall1.set_pos(Vector2(i,j))

func p1morreu():
	if p1vivo:
		p2pontos += 1
		get_node("Control/P2pontos").set_text("P2: " + str(p2pontos))
		p1vivo = false
		jogando = false
		p2vivo = false
		get_node("Timer").start()
	
func p2morreu():
	if p2vivo:
		p1pontos += 1
		get_node("Control/P1pontos").set_text("P1: " + str(p1pontos))
		p2vivo = false
		jogando = false
		p1vivo = false
		get_node("Timer").start()

func _process(delta):
	if p1vivo:
		if p1.movendo and tm1: # Gerar morte p1
			var morte1 = premorte.instance()
			add_child(morte1)
			morte1.set_global_pos(p1.pmorte)
			get_node("T1").start()
			tm1 = false
	
	if p2vivo:
		if p2.movendo and tm2: # Gerar morte p2
			var morte2 = premorte.instance()
			add_child(morte2)
			morte2.set_global_pos(p2.pmorte)
			get_node("T2").start()
			tm2 = false

func _on_T1_timeout():
	tm1 = true

func _on_T2_timeout():
	tm2 = true

func _on_Timer_timeout():
	get_tree().call_group(0,"players","elimina")
	
	carrega_jogador()