extends Node2D

var player

@onready var player_color_rect = $PlayerColorRect
@onready var name_label = $NameLabel
@onready var answer_button = $AnswerButton

func initialise(position_arg, player_arg, disabled_arg):
  set_as_top_level(true)
  set_position(position_arg)
  player = player_arg
  answer_button.disabled = disabled_arg
  
  name_label.text = player.get_player_name()
  player_color_rect.color = player.get_color()
  
  return self
