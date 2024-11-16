class_name Category
extends Node

var title

func initialise(category_data):
  title = category_data.title
  return self
  
func data():
  return {
    "title": title
  }
  
