extends TextureRect

var is_revealing = false
var fade = 0

func _ready() -> void:
  MainController.question_revealed.connect(on_question_revealed)
  
  set_modulate(Color(1, 1, 1, fade))
  
func reset():
  fade = 0
  set_modulate(Color(1, 1, 1, fade))

func on_question_revealed():
  is_revealing = true
  reset()

func _process(delta: float) -> void:
  ## again, there is probably a better way of doing this.
  
  if is_revealing && fade < 1:
    fade += 0.01
    if fade > 1:
      fade = 1
      is_revealing = false
      
    set_modulate(Color(1, 1, 1, fade))
