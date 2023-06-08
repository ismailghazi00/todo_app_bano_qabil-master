import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/screens/todo_main.dart';

class TodoTileWidget extends StatefulWidget {
  //we have replaced "{super.key}" with "required this.todo"
  //"todo" is a set of data/ a tile data belongs to ToDo(Class) type stored in _todoList
  //basicaly we are saying to the widget to get the required data the title, todoTime etc from a Todo Class, from todo object(set of data/ Tile data)
  //below we have created "Todo todo;" an object or inisilaized the object to use below as todo.title
  TodoTileWidget({required this.todo});
  Todo todo;

  @override
  State<TodoTileWidget> createState() => _TodoTileWidgetState();
}

class _TodoTileWidgetState extends State<TodoTileWidget> {
  //we inisiate the todo
  @override
  Widget build(BuildContext context) {
    // Container _showTodoListTile(Todo todo)
    //we should refrence the Todo (type) todo (verable) in build

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      height: 85,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: const Color(0xff363636),
      ),
      child: Row(
        children: [
          _showChexbox(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 4,
              ),
              Text(widget.todo.title, style: textStyle(16)),
              const SizedBox(
                height: 2,
              ),
              Text(
                widget.todo.description,
                style: textStlSizeColor(15, Colors.grey),
              ),
              Row(
                children: [
                  Text(
                    DateFormat("EEEE, MMM d, yyyy - hh:mm a")
                        .format(widget.todo.todoTime),
                    // we import "intl: ^0.18.1" in pubspec and import "import 'package:intl/intl.dart';" to used this DateFormat Property
                    //more properties are on that site
                    //https://i0.wp.com/www.flutterbeads.com/wp-content/uploads/2022/01/watermark_Datetime1.png?resize=492%2C1024&ssl=1
                    //https://i0.wp.com/www.flutterbeads.com/wp-content/uploads/2022/01/watermark_Datetime_custom2x.png?resize=768%2C530&ssl=1
                    // '${todo.todoTime.day}-${todo.todoTime.month}-${todo.todoTime.year}',------------(the old methord)
                    style: textStlSizeColor(15, Colors.grey),
                  ),
                  const SizedBox(
                    width: 100,
                  ),
                  _showTageContainerWork(),
                  const SizedBox(width: 20),
                  _showTageContainerPraiorty(),
                  const SizedBox(width: 10),
                  _showDeletButton(),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Padding _showTageContainerWork() {
    return Padding(
      padding: const EdgeInsets.only(left: 04, right: 4),
      child: Container(
        height: 22,
        width: 60,
        decoration: BoxDecoration(
            color: const Color(0xffFFCC80),
            borderRadius: BorderRadius.circular(2)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/workicon.png',
            ),
            // const SizedBox(
            //   width: 1,
            // ),
            Text(
              'Work',
              style: textStyle(11),
            )
          ],
        ),
      ),
    );
  }

  Widget _showDeletButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 04, right: 4),
      child: IconButton(
          onPressed: () {}, icon: Image.asset("assets/deleticon.png")),
      //we can not creat a List Remove funcation here because this STL/UI/DartFile/Class can not recgnize the list _todoList
      //and all of over data is stored in it
      //so we have created an funcation in todo_main_ui file and call the funcation here, funcation is recognized all over
    );
  }

  Padding _showChexbox() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Checkbox(
        value: widget.todo.isCompleted,
        onChanged: (bool? value) {
          setState(() {
            widget.todo.isCompleted = value;
          });
        },
        shape: const CircleBorder(),
        splashRadius: 20,
        checkColor: Colors.white,
        activeColor: const Color(0xff8687E7),
        side: const BorderSide(
          color: Colors.white,
          width: 1.5,
        ),
      ),
    );
  }

  Padding _showTageContainerPraiorty() {
    return Padding(
      padding: const EdgeInsets.only(left: 04, right: 4),
      child: Container(
        height: 22,
        width: 40,
        decoration: BoxDecoration(
          color: const Color(0xff363636),
          border: Border.all(color: const Color(0xff8687E7), width: 1),
          borderRadius: BorderRadius.circular(2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/flagicon.png',
            ),
            Text(
              '3',
              style: textStyle(11),
            )
          ],
        ),
      ),
    );
  }
}
