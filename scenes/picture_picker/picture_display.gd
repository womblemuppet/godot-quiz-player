extends Sprite2D

@onready var picture_display_button = $PictureDisplayButton

var picture_picker
var picture_index

func _ready() -> void:
  picture_display_button.mouse_entered.connect(on_mouse_entered)
  picture_display_button.mouse_exited.connect(on_mouse_exited)

func initialise(picture_picker_arg, picture_index_arg):
  picture_picker = picture_picker_arg
  picture_index = picture_index_arg
  picture_display_button.pressed.connect(on_picture_display_button_pressed)
  
func on_picture_display_button_pressed():
  picture_picker.picture_chosen.emit(picture_index)

func on_mouse_entered():
  set_modulate(Color.WHITE.lerp(Color.BLACK, 0.1))
  
func on_mouse_exited():
  set_modulate(Color.WHITE)
