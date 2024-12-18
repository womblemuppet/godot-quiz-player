extends Node2D

signal number_of_players_changed(new_number_of_players)
signal question_changed(new_question)
signal category_changed(new_category)
signal category_picker_opening
signal category_picker_closing

var current_scene_instance
var category_picker

var main_room_scene = preload("res://scenes/rooms/main_room/main_room.tscn")
var quiz_room_scene = preload("res://scenes/rooms/quiz_room/quiz_room.tscn")
var category_picker_scene = preload("res://scenes/category_picker/category_picker.tscn")

var players = []
var current_question = null
var categories = []
var current_category = null

func _ready() -> void:
  load_categories()
  go_to_main_room()
  create_category_picker()
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

    categories.push_front(new_category)

  return
    
func change_question(new_question):
  current_question = new_question
  question_changed.emit(new_question)

func change_category(new_category):
  current_category = new_category
  category_changed.emit(new_category)
  change_question(new_category.questions[0])
  
func go_to_next_question():
  if current_question.number > current_category.questions.size():
    assert(false, "calling next question past array limit")
    return
  
  var new_index = current_question.number + 1
  var new_question = current_category.questions[new_index]
  change_question(new_question)
  
func go_to_previous_question():
  if current_question.number < 1:
    assert(false, "calling previous question on 0")
    return
  
  var new_index = current_question.number - 1
  var new_question = current_category.questions[new_index]
  change_question(new_question)
    
func create_category_picker():
  var new_category_picker = category_picker_scene.instantiate()
  new_category_picker.offset = Vector2(160, 140)
  add_child(new_category_picker)
  category_picker = new_category_picker
  category_picker.visible = false
  
func show_category_picker():
  category_picker.visible = true
  category_picker_opening.emit()
  
func hide_category_picker():
  category_picker.visible = false
  category_picker_closing.emit()
