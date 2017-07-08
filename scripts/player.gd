extends KinematicBody2D

const MAX_SPEED = 150
const MAX_FALL_SPEED = 600
const ACCELERATION = 500
const DECELERATION = 1000
const JUMP_FORCE = 600;
const GRAVITY = 2000;
const MAX_JUMP_COUNT = 1;
const STEP_SIZE = 1

var input_direction = 0
var direction = 0
var speed_x = 0
var speed_y = 0;
var velocity = Vector2()

var jump_count = 0
var is_falling = false

var items = []

onready var animated_sprite = get_node("AnimatedSprite")
onready var sample = get_node("SamplePlayer")

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	
	direction = input_direction
	
	if(Input.is_action_pressed("ui_left")):
		input_direction = -STEP_SIZE
		animated_sprite.set_flip_h(false)
		animated_sprite.set_animation("walking")
	elif(Input.is_action_pressed("ui_right")):
		input_direction = STEP_SIZE
		animated_sprite.set_flip_h(true)
		animated_sprite.set_animation("walking")
	else:
		input_direction = 0
		animated_sprite.set_animation("standing")
		
	if(Input.is_action_pressed("ui_up") and jump_count < MAX_JUMP_COUNT and is_falling == false):
		speed_y = -JUMP_FORCE
		jump_count += 1
		sample.play("Jump5", true)
	
	# MOVEMENT
	if(input_direction == - direction):
		speed_x /= 3
	if(input_direction):
		speed_x += ACCELERATION * delta
	else:
		speed_x -= DECELERATION * delta
	speed_x = clamp(speed_x, 0, MAX_SPEED)
	
	speed_y += GRAVITY * delta
	if(speed_y > MAX_FALL_SPEED):
		speed_y = MAX_FALL_SPEED
	
	velocity.x = speed_x * delta * direction
	velocity.y = speed_y * delta
	var movement_reminder = move(velocity)
	
	if(is_colliding()):
		var normal = get_collision_normal()
		var final_movement = normal.slide(movement_reminder)
		speed_y = normal.slide(Vector2(0, speed_y)).y
	
		move(final_movement)
		
		if(normal == Vector2(0, -1)):
			jump_count = 0
			is_falling = false
	else:
		is_falling = true
	
	if(jump_count > 0):
		animated_sprite.set_animation("jumping")
	
	animated_sprite.play(animated_sprite.get_animation())
	
func add_item(item):
	print(str("add item ", item))
	items.append(item)
	
func get_items():
	return items