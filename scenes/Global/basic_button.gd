# implements button_disable_handler for a button without any attached script

extends Button

var disabled_handler

func _ready() -> void:
  print("basic button - initialising handler for %s" % self)
  disabled_handler = ButtonDiableHandler.new().initialise(self)
  print("disabled_handler = %s" % disabled_handler)
