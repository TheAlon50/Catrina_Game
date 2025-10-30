extends CharacterBody2D

var direccion := 0.0
const SPEED = 130.0
const JUMP_VELOCITY = -340.0
var esta_atacando: bool = false

func respawn():
	
	global_position = Vector2(27, 210)
	anima.play("resopanw")

@onready var anima := $AnimationPlayer
@onready var Sprint := $Sprite2D
func _ready() -> void:
	anima.animation_finished.connect(_on_animation_finished)
	
func _physics_process(delta: float) -> void:
	Sprint.flip_h = direccion < 0 if direccion != 0 else Sprint.flip_h

	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("Saltar") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	direccion = Input.get_axis("Movimiento_Izquierda", "Movimiento_Derecha")
	
	if esta_atacando:
		pass
	# 2. Inicio de Ataque
	elif Input.is_action_just_pressed("atacar"):
		esta_atacando = true
		anima.play("golpear")
		
	# 3. Lógica de Movimiento y Salto (Solo si no está atacando)
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
	
