class_name Player
extends Node

var player_name
var color
var score = 0

func initialise(player_data):
  player_name = player_data.name
  color = player_data.color
  
  return self

func get_player_name():
  return player_name

func get_color():
  return color

func get_score():
  return score
  
func add_to_score(amount):
  score += amount
  
  return score
