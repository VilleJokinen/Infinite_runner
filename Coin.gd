extends Area

export var score_value: int = 1
var rotation_speed: float = 300.0 * rand_range(0.8, 1.2)

onready var coin_mesh: MeshInstance = $MeshInstance

func _process(delta):
	coin_mesh.rotation_degrees.y += rotation_speed * delta
	coin_mesh.rotation_degrees.x += (0.2 * rotation_speed + rand_range(0.2, 0.5) * rotation_speed) * delta


func _on_Coin_body_entered(body):
	if body is Player and score_value > 0:
		ScoreEvents.coin_collected(score_value)
		queue_free()
