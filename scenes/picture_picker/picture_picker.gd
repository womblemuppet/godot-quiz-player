extends Node2D

signal picture_chosen(new_picture)

var sprite_catalogue = []
var chosen_sprite
var picture_display_scene = preload("res://scenes/picture_picker/picture_display.tscn")
var player_picker


## shouldn't load each time on _ready
func _ready() -> void:
  picture_chosen.connect(on_picture_chosen)
  global_position += Vector2(-890, 0)
  
  for relative_file_path in DirAccess.get_files_at("res://assets/avatars/"):
    if relative_file_path.ends_with(".import"):
      continue
      
    var file_path = "res://assets/avatars/" + relative_file_path
    var asset = load(file_path)
    sprite_catalogue.push_front(asset)
    
  for i in range(sprite_catalogue.size()):
    var sprite = sprite_catalogue[i]
    var new_picture_display = picture_display_scene.instantiate()
    
    new_picture_display.ready.connect( func(): new_picture_display.initialise(self, i) )
    
    new_picture_display.set_texture(sprite)
    var x = 20 + fmod(i, 4.0) * 200
    
    var y
    if i < 4:
      y = 100
    elif i < 8:
      y = 290
    else:
      y = 480

    new_picture_display.position = Vector2(x, y)

    add_child(new_picture_display)
    
func initialise(player_picker_arg):
  player_picker = player_picker_arg

func on_picture_chosen(new_picture_index) -> void:
  chosen_sprite = sprite_catalogue[new_picture_index]
  player_picker.set_chosen_sprite(chosen_sprite)
  player_picker.picture_picker = null
  queue_free()
  
