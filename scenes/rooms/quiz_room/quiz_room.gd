extends Node

var player_display_scene = preload("res://scenes/rooms/player_display.tscn")
var score_display_scene = preload("res://scenes/rooms/score_display.tscn")

var question_label
var info_label
var category_label
var player_list_color_rect
var previous_question_button
var next_question_button

func _ready() -> void:
  question_label = $QuestionLabel
  info_label = $"./InfoColorRect/InfoLabel"
  category_label = $CategoryLabel

  player_list_color_rect = $PlayerListColorRect
  
  previous_question_button = $PreviousQuestionButton
  next_question_button = $NextQuestionButton
  
  MainController.question_changed.connect(on_question_changed)
  MainController.category_changed.connect(on_category_changed)

  
  for i in range(MainController.players.size()):
    var player = MainController.players[i]
    
    var new_player_display_position = Vector2(
      player_list_color_rect.get_position().x + i * 275 + 30,
      player_list_color_rect.get_position().y + 60
    )
    
    var new_player_display = player_display_scene.instantiate().initialise(
      new_player_display_position,
      player
    )
    new_player_display.set_scale(Vector2(0.75, 0.75))
    add_child(new_player_display)
    
    var new_score_display_position = Vector2(
      player_list_color_rect.get_position().x + i * 275 + 10,
      player_list_color_rect.get_position().y - 50
    )

    var new_score_display = score_display_scene.instantiate()
    new_score_display.ready.connect(
      func(): new_score_display.initialise(new_score_display_position, player)
    )
    
    add_child(new_score_display)

func on_question_changed(new_question):  
  question_label.text = new_question.title
  info_label.text = new_question.title

func on_category_changed(new_category):
  category_label.text = new_category.title
  
