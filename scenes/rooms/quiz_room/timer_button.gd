extends Button

@onready var timer = $Timer

func _ready() -> void:
  MainController.question_changed.connect(on_question_changed)

func _process(_delta: float) -> void:
  # is there a more efficient way of doing this than _process() ?
  if !timer.is_stopped():
    var time_left = round(timer.time_left)
    text = str(time_left) 
    
    if time_left < 5:
      add_theme_color_override("font_color", Color.CRIMSON)
    else:
      add_theme_color_override("font_color", 140863)
    
func on_question_changed(_new_question):
  timer.start(15)
