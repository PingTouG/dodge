extends Area2D

signal hit

export var speed = 400
var screen_size
#var target = Vector2()


func _ready():
	screen_size = get_viewport_rect().size
	hide()

func _process(delta):
	var ver = Vector2()
#	if position.distance_to(target) > 10:
#		ver = target - position
		
	if Input.is_action_pressed("ui_right"):
		ver.x += 1
	if Input.is_action_pressed("ui_left"):
		ver.x -= 1
	if Input.is_action_pressed("ui_up"):
		ver.y -= 1
	if Input.is_action_pressed("ui_down"):
		ver.y += 1

	if ver.length() > 0:
		ver = ver.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	
	position += ver * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	if ver.x != 0:
		$AnimatedSprite.animation = 'walk'
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = ver.x < 0
	elif ver.y != 0:
		$AnimatedSprite.animation = 'up'
		$AnimatedSprite.flip_v = ver.y > 0
	
	if ver.x < 0:
		$AnimatedSprite.flip_h = true
	else:
		$AnimatedSprite.flip_h = false	


func _on_Player_body_entered(body):
	hide()
	emit_signal('hit')
	$CollisionShape2D.set_deferred("disabled", true)

func start(pos):
	position = pos
#	target = pos
	show()
	$CollisionShape2D.disabled = false

#func _input(event):
#	if event is InputEventScreenTouch and event.pressed:
#		target = event.position
