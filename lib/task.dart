import 'package:flutter/material.dart';

class Task {

  int ? id ;
 late String _name ;
 late String _dueDate ;
 late String _date ;
 
 
 
 String get name => _name ;
 String get dueDate => _dueDate ;
 String get date => _date ;

 Task (dynamic obj){
  if (obj['id']!= null){
    id = obj['id'];
  }
  _name = obj['name'];
  _date = obj['date'];
  _dueDate = obj['due_date'];
 }

 Task.fromMap (Map <String , dynamic> data ){
  if (data['id']!= null){
    id = data['id'];
  }
  _name = data['name'];
  _date = data['date'];
  _dueDate = data['due_date'];
 }

 Map <String , dynamic> toMap () {
 Map <String , dynamic> Data = { 'name' : _name  , 'due_date':_dueDate , 'data': _date};
 if (id != null){
  Data ['id'] = id ;
 }

 return Data ; 
 } 
}