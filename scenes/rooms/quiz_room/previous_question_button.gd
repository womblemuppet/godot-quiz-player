extends Button

func _ready() -> void:
  disabled = true
  self.pressed.connect(on_previous_question_button_pressed)
  MainController.question_changed.connect(on_question_changed)
  
func on_question_changed(new_question):
  disabled = (new_question.get_number() < 1)
  
func on_previous_question_button_pressed():
  MainController.go_to_previous_question()
