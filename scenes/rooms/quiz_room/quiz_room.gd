extends Node

signal categories_picker_opened
signal categories_picker_closed
signal answer_display_opened
signal answer_display_closed

var player_display_scene = preload("res://scenes/rooms/player_display.tscn")
var score_display_scene = preload("res://scenes/rooms/score_display.tscn")
var category_picker_scene = preload("res://scenes/category_picker/category_picker.tscn")
var category_picker
var answer_display_scene = preload("res://scenes/rooms/answer_display.tscn")
var answer_display

@onready var question_title_label = $QuestionTitleLabel
@onready var question_label = $QuestionColorRect/QuestionLabel
@onready var question_picture_texture_rect = $QuestionColorRect/QuestionPictureTextureRect
@onready var category_label = $CategoryColorRect/CategoryLabel
@onready var player_list_color_rect = $PlayerListColorRect
@onready var previous_question_button = $PreviousQuestionButton
@onready var next_question_button = $NextQuestionButton
@onready var question_timer_display = $QuestionTimerDisplay
@onready var show_question_button = $ShowQuestionButton
@onready var open_categories_button = $OpenCategoriesButton

@onready var buttons = [
  open_categories_button,
  previous_question_button,
  next_question_button,
  show_question_button
]


func _ready() -> void:
  MainController.question_changed.connect(on_question_changed)
  MainController.category_changed.connect(on_category_changed)
  categories_picker_closed.connect(on_categories_picker_closed)
  
  open_categories_button.pressed.connect(create_category_picker)
  
  for i in range(MainController.players.size()):
    var player = MainController.players[i]
    
    var new_score_display_position = Vector2(
      player_list_color_rect.get_position().x + i * 480,
      player_list_color_rect.get_position().y
    )
    create_score_display(player, new_score_display_position)
    
    var new_player_display_position = Vector2(
      player_list_color_rect.get_position().x + i * 480 + 30,
      player_list_color_rect.get_position().y + 10
    )
    create_player_display(player, new_player_display_position)

  setup_buttons()
    

func on_question_changed(new_question):
  question_title_label.text = new_question.title
  question_label.question_text = new_question.info
  question_label.reset()
  question_picture_texture_rect.texture = new_question.picture
  question_picture_texture_rect.reset()

func on_category_changed(new_category):
  category_label.text = new_category.title
  
func create_score_display(player, position_arg):
  var new_score_display = score_display_scene.instantiate()
  new_score_display.ready.connect(
    func():
      new_score_display.initialise(position_arg, player, answer_display_closed)
      buttons.append_array(new_score_display.buttons)
  )

  add_child(new_score_display)
  
func create_player_display(player, position_arg):
  var new_player_display_options = {
    "position": position_arg,
    "player": player,
    "answer_button_clickable": false
  }
  var new_player_display = player_display_scene.instantiate()
  new_player_display.ready.connect(
    func():
      new_player_display.initialise(new_player_display_options)
      new_player_display.answer_button.pressed.connect(hit_buzzer.bind(player))
      buttons.push_back(new_player_display.answer_button)
      new_player_display.set_scale(Vector2(0.75, 0.75))
  )
  
  add_child(new_player_display)
  
func create_category_picker():
  var new_category_picker = category_picker_scene.instantiate()
  new_category_picker.ready.connect(
    func(): new_category_picker.initialise(
      {
        "offset": Vector2(160, 140),
        "signal_on_open": categories_picker_opened,
        "signal_on_close": categories_picker_closed
      }
    )
  )
  
  add_child(new_category_picker)
  category_picker = new_category_picker
  
func setup_buttons():
  for button in buttons:
    button.disabled_handler.update_disabled(
      { 
        "answer_display_is_closed": true,
        "categories_picker_is_closed": true,
        "a_category_has_been_chosen": false
      }
    )
        
    answer_display_opened.connect(
      func():
        button.disabled_handler.update_disabled({ "answer_display_is_closed": false })
    )
    
    answer_display_closed.connect(
      func():
        button.disabled_handler.update_disabled({ "answer_display_is_closed": true })
    )
    
    categories_picker_opened.connect(
      func():
        button.disabled_handler.update_disabled({ "categories_picker_is_closed": false })
    )
    
    categories_picker_closed.connect(
      func():
        button.disabled_handler.update_disabled({ "categories_picker_is_closed": true })
    )
    
    MainController.category_changed.connect(
      func(_new_category):
        button.disabled_handler.update_disabled({ "a_category_has_been_chosen": true })
    )
    
  open_categories_button.disabled_handler.remove_check("a_category_has_been_chosen")

func on_categories_picker_closed():
  category_picker = null
  
func hit_buzzer(player):
  question_timer_display.timer.stop()
  
  answer_display = answer_display_scene.instantiate()
  answer_display.ready.connect(
    func(): answer_display.initialise(
      {
        "position": Vector2(120, 15),
        "signal_on_close": answer_display_closed,
        "question": MainController.current_question,
        "player": player
      }
    )
  )
  add_child(answer_display)
  answer_display_opened.emit()
