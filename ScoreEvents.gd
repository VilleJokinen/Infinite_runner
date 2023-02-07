extends Node

signal score_changed

var score_total: int = 0
var coin_total: int = 0
var obstacle_total: int = 0


func reset():
	score_total = 0
	coin_total = 0
	obstacle_total = 0


func award_points(score):
	score_total += score
	emit_signal("score_changed")


func coin_collected(score):
	coin_total += 1
	award_points(score)


func obstacle_passed(score):
	obstacle_total += 1
	award_points(score)
