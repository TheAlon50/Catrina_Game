extends CharacterBody2D

var direccion := 0.0
const SPEED = 130.0
const JUMP_VELOCITY = -340.0
var esta_atacando: bool = false
var is_dead: bool = false # Bloquea el control durante el respawn

@onready var anima := $AnimationPlayer
@onready var Sprint := $Sprite2D

func _ready() -> void:
	anima.animation_finished.connect(_on_animation_finished)


func _physics_process(delta: float) -> void:
	if is_dead:
		velocity = Vector2.ZERO
		return

	Sprint.flip_h = direccion < 0 if direccion != 0 else Sprint.flip_h

	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("Saltar") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	direccion = Input.get_axis("Movimiento_Izquierda", "Movimiento_Derecha")
	
	if esta_atacando:
		pass

	elif Input.is_action_just_pressed("atacar"):
		esta_atacando = true
		anima.play("golpear")
		
	else:
		if not is_on_floor():
			if velocity.y > 0:
				anima.play("caida")
			elif velocity.y < 0:
				anima.play("salto")
		else:
			if direccion != 0:
				if Input.is_action_pressed("Saltar"):
					anima.play("salto")
				else:
					anima.play("correr")
			else:
				if Input.is_action_pressed("Saltar"):
					anima.play("salto")
				else:
					anima.play("inactivo")
	
	if direccion:
		velocity.x = direccion * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _on_animation_finished(anim_name: StringName):

	if anim_name == "golpear":
		esta_atacando = false
	elif anim_name == "resopanw":
		is_dead = false
		


func respawn():
	is_dead = true
	global_position = Vector2(27, 214)
	anima.play("resopanw")

	#Liberación automática de seguridad por si la animación no emite signal
	await get_tree().create_timer(0.95).timeout 
	if is_dead:
		is_dead = false
