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

func _ready():
	# Carrega jogador 1
	p1 = player.instance()
	add_child(p1)
	p1.set_global_pos(get_node("PosP1").get_global_pos())
	p1.player = 1
	p1.get_node("Sprite").set_texture(texture1) # Carrega textura
	p1.connect("morreu",p1.get_parent(),"p1morreu")
	
	# Carrega jogador 2
	p2 = player.instance()
	add_child(p2)
	p2.set_global_pos(get_node("PosP2").get_global_pos())
	p2.player = 2
	p2.get_node("Sprite").set_texture(texture2) # Carrega textura
	p2.connect("morreu",p2.get_parent(),"p2morreu")
	
	# Preenche a lateral da tela com muro
	var i = 16
	while i < 800:
		var j = 16
		if (i == 16 or (i >= 784 and i < 800)):
			gera_muro(i,j)
		
		while j < 600:
			if (i == 16 or (i >= 784 and i < 800)):
				gera_muro(i,j)
			
			if (j == 16 or (j >= 584 and j < 600)):
				gera_muro(i,j)
			
			j += 16
		i += 16
	
	set_process(true)

func gera_muro(i,j):
	var wall1 = wall.instance()
	add_child(wall1)
	wall1.set_pos(Vector2(i,j))

func p1morreu():
	p1vivo = false
	
func p2morreu():
	p2vivo = false

func _process(delta):
	
	if p1vivo:
		if p1.movendo and tm1: # Gerar morte p1
			var morte1 = premorte.instance()
			add_child(morte1)
			morte1.set_global_pos(p1.pmorte)
			get_node("T1").start()
			tm1 = false
		print(p1.is_colliding())
	
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
