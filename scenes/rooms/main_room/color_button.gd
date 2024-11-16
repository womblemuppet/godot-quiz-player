extends Button

var selected_color_index = 0
var color_rect
var add_button

const SELECTABLE_COLORS = [ 
  Color.RED,
  Color.BLUE,
  Color.GREEN,
  Color.YELLOW,
  Color.AQUA,
  Color.PINK,
]

func _ready() -> void:
  self.pressed.connect(on_color_button_pressed)
  color_rect = $ColorRect
  add_button = $"../AddButton" # ..yup
  print (add_button)
  update_color_rect_color()
  
  
  
func on_color_button_pressed():
  cycle_color()
  
func cycle_color():
  selected_color_index += 1
  if selected_color_index > SELECTABLE_COLORS.size() - 1:
    selected_color_index = 0
  
  update_color_rect_color()
  
  return selected_color_index
  

func update_color_rect_color():
  var new_color = SELECTABLE_COLORS[selected_color_index]
  color_rect.color = new_color
  
  var new_color_faded = new_color.lerp(Color.WHITE, 0.75)
  
  add_button.add_theme_color_override("font_color", new_color_faded)
  add_button.add_theme_color_override("font_hover_color", new_color_faded)
  
func get_color():
  return SELECTABLE_COLORS[selected_color_index]
  
func reset_color():
  selected_color_index = 0
  update_color_rect_color()
