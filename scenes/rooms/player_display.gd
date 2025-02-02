extends Panel

var player
var answer_button_clickable

@onready var name_label = $NameLabel
@onready var answer_button = $AnswerButton
@onready var player_picture = $PlayerPicture

func _ready() -> void:
  answer_button.mouse_entered.connect(on_mouse_entered)
  answer_button.mouse_exited.connect(on_mouse_exited)

func initialise(options):
  set_as_top_level(true)
  set_position(options.position)
  player = options.player
  answer_button_clickable = options.answer_button_clickable
  answer_button.disabled = options.answer_button_clickable
  
  name_label.text = player.player_name
  set_self_modulate(player.color)
  player_picture.texture = player.sprite
  
  return self

func on_mouse_entered():
  set_modulate(Color.WHITE.lerp(Color.BLACK, 0.1))
  
func on_mouse_exited():
  set_modulate(Color.WHITE)
