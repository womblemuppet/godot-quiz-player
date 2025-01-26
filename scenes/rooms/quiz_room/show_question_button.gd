extends Button

var fading = false

func _ready() -> void:
  disabled = true
  self.pressed.connect(on_show_question_button_pressed)
  MainController.category_changed.connect(on_category_changed)
  
func _process(delta: float) -> void:
  if !fading:
    return
  
  if get_modulate().a < 0.05:
    fading = false
    set_modulate(Color(1,1,1,0))
  else:
    set_modulate(lerp(get_modulate(), Color(1,1,1,0), delta * 2))

func on_show_question_button_pressed():
  fading = true
  disabled = true
  MainController.question_revealed.emit()
  
func on_category_changed(_new_category):
  disabled = false
  fading = false
  set_modulate(Color(1,1,1,1))
