extends CharacterBody2D

signal saludcambio
var gravity = 15
var walk_left = true
var speed = 32
var Stop = false
var Dead = false

@onready var anima = $Chaman
@onready var Spri = $Chama
@onready var Coll = $"Collision Cha"
@export var player: CharacterBody2D

func _physics_process(_delta):
	if Dead == true: 
		return

	if Vida.SeñalC == true:
		anima.play("Hurt")
		var timer : Timer = Timer.new()
		add_child(timer)
		timer.one_shot = true
		timer.autostart = false
		timer.wait_time = 1.5
		timer.timeout.connect(func(): Vida.SeñalC = false)
		timer.start()
	else:
		if Vida.Chaman <= 0:
				anima.play("Death")
				Dead = true
		else:
			Atacar()
			Daño()
			Caminar()
			Turn() 
	
	
func Atacar():
	Stop = false
	
	if $"Izquierda".is_colliding():
			Stop = true
			anima.play("Atacar")
			$"Hit".scale.x = 1
			Spri.flip_h = false
	else:
		if $"Derecha".is_colliding():
			Stop = true
			$"Hit".scale.x = -1
			anima.play("Atacar")
			Spri.flip_h = true
#Daño a jugador
func Daño():
	if $"Hit".is_colliding():
		player.Live = -1
		saludcambio.emit()

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
func Turn():
	if not $Camino.is_colliding():
		walk_left = !walk_left
		scale.x = -scale.x
func _on_AnimatedSprite_frame_change():
	if anima.animation == "Death":
		Dead = true
func _on_AnimatedSprite_animation_finished():
	if anima.animation == "Death":
		Spri.visible = false


	
