extends CanvasLayer

var category_button_scene = preload("res://scenes/category_picker/category_button.tscn")
@onready var left_panel_controller = $LeftPanelContainer
@onready var right_panel_controller = $RightPanelContainer
@onready var close_button = $CloseButton

var signal_on_open
var signal_on_close

    
func initialise(options):
  offset = options.offset
  signal_on_open = options.signal_on_open
  signal_on_close = options.signal_on_close
  
  signal_on_open.emit()
  
  close_button.pressed.connect(on_close_button_pressed)
  
  for i in range(MainController.categories.size()):
    var category = MainController.categories[i]
    var new_category_button = category_button_scene.instantiate().initialise(category, close)
    
    var new_category_button_x
    if (i % 2 == 0):
      new_category_button_x = left_panel_controller.position.x + 50
    else:
      new_category_button_x = right_panel_controller.position.x
    var new_category_button_y = left_panel_controller.position.y + 20 + floor(i / 2.0) * 180

    new_category_button.position = Vector2(new_category_button_x, new_category_button_y)
    add_child(new_category_button)

func on_close_button_pressed():
  close()
  
func close():
  signal_on_close.emit()
  queue_free()
