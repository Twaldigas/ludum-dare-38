extends Node2D

func _ready():
	get_node("Area2D").connect("body_enter", self, "_remove")
	get_node("Label").set_hidden(true)
	
func _remove(body):
	if get_owner().items_collected.has("axt"):
		get_node("Label").set_hidden(true)
		queue_free()
	else:
		get_node("Label").set_hidden(false)