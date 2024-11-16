class_name Question
extends Node

var answer
var hint
var info
var number
var picture
var title

func initialise(question_data):
  answer = question_data.answer
  hint = question_data.hint
  info = question_data.info
  number = question_data.number
  picture = question_data.picture
  title = question_data.title
  
  return self
  
func data():
  return {
    "answer": answer,
    "hint": hint,
    "info": info,
    "number": number,
    "picture": picture,
    "title": title
  }
  
