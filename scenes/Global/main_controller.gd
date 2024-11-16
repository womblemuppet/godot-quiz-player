extends Node2D

signal number_of_players_changed(new_number_of_players)

var current_scene_instance

var main_room_scene = preload("res://scenes/rooms/main_room/main_room.tscn")
var quiz_room_scene = preload("res://scenes/rooms/quiz_room/quiz_room.tscn")
var questions_resource = preload("res://assets/questions.tres")
var categories_resource = preload("res://assets/categories.tres")

var players = []
var questions = []
var current_question = null
var categories = []
var current_category = null

func _ready() -> void:
  load_questions()
  load_categories()
  go_to_main_room()
  get_node("/root/InitRoom").queue_free()
  current_question = questions[0]
  current_category = categories[0]

func change_room(new_scene):
  if current_scene_instance:
    current_scene_instance.queue_free()

  current_scene_instance = new_scene.instantiate()
  add_child(current_scene_instance)

func go_to_main_room():
  change_room(main_room_scene)
  
func go_to_quiz_room():
  change_room(quiz_room_scene)

func add_player(player_data):
  var new_player = Player.new().initialise(player_data)
  add_child(new_player)
  players.push_back(new_player)
  
  number_of_players_changed.emit(players.size())

  return new_player
  
func load_questions():
  for question_data in questions_resource.data:
    var new_question = Question.new().initialise(question_data)
    add_child(new_question)
    questions.append(new_question)
  
func load_categories():
  for category_data in categories_resource.data:
    var new_category = Category.new().initialise(category_data)
    add_child(new_category)
    categories.append(new_category)
