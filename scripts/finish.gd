extends Node2D


onready var area2d = get_node("Area2D")
onready var player =  get_tree().get_root().get_node("World/Player")
onready var label = get_tree().get_root().get_node("World/Text/Label")
onready var camera_finish = get_tree().get_root().get_node("World/CameraFinish")

func _ready():
	area2d.connect("body_enter", self, "_finish")
	
func _finish(body):
	if(body.get_name() == player.get_name()):
		camera_finish.make_current()
		label.set_text("You escaped from the bottle! Thank you for playing.")
		player.queue_free()
	
