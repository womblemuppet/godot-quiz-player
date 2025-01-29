extends Node2D

signal number_of_players_changed(new_number_of_players)
signal question_changed(new_question)

signal category_changed(new_category)

signal question_revealed

var current_scene_instance

var main_room_scene = preload("res://scenes/rooms/main_room/main_room.tscn")
var quiz_room_scene = preload("res://scenes/rooms/quiz_room/quiz_room.tscn")

var players = []
var current_question = null
var categories = []
var current_category = null

func _ready() -> void:
  load_categories()
  go_to_main_room()
  get_node("/root/InitRoom").queue_free()

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
  
func load_categories():
  for category_filename in DirAccess.get_files_at("res://assets/categories"):
    var category_path = "res://assets/categories/" + category_filename
    var new_category = load(category_path)
    for i in range(new_category.questions.size()):
      var question = new_category.questions[i]
      question.number = i

    categories.push_back(new_category)

  return

func change_question(new_question):
  current_question = new_question
  question_changed.emit(new_question)

func change_category(new_category):
  current_category = new_category
  category_changed.emit(new_category)
  change_question(new_category.questions[0])
  
func mark_category_as_opened(category):
  category.set_has_been_opened(true)

func go_to_next_question():
  if current_question.number > current_category.questions.size():
    assert(false, "calling next question past array limit")
    return
  
  var new_index = current_question.number + 1
  var new_question = current_category.questions[new_index]
  change_question(new_question)
  question_revealed.emit()

func go_to_previous_question():
  if current_question.number < 1:
    assert(false, "calling previous question on 0")
    return
  
  var new_index = current_question.number - 1
  var new_question = current_category.questions[new_index]
  change_question(new_question)
  question_revealed.emit()
 
