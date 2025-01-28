extends Button

var disabled_handler


func _ready() -> void:
  self.pressed.connect(on_previous_question_button_pressed)
  MainController.question_changed.connect(on_question_changed)
  MainController.question_revealed.connect(on_question_revealed)
  
  disabled_handler = ButtonDiableHandler.new().initialise(self)
  disabled_handler.update_disabled(
    {
      "is_not_first_question": false,
      "show_question_button_clicked": false
    }
  )
  
func on_question_changed(new_question):
  var is_not_first_question = (new_question.get_number() > 0)
  disabled_handler.update_disabled({ "is_not_first_question": is_not_first_question})
  
func on_previous_question_button_pressed():
  MainController.go_to_previous_question()

func on_question_revealed():
  disabled_handler.update_disabled({ "show_question_button_clicked": true })
