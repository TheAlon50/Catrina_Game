extends CharacterBody2D
class_name Enemy

var gravity = 15
var walk_left = true
var speed = 32
var Hit = false
var Stop = false
var Dead = false


@onready var anima = $Generico
@onready var Spri = $Sprite
@export var player: CharacterBody2D

   

func _physics_process(_delta):
	if Dead == true: 
		return
	if Vida.SeñalG == true:
			anima.play("Hurt")
			var timer : Timer = Timer.new()
			add_child(timer)
			timer.one_shot = true
			timer.autostart = false
			timer.wait_time = 2.2
			timer.timeout.connect(func(): Vida.SeñalG = false)
			timer.start()
	else:
		if Vida.Generico <= 0:
				anima.play("Death")
				Dead = true
		else:
			Atacar()
			Caminar()
			Turn() 


func Atacar():
	Stop = false
	if $"Izquierda".is_colliding():
		Stop = true
		Spri.flip_h = true
		anima.play("Atacar (2)")
		$Fuego.flip_h = true 
	else:
		if $"Derecha".is_colliding():
			Stop = true
			anima.play("Atacar")
func Caminar():
	if (Stop == false):
		if (walk_left):
			velocity.x = speed
			anima.play("Walk")
		else:
			velocity.x = -speed
			anima.play("Walk")
			Spri.flip_h =  false
			
		velocity.y += gravity
		move_and_slide()
	else:
		velocity.x = 0 
	move_and_slide()
	move_and_slide()
func Turn():
	if not $Camino.is_colliding():
		walk_left = !walk_left
		scale.x = -scale.x
func _on_AnimatedSprite_frame_change():
	if anima.animation == "Death":
		Dead = true
func _on_AnimatedSprite_animation_finished():
	if anima.animation == "Death":
		queue_free()
