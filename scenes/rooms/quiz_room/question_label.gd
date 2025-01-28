extends Label

var question_text = ""
var typing = false
var letters_typed = 0

func _ready() -> void:
  MainController.question_revealed.connect(on_question_revealed)

func _process(delta: float) -> void:
  if !typing:
    return
  
  if letters_typed >= question_text.length():
    letters_typed = question_text.length
    typing = false
  else:
    letters_typed += delta * 20
    text = question_text.substr(0, letters_typed)
  
func reset():
  text = ""
  typing = false
  letters_typed = 0

func on_question_revealed():
  reset()
  typing = true
