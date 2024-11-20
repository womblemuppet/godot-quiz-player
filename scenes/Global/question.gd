class_name Question
extends Resource

@export var answer: String
@export var hint: String
@export var info: String
@export var picture: String
@export var title: String

var number

func set_number(n):
  number = n

func get_number():
  return number
