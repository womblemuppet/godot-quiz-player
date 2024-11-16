extends Button

func _ready() -> void:
  self.pressed.connect(on_play_button_pressed)
  MainController.number_of_players_changed.connect(check_validity)
  check_validity(MainController.players.size())
  
func on_play_button_pressed():
  MainController.go_to_quiz_room()
  
func check_validity(number_of_players):
  disabled = (number_of_players < 2)
  
  
