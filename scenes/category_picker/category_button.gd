extends Button

var category
var on_change_category

func _ready() -> void:
  self.pressed.connect(on_category_button_pressed)
  if category.get_has_been_opened():
    set_modulate(Color.DARK_SLATE_GRAY)

func initialise(category_arg, on_change_category_arg):
  category = category_arg
  text = category.title.to_upper()
  on_change_category = on_change_category_arg
  
  return self

func on_category_button_pressed():
  MainController.change_category(category)
  MainController.mark_category_as_opened(category)
  on_change_category.call()
