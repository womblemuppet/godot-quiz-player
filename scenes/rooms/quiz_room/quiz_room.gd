extends Node

var player_display_scene = preload("res://scenes/rooms/player_display.tscn")
var score_display_scene = preload("res://scenes/rooms/score_display.tscn")

var question_label
var info_label
var category_label
var player_list_color_rect

func _ready() -> void:
  question_label = $QuestionLabel
  info_label = $"./InfoColorRect/InfoLabel"
  category_label = $CategoryLabel

  player_list_color_rect = $PlayerListColorRect
  
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

  change_question_title_text(MainController.current_question.data().title)
  change_question_info_text(MainController.current_question.data().info)
  change_category_text(MainController.current_category.data().title)
    
func change_question_title_text(text):
  question_label.text = text
  
func change_category_text(text):
  category_label.text = text
  
func change_question_info_text(text):
  info_label.text = text
