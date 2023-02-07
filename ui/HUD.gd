class_name HUD
extends Control

func update():
	$ScoreLabel.text = "Score: %d" % ScoreEvents.score_total
	$CoinsLabel.text = "Coins: %d" % ScoreEvents.coin_total
	$ObstaclesLabel.text = "Obstacles: %d" % ScoreEvents.obstacle_total
