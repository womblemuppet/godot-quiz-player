extends Button

func _ready() -> void:
  disabled = true
  self.pressed.connect(on_next_question_button_pressed)
  MainController.question_changed.connect(on_question_changed)
  
func on_question_changed(new_question):
  disabled = (new_question.get_number() >= MainController.current_category.questions.size() - 1)
  
func on_next_question_button_pressed():
  MainController.go_to_next_question()
  
