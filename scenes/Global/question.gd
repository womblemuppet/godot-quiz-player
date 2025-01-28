class_name Question
extends Resource

@export var title: String
@export var info: String
@export var picture: Texture2D
@export var answer: String
@export var answer_picture: Texture2D

var number

func set_number(n):
  number = n

func get_number():
  return number
