extends Area2D

func _ready():
	pass

func _on_Morte_body_enter( body ):
	if body.has_method("morte"):
		body.morte()
