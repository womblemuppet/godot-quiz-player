extends ColorRect

@onready var timer = $AnswerTimer

func _ready() -> void:
  timer.start(11)
  timer.timeout.connect(stop.bind(false))

func _process(_delta: float) -> void:
  if timer.time_left > 0:
    queue_redraw()

func _draw() -> void:
  var time_left = round(timer.time_left)
  for i in range(time_left):
    var rect = Rect2(5 + i * 30, 7, 20, 60)
    draw_rect(rect, Color.html("#f5dd58"), true)

func stop(is_successful):
  timer.stop()
  
  if is_successful:
    color = Color.PALE_GREEN
  else:
    color = Color.RED
