extends Button

func _ready() -> void:
  self.pressed.connect(on_pressed)
  MainController.category_picker_opening.connect(on_category_picker_opening)
  MainController.category_picker_closing.connect(on_category_picker_closing)
  
func on_category_picker_opening():
  disabled = true
  
func on_category_picker_closing():
  disabled = false
  
func on_pressed():
  MainController.show_category_picker()
