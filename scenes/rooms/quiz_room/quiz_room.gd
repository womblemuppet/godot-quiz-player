extends Node

signal answer_revealed

var player_display_scene = preload("res://scenes/rooms/player_display.tscn")
var score_display_scene = preload("res://scenes/rooms/score_display.tscn")

@onready var question_label = $QuestionLabel
@onready var info_label = $InfoColorRect/InfoLabel
@onready var category_label = $CategoryLabel
@onready var player_list_color_rect = $PlayerListColorRect
@onready var previous_question_button = $PreviousQuestionButton
@onready var next_question_button = $NextQuestionButton
@onready var timer_button = $TimerButton
@onready var answer_label = $AnswerColorRect/AnswerLabel

func _ready() -> void:
  MainController.question_changed.connect(on_question_changed)
  MainController.category_changed.connect(on_category_changed)
  self.answer_revealed.connect(on_answer_revealed)
  
  for i in range(MainController.players.size()):
    var player = MainController.players[i]
    
    var new_player_display_position = Vector2(
      player_list_color_rect.get_position().x + i * 275 + 30,
      player_list_color_rect.get_position().y + 60
    )
    
    var new_player_display = player_display_scene.instantiate()
    new_player_display.ready.connect(
      func():
        new_player_display.initialise(new_player_display_position, player, false)
        new_player_display.answer_button.pressed.connect(hit_buzzer)
        new_player_display.set_scale(Vector2(0.75, 0.75))
    )
    
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
  answer_label.visible = false
  answer_label.text = new_question.answer
  question_label.text = new_question.title
  info_label.text = new_question.info

func on_category_changed(new_category):
  category_label.text = new_category.title
  
func hit_buzzer():
  answer_revealed.emit()

func on_answer_revealed():
  answer_label.visible = true
  timer_button.timer.stop()
