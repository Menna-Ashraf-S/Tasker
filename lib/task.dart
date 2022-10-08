import 'package:flutter/material.dart';

class Task {

  int ? id ;
 late String _name ;
  String ? dueDate ;
 late String _date ;
 late int isChecked ;
 
 
 
 String get name => _name ;
 String get date => _date ;

 Task (dynamic obj){
  if (obj['id']!= null){
    id = obj['id'];
  }
  _name = obj['name'];
  _date = obj['date'];
  dueDate = obj['due_date'];
  isChecked = obj['check'];
 }

 Task.fromMap (Map <String , dynamic> data ){
  if (data['id']!= null){
    id = data['id'];
  }
  _name = data['name'];
  _date = data['date'];
  dueDate = data['due_date'];
  isChecked = data['check'];
 }

 Map <String , dynamic> toMap () {
 Map <String , dynamic> Data = { 
  'name' : _name  ,
   'due_date':dueDate ,
    'date': _date ,
    'check' : isChecked,
    };

 if (id != null){
  Data ['id'] = id ;
 }

 return Data ; 
 } 
}