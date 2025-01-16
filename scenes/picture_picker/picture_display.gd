extends Node

@onready var picture_display_button = $PictureDisplayButton
var picture_picker
var picture_index

func initialise(picture_picker_arg, picture_index_arg):
  picture_picker = picture_picker_arg
  picture_index = picture_index_arg
  picture_display_button.pressed.connect(on_picture_display_button_pressed)
  
func on_picture_display_button_pressed():
  picture_picker.picture_chosen.emit(picture_index)
