extends Node2D

var opened = false

var sprite_node_closed
var sprite_node_open
var sample_player

func _ready():
	get_node("Area2D").connect("body_enter", self, "_collect_item")
	
	sprite_node_closed = get_node("SpriteClosed")
	sprite_node_open = get_node("SpriteOpen")
	sample_player = get_node("SamplePlayer")

func _collect_item(body):
	
	if opened == false:
		get_owner().items_collected.append(_get_item())
		opened = true
		sprite_node_closed.set_hidden(true)
		sprite_node_open.set_hidden(false)
		sample_player.play("pick_up", true)
		get_node("Label").set_hidden(false)
		

func _get_item():
	return null