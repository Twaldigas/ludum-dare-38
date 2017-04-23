extends Node2D

func _ready():
	get_node("Area2D").connect("body_enter", self, "_remove")
	
func _remove(body):
	if get_owner().items_collected.has("diving_eyeglasses"):
		get_node("Label").set_hidden(true)
		var position = Vector2(800, 800)
		get_node("StaticBody2D/CollisionShape2D").set_global_pos(position)
	else:
		get_node("Label").set_hidden(false)