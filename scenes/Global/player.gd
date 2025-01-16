class_name Player
extends Node

var player_name
var color
var score = 0
var sprite = null

func initialise(player_data):
  player_name = player_data.name
  color = player_data.color
  sprite = player_data.sprite
  
  return self

func add_to_score(amount):
  score += amount
  
  return score
