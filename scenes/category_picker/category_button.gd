extends Button

var category

func _ready() -> void:
  self.pressed.connect(on_category_button_pressed)

func initialise(category_arg):
  category = category_arg
  text = category.title
  
  return self

func on_category_button_pressed():
  MainController.change_category(category)
  MainController.hide_category_picker()
