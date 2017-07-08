extends Node2D

onready var area2d = get_node("Area2D")

onready var player = get_parent().get_node("Player")
onready var tunnel_exit = get_parent().get_node("TunnelExit")

func _ready():
	area2d.connect("body_enter", self, "_teleport")
	
func _teleport(body):
	if(body.get_name() == player.get_name()):
		player.set_global_pos(tunnel_exit.get_global_pos())