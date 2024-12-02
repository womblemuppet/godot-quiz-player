extends Node

var add_button
var color_button
var name_text_edit
var player_display_scene = preload("res://scenes/rooms/player_display.tscn")

func _ready() -> void:
  add_button = $AddButton
  color_button = $ColorButton
  name_text_edit = $NameTextEdit
  
  add_button.pressed.connect(on_add_button_pressed)
  
  name_text_edit.text_changed.connect(check_form_validity)
  
  check_form_validity()
  
  
func check_form_validity():
  add_button.disabled = (name_text_edit.text == "")

func on_add_button_pressed():
  var player_name = name_text_edit.text
  var color = color_button.get_color()
  
  var player_data = {
    "name": player_name,
    "color": color
  }
  
  var new_player = MainController.add_player(player_data)
  
  var new_player_width = DisplayServer.window_get_size().x * 0.8
  var new_player_height = DisplayServer.window_get_size().y * 0.15 + (MainController.players.size() - 1) * 320
  
  var new_player_position = Vector2(new_player_width, new_player_height)
  var new_player_display = player_display_scene.instantiate()
  new_player_display.ready.connect(
    func(): new_player_display.initialise(new_player_position, new_player, true)
  )
  
  add_child(new_player_display)
  
  reset_player_picker()

func reset_player_picker():
  name_text_edit.text = ""
  color_button.reset_color()
  check_form_validity()
  
