class_name ButtonDiableHandler
extends Node2D

var checks = {}
var button

func initialise(button_arg):
  button = button_arg
  return self

func update_disabled(updates):
  checks.merge(updates, true)
  
  print("button: %s" % button)
  print("incoming updates: %s" % updates)
  print("checks: %s" % checks)

  if checks.is_empty():
    button.disabled = false
  else:
    button.disabled = checks.values().any( func(check): return !check )
  
  print("disabled = %s" % button.disabled)
      
