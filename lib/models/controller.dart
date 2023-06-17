import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/models/todo_class.dart';

class TodoController {
  List<Todo> todoList = [];
  //this list will store all the data we are entring through add funcation and return the data by Todo Type object "todo"
  List<Todo>? searchedTodoList;
  //only store thoes todo (object) how contains the serched data
  //we Store Over Logic/ Funcations here its is Good Approcah
  //As these funcation is not recognize able for the class TodoMain so we can creat the object of this class

  void addTodo(String userTitle, String userDescription, DateTime userTodoTime,
      int userPriority, context) {
    // setState(() { as set state is belongs to Stetfull widget so we couldent call it here, we will call set sate where we call these funcations
    todoList.add(Todo(
        title: userTitle,
        description: userDescription,
        todoTime: userTodoTime,
        priority: userPriority));
    //an add funcation can add data to to todolist
//because this class dont recognized Context, thatway we add paremater in Context above
//or we can call this line in where we call _addTodo Funcation
    Navigator.pop(context);
    setData();
    //we have to  pass this funcation here in add todo to add the by pressing on submit
    //we shoul also pass setData() the funcation that sa
  }

  void searchTodo(String searchedKey) {
    //this funcation will take a string searchedKey
    //once we passed this funcation in textFeild's on change tan it will take serchedKey from on change and performe bellow funcation
    if (searchedKey.isEmpty) {
      // setState(() {
      //it will make srechedList null to show all todo tiles if serchedKey is empty or simply we are not typing in it
      searchedTodoList = null;
    } else {
      //else it will prform this funcation
      List<Todo> result = todoList
          //it will get String (What to serch) from serchedKeyand serched by ".where" lokking in title in _todoList and also convert it by ".toList" becaue we have return the list type data
          .where((element) => element.title.contains(searchedKey))
          .toList();
      // setState(() {
      searchedTodoList = result;
      //here the result that we have got from above funcation converted in list will assigned to List<Todo> _searchedTodoList that we have created above
      //and it will latter shown in A TodoTile
      // to do Tile can show both the Serched List and todo-----------------------------------------------------------------
      //because we have assigne this data in on change and in setState it will change on run time and no need to submiet
    }
  }

  List<String> convertTodolistToStringList() {
//because SheredPrefrenceCanOnlySupport int,bool,String, double or Lit<String>
//so we convert Todo Type list (_todoList) to String List
//as we have created this funcation down from to refresh avery time when screen reload

    // Todo List -> Map list -> STring list
    //List<Map<String, dynamic>> mens List of map with  Key of String type and Data of Dynamic type
    List<Map<String, dynamic>> todoInMap =
        //"tojson" is funcation that we creat onilne with help of the site it works as Class Type to Map Conerter
        todoList.map((e) => e.toJson()).toList(); //List<Todo> to List<map>
//"jsonEncode" is pre bultfuncation by dart that we have added in depndancea in pubspec
//its work as converter and convert map to List
    List<String> todoInString = todoInMap
        .map((e) => jsonEncode(e))
        .toList(); //List<map> to List<String>
//this return Statement will work as "todoInStringList"
    return todoInString;
  }

//   .
//   .
  void convertStringListInToTodoList(List<String> todoInString) {
    // STring list -> Map list -> Todo list
    //"jsonDecode" is prebult funcation by dart, added by depandncy
    //the following line will convert String List to map list
    List todoInMap = todoInString
        .map((e) => jsonDecode(e))
        .toList(); //List<String> to List<map>
    //"Todo.fromJson" is an funcation that we have created online with help of web.
    List<Todo> todoInClass = todoInMap
        .map((e) => Todo.fromJson(e))
        .toList(); //List<map> to List<Todo>

    // setState(() {
    //finaly we set that _todoList=TodoInClass (a list we have got from shered prfrfrensec or from local storage)
    todoList = todoInClass;
    //now at first _todoList will not be empty now oncw saved data will be saved in local storgae in form of String List
    //and get that list and convert the list avery time with this function to Class Type Todo List which is redable for the app
  }

//this is the way we est data to SheredPrefrences/save data to local mamory
  Future<void> setData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setStringList('todo_list', convertTodolistToStringList());
  }

//this is the way we Get data form SheredPrefrences/get  data from local mamory
  Future<void> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? todoInString = prefs.getStringList('todo_list');
    convertStringListInToTodoList(todoInString ?? []);
  }
}
