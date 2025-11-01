extends CharacterBody2D
class_name Calavera
@onready var movement : Movement = $"Movimiento" as Movement
@onready var sensor: Detectar = $"Sensor" as Detectar
@onready var anima = $Dorada
@onready var Spri = $Calavera
@onready var Colli = $"Collision Ca"
var  player : CollisionObject2D
var gravity = 0
var Stop =  false 
var dead = false

var Dead = false
func _ready():
	movement.setup(self)
	
func _physics_process(_delta):
	Vida.Señal = false
	if Dead == true: 
		return
	if Vida.Señal == true:
			anima.play("Hurt")
	else:
		if Vida.Dorada <= 0:
				anima.play("Death")
				Dead = true
		else:
			Mover()
			Atacar()
			Daño()
		
func Atacar():
	if not anima.is_playing() or anima.current_animation != "Atacar":
		Stop = false 
		if $"Izquierda".is_colliding():
				Stop = true
				anima.play("Atacar")
				Spri.flip_h = false
		else:
			if $"Derecha".is_colliding():
				Stop = true
				anima.play("Atacar")
				Spri.flip_h = true
				scale.x = -1
func Daño():
	if $"Hit".is_colliding():
		Vida.Live -= 1
func  Mover():
	if Stop == false:
		if sensor.targe != null:
			if sensor.target_distance < 100: 
				movement.move(sensor.target_direction)
		velocity.y = gravity
		move_and_slide()

func _on_AnimatedSprite_frame_change():
	if anima.animation == "Death":
		Dead = true

func _on_AnimatedSprite_animation_finished():
	if anima.animation == "Death":
		queue_free()


	
