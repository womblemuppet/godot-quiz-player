# implements button_disable_handler for a button without any attached script

extends Button

var disabled_handler

func _ready() -> void:
  disabled_handler = ButtonDiableHandler.new().initialise(self)
