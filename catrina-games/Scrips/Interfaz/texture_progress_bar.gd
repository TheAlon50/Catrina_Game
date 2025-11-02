extends TextureProgressBar

@export var player: CharacterBody2D

func _ready():
	if player:  # Asegúrate de que el player no sea null
		# Conecta la señal correctamente
		player.saludcambio.connect(Callable(self, "update_barra"))
	update_barra()  # Inicializa el valor al inicio

func update_barra():
	if player:
		# Actualiza la barra según la vida
		value = player.Live * 100 / player.Max_live
