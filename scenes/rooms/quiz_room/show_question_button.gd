extends Button

var fading = false
var disabled_handler

func _ready() -> void:
  self.pressed.connect(on_show_question_button_pressed)
  MainController.category_changed.connect(on_category_changed)
  
  disabled_handler = ButtonDiableHandler.new().initialise(self)
  
func _process(delta: float) -> void:
  if !fading:
    return
  
  if get_modulate().a < 0.05:
    fading = false
    set_modulate(Color(1,1,1,0))
  else:
    set_modulate(lerp(get_modulate(), Color(1,1,1,0), delta * 5))

func on_show_question_button_pressed():
  fading = true
  disabled_handler.update_disabled({ "is_opaque": false })
  MainController.question_revealed.emit()
  
func on_category_changed(_new_category):
  fading = false
  disabled_handler.update_disabled({ "is_opaque": true })
  set_modulate(Color(1,1,1,1))
