extends ColorRect

@onready var show_answer_button = $ShowAnswerButton
@onready var exit_button = $ExitButton
@onready var answer_label = $AnswerLabel
@onready var question_label = $QuestionLabel
@onready var answer_timer_display = $AnswerTimerDisplay

var question
var signal_on_close
var player_display
var player

func _ready() -> void:
  show_answer_button.pressed.connect(on_show_answer_button_pressed)
  exit_button.pressed.connect(on_exit_button_pressed)
  exit_button.disabled = true
  answer_label.visible = false

func initialise(data):
  position = data.position
  question = data.question
  signal_on_close = data.get("signal_on_close")
  player = data.player
  
  question_label.text = question.info
  answer_label.text = question.answer
  
  var player_display_scene = preload("res://scenes/rooms/player_display.tscn")
  player_display = player_display_scene.instantiate()
  
  var new_player_display_options = {
    "position": Vector2(175, 300),
    "player": player,
    "answer_button_clickable": true
  }
  
  player_display.ready.connect( func(): player_display.initialise(new_player_display_options) )
  player_display.z_as_relative = false
  player_display.z_index = 20
  add_child(player_display)
  
func on_show_answer_button_pressed():
  answer_label.visible = true
  show_answer_button.disabled = true
  exit_button.disabled = false
  answer_timer_display.color = Color.PALE_GREEN
  ## could flash exit button here

func on_exit_button_pressed():
  if signal_on_close:
    signal_on_close.emit()
    
  queue_free()
