extends Node2D

var player

var player_color_rect
var name_label

func _ready() -> void:
  name_label = $NameLabel
  player_color_rect = $PlayerColorRect
  
  name_label.text = player.get_player_name()
  player_color_rect.color = player.get_color()
  

func initialise(position_arg, player_arg):
  set_as_top_level(true)
  set_position(position_arg)
  player = player_arg
  return self
  
