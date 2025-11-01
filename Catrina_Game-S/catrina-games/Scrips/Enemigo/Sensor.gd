extends Area2D

class_name Sen

var target: CollisionShape2D
var Collision = []

var target_distance : 
	get:
		return global_position.distance_to(target.global_position)
var target_direction : 
	get:
		return target.global_position - global_position

func _ready():
	body_entered.connect(store_body)
	body_exited.connect(remove_body)

func store_body(body):
	Collision.append(body)
func remove_body(body):
	Collision.erase(body)
	if Collision.size()== 0:
		target = null
func _physics_process(delta):
	scan()
func scan() -> void:
	if Collision.size() == 0:
		return
	var ClosestB = find_closest_body(Collision)
	if ClosestB != null:
		target = ClosestB
	else: 
		target = null
		
func find_closest_body(bodies : Array) -> CollisionObject2D:
	var ClosestD = 1000
	var closestB = null 
	if bodies.size() ==0:
		target = null
		return
	for body in bodies:
		if body != null:
			var distance = body.global_position.distance_to(global_position)
			if distance < ClosestD:
				ClosestD = distance
				closestB = body
				target = closestB
	return closestB
