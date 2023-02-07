extends Spatial

export var score_value: int = 1

func _on_JumpDetector_body_exited(body):
	if body is Player and score_value > 0:
		ScoreEvents.obstacle_passed(score_value)
