extends Node

@onready var add_button = $AddButton
@onready var color_button = $ColorButton
@onready var name_text_edit = $NameTextEdit
@onready var show_picture_picker_button = $PictureButton
@onready var show_picture_picker_sprite_2d = $PictureButton/PictureButtonSprite2D


var player_display_scene = preload("res://scenes/rooms/player_display.tscn")
var picture_picker_scene = preload("res://scenes/picture_picker/picture_picker.tscn")
var picture_picker
var chosen_sprite

func _ready() -> void:
  add_button.pressed.connect(on_add_button_pressed)
  show_picture_picker_button.pressed.connect(on_show_picture_picker_pressed)
  name_text_edit.text_changed.connect(check_form_validity)
  
  check_form_validity()
  
func check_form_validity():
  add_button.disabled = (name_text_edit.text == "")

func on_add_button_pressed():
  var player_name = name_text_edit.text
  var color = color_button.get_color()
  
  var sprite
  if chosen_sprite == null:
    sprite = load("res://assets/avatars/no_av.png")
  else:
    sprite = chosen_sprite
  
  var player_data = {
    "name": player_name,
    "color": color,
    "sprite": sprite
  }
  
  var new_player = MainController.add_player(player_data)
  
  var new_player_width = DisplayServer.window_get_size().x * 0.8
  var new_player_height = DisplayServer.window_get_size().y * 0.15 + (MainController.players.size() - 1) * 320

  var new_player_display = player_display_scene.instantiate()
  var new_player_display_options = {
    "position": Vector2(new_player_width, new_player_height),
    "player": new_player,
    "answer_button_clickable": true
  }
  
  new_player_display.ready.connect(
    func(): new_player_display.initialise(new_player_display_options)
  )
  
  add_child(new_player_display)
  
  reset_player_picker()

func reset_player_picker():
  name_text_edit.text = ""
  color_button.reset_color()
  set_chosen_sprite(null)
  check_form_validity()
  
func on_show_picture_picker_pressed():
  picture_picker = picture_picker_scene.instantiate()
  picture_picker.initialise(self)
  add_child(picture_picker)
  
func set_chosen_sprite(new_chosen_sprite):
  chosen_sprite = new_chosen_sprite
  show_picture_picker_sprite_2d.texture = new_chosen_sprite
