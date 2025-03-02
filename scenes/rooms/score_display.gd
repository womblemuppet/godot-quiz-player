extends TextureRect

var player
var button_color
var is_blinking = false
var blink_on = false

@onready var score_label = $ScoreLabel
@onready var blink_timer = $BlinkTimer
@onready var is_blinking_timer = $IsBlinkingTimer
@onready var increment_score_button = $IncrementScoreButton
@onready var deincrement_score_button = $DeincrementScoreButton
@onready var buttons = [
  increment_score_button,
  deincrement_score_button
]

func _ready() -> void:
  increment_score_button.pressed.connect(increment_score)
  deincrement_score_button.pressed.connect(deincrement_score)
  blink_timer.timeout.connect(on_blink_timer_timeout)
  is_blinking_timer.timeout.connect(on_is_blinking_timer_timeout)
  
func initialise(position_arg, player_arg, answer_display_closed_arg):
  set_as_top_level(true)
  set_position(position_arg)
  answer_display_closed_arg.connect(start_blinking)
  
  player = player_arg
  set_self_modulate(player.color.lerp(Color.BLACK, 0.2))
  
  button_color = player.color.lerp(Color.BLACK, 0.3)
  
  for button in buttons:
    button.set_self_modulate(button_color)
  
  var new_button_style_box = StyleBoxFlat.new()
  new_button_style_box.bg_color = Color.SILVER
  new_button_style_box.set_corner_radius_all(8)
  increment_score_button.add_theme_stylebox_override("normal", new_button_style_box)
  deincrement_score_button.add_theme_stylebox_override("normal", new_button_style_box)
  
  
  #var new_button_disabled_style_box = StyleBoxFlat.new()
  #new_button_disabled_style_box.bg_color = Color.BLACK
  #increment_score_button.add_theme_stylebox_override("disabled", new_button_disabled_style_box)
  #deincrement_score_button.add_theme_stylebox_override("disabled", new_button_disabled_style_box)
  
  return self

func increment_score():
  var new_score = player.add_to_score(1)
  score_label.text = str(new_score)
  is_blinking = false
  
func deincrement_score():
  var new_score = player.add_to_score(-1)
  score_label.text = str(new_score)
  is_blinking = false
  
func start_blinking():
  is_blinking = true
  blink_timer.start(0.5)
  is_blinking_timer.start(4)

func on_blink_timer_timeout():
  if !is_blinking:
    blink_on = false
    blink_timer.stop()
  else:
    blink_on = !blink_on
    
  if blink_on:
    for button in buttons:
      button.set_self_modulate(Color.GOLD)
  else:
    for button in buttons:
      button.set_self_modulate(button_color)
  
func on_is_blinking_timer_timeout():
  is_blinking = false
