extends Button

@onready var timer = $Timer
var time_per_question = 15

func _ready() -> void:
  MainController.question_revealed.connect(on_question_revealed)
  MainController.category_changed.connect(on_category_changed)

func _process(_delta: float) -> void:
  # is there a more efficient way of doing this than _process() ?
  if !timer.is_stopped():
    var time_left = round(timer.time_left)
    text = str(time_left) 
    
    if time_left < 5:
      add_theme_color_override("font_color", Color.CRIMSON)
    else:
      add_theme_color_override("font_color", 140863)
      
func reset_timer():
  timer.stop()
  text = str(time_per_question)
    
func on_question_revealed():
  timer.start(time_per_question)

func on_category_changed(_new_category):
  reset_timer()
