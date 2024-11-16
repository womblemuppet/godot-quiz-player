extends Node2D

var player
var score_label
var color_rect
var increment_score_button
var deincrement_score_button

func _ready() -> void:
  score_label = $ScoreLabel
  color_rect = $ColorRect
  increment_score_button = $IncrementScoreButton
  deincrement_score_button = $DeincrementScoreButton
  increment_score_button.pressed.connect(increment_score)
  deincrement_score_button.pressed.connect(deincrement_score)
  MainController.category_picker_opening.connect(on_category_picker_opening)
  MainController.category_picker_closing.connect(on_category_picker_closing)
  
func initialise(position_arg, player_arg):
  set_as_top_level(true)
  set_position(position_arg)
  
  player = player_arg
  color_rect.color = player.color.lerp(Color.BLACK, 0.2)
  
  var new_button_style_box = StyleBoxFlat.new()
  new_button_style_box.bg_color = player.color.lerp(Color.BLACK, 0.5)
  increment_score_button.add_theme_stylebox_override("normal", new_button_style_box)
  deincrement_score_button.add_theme_stylebox_override("normal", new_button_style_box)
  
  return self

func increment_score():
  var new_score = player.add_to_score(1)
  score_label.text = str(new_score)
  
func deincrement_score():
  var new_score = player.add_to_score(-1)
  score_label.text = str(new_score)
  
func on_category_picker_opening():
  increment_score_button.disabled = true
  deincrement_score_button.disabled = true
  
func on_category_picker_closing():
  increment_score_button.disabled = false
  deincrement_score_button.disabled = false
  
  
