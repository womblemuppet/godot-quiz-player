extends Button

var disabled_handler


func _ready() -> void:
  self.pressed.connect(on_next_question_button_pressed)
  MainController.question_changed.connect(on_question_changed)
  MainController.question_revealed.connect(on_question_revealed)
  
  disabled_handler = ButtonDiableHandler.new().initialise(self)
  disabled_handler.update_disabled(
    {
      "is_not_last_question": true,
      "show_question_button_clicked": false
    }
  )
  
func on_question_changed(new_question):
  var is_not_last_question = (new_question.get_number() < MainController.current_category.questions.size() - 1)
  disabled_handler.update_disabled({ "is_not_last_question": is_not_last_question})
  
func on_next_question_button_pressed():
  MainController.go_to_next_question()
  
func on_question_revealed():
  disabled_handler.update_disabled({ "show_question_button_clicked": true })
