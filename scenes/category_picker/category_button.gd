extends Button

var category
var on_change_category

func _ready() -> void:
  self.pressed.connect(on_category_button_pressed)

func initialise(category_arg, on_change_category_arg):
  category = category_arg
  text = category.title
  on_change_category = on_change_category_arg
  
  return self

func on_category_button_pressed():
  MainController.change_category(category)
  on_change_category.call()
