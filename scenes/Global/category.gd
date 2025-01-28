class_name Category
extends Resource

@export var title: String
@export var questions: Array[Question]

var has_been_opened = false

func get_has_been_opened():
  return has_been_opened

func set_has_been_opened(value):
  has_been_opened = value
