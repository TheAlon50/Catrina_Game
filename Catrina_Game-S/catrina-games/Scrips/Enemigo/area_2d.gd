extends Area2D

class_name Detectar

var targe: CollisionObject2D
var Collision = []

var target_distance : 
	get:
		return global_position.distance_to(targe.global_position)
var target_direction : 
	get:
		return targe.global_position - global_position

func _ready():
	body_entered.connect(store_body)
	body_exited.connect(remove_body)

func store_body(body):
	Collision.append(body)
func remove_body(body):
	Collision.erase(body)
	if Collision.size()== 0:
		targe = null
func _physics_process(_delta):
	scan()
func scan() -> void:
	if Collision.size() == 0:
		return
	var ClosestBo = find_closest_body(Collision)
	if ClosestBo != null:
		targe = ClosestBo
	else: 
		targe = null
func find_closest_body(bodies : Array) -> CollisionObject2D:
	var ClosestD = 1000
	var closestBo = null 
	if bodies.size() ==0:
		targe = null
		return
	for body in bodies:
		if body != null:
			var distance = body.global_position.distance_to(global_position)
			if distance < ClosestD:
				ClosestD = distance
				closestBo = body
				targe = closestBo
	return closestBo
