extends Node2D

export(String, "axt", "diving mask", "pick", "battering ram") var item
var item_given = false

onready var area2d = get_node("Area2D")
onready var sprite_open = get_node("TresureChestOpen")
onready var sprite_closed = get_node("TresureChestClosed")
onready var sample = get_node("SamplePlayer")

onready var player =  get_tree().get_root().get_node("World/Player")
onready var label = get_tree().get_root().get_node("World/Text/Label")

func _ready():
	area2d.connect("body_enter", self, "_give_item_to_player")
	
func _give_item_to_player(body):
	if(body.get_name() == player.get_name() and item_given == false):
		body.add_item(item)
		item_given = true
		sprite_open.set_hidden(false)
		sprite_closed.set_hidden(true)
		label.set_text(str("You got a ", item, "!"))
		sample.play("Pickup_Coin2", true)