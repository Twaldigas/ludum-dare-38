extends Node2D

export(String, "axt", "diving mask", "pick", "battering ram") var item
export(int, "invisible", "visible") var visible
export(Texture) var texture
export(Texture) var textire_destroyed
export(String, "", "axt", "pick", "battering ram") var sound

onready var sprite = get_node("ObstacleSprite")
onready var sprite_destroyed = get_node("ObstacleSpriteDestroyed")
onready var static_body = get_node("StaticBody2D")
onready var area2d = get_node("Area2D")
onready var sample = get_node("SamplePlayer")

onready var player =  get_tree().get_root().get_node("World/Player")
onready var label = get_tree().get_root().get_node("World/Text/Label")

func _ready():
	area2d.connect("body_enter", self, "_destroy_if_possible")
	area2d.connect("body_enter", self, "_show_message")
	if(visible == 1):
		sprite.set_texture(texture)
		sprite_destroyed.set_texture(textire_destroyed)
	
func _destroy_if_possible(body):
	if(body.get_name() == player.get_name() and player.get_items().has(item)):
		static_body.queue_free()
		area2d.queue_free()
		sprite.queue_free()
		if(visible == 1):
			sprite_destroyed.set_hidden(false)
		if(sound != null):	
			sample.play(sound, true)
			
func _show_message(body):
	if(body.get_name() == player.get_name()) and player.get_items().has(item) == false:
		label.set_text("You can't go this way, yet.")