extends Area2D

func _ready():
	pass

func _on_Morte_body_enter( body ): # Detecta colizão com o fogo/veneno/morte
	if body.has_method("morte"):
		body.morte()
