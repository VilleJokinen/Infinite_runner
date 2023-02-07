extends "res://ui/OverlayScreen.gd"


func _ready():
	# warning-ignore: return_value_discarded
	ScoreEvents.connect("score_changed", self, "_on_ScoreEvents_score_changed")


func _on_ScoreEvents_score_changed():
	$ScoreLabel.text = "Score: %d" % ScoreEvents.score_total
