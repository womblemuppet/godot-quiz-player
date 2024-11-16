extends Node

var loaded_sprites = {}

func _ready():
  for relative_file_path in DirAccess.get_files_at("res://assets/"):
    if !relative_file_path.ends_with(".import"):
      var file_path = "res://assets/" + relative_file_path
      loaded_sprites[file_path] = load(file_path)
