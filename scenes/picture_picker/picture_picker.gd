extends Node

#signal picture_chosen(new_picture)

var sprite_catalogue = []
var picture_display
var picture_display_scene = preload("res://scenes/picture_picker/picture_display.tscn")


## shouldn't load each time on _ready
func _ready() -> void:
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
    var x = self.position.x + floor(i / 2.0) * 200 + 20
    var y = self.position.y + 20 + (fmod(i, 2) * 200)
    new_picture_display.position = Vector2(x, y)

    add_child(new_picture_display)
