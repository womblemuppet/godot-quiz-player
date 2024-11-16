extends CanvasLayer

var category_button_scene = preload("res://scenes/category_picker/category_button.tscn")
@onready var left_panel_controller = $LeftPanelContainer
@onready var right_panel_controller = $RightPanelContainer
@onready var close_button = $CloseButton

func _ready() -> void:
  close_button.pressed.connect(on_close_button_pressed)
  
  for i in range(MainController.categories.size()):
    var category = MainController.categories[i]
    var new_category_button = category_button_scene.instantiate().initialise(category)
    
    var new_category_button_x
    if (i % 2 == 0):
      new_category_button_x = left_panel_controller.position.x + 50
    else:
      new_category_button_x = right_panel_controller.position.x
    var new_category_button_y = left_panel_controller.position.y + 20 + floor(i / 2.0) * 250
        
    new_category_button.position = Vector2(new_category_button_x, new_category_button_y)
    add_child(new_category_button)

func on_close_button_pressed():
  MainController.hide_category_picker()
