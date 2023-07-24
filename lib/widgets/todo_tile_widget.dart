import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/models/todo_class.dart';

class TodoTileWidget extends StatefulWidget {
  //we have replaced "{super.key}" with "required this.todo"
  //"todo" is a set of data/ a tile data belongs to ToDo(Class) type stored in _todoList
  //basicaly we are saying to the widget to get the required data the title, todoTime etc from a Todo Class, from todo object(set of data/ Tile data)
  //below we have created "Todo todo;" an object or inisilaized the object to use below as todo.title
  TodoTileWidget({super.key, required this.todo, this.deleteTodo});
  Todo todo;
  final Function? deleteTodo;

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
                Text(widget.todo.title,
                    style: Theme.of(context).textTheme.bodyMedium),
                Text(
                  widget.todo.description,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.grey),
                ),
                Text(
                  styleDateandTime(widget.todo.todoTime),
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.grey),
                ),
              ]),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            const SizedBox(width: 30),
            widget.todo.tag == "work" ? workTage() : Container(),
            widget.todo.tag == "personal" ? personalTage() : Container(),
            widget.todo.tag == "health" ? helthTag() : Container(),
            widget.todo.tag == "study" ? studyTag() : Container(),
            // studyTag(),
            const SizedBox(width: 10),
            _showTageContainerPraiorty()
          ]),
          const Spacer(),
          //if there is todo image in object it will show the image other wise wont show any thing/ show empty continer
          widget.todo.todoimage != null
              ? CircleAvatar(
                  backgroundImage: FileImage(widget.todo.todoimage!),
                  radius: 35)
              : Container(),

          // CircleAvatar(
          //     backgroundImage: widget.todo.todoimage == null
          //         ? null
          //         : FileImage(widget.todo.todoimage!),
          //     backgroundColor: Theme.of(context).colorScheme.primary,
          //     radius: 35),
          const Spacer(),
          _showDeletButton(),
        ],
      ),
    );
  }

  Padding workTage() {
    return Padding(
      padding: const EdgeInsets.only(left: 04, right: 4),
      child: Container(
        height: 20,
        width: 60,
        decoration: BoxDecoration(
            color: const Color(0xffFFCC80),
            borderRadius: BorderRadius.circular(2)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.work_outline,
              color: Colors.black,
              size: 20,
            ),
            Text('Work',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Colors.black))
          ],
        ),
      ),
    );
  }

  Padding personalTage() {
    return Padding(
      padding: const EdgeInsets.only(left: 04, right: 4),
      child: Container(
        height: 20,
        width: 70,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 0, 110, 42),
            borderRadius: BorderRadius.circular(2)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.person, size: 20),
            Text('Personal', style: Theme.of(context).textTheme.bodySmall)
          ],
        ),
      ),
    );
  }

  Padding helthTag() {
    return Padding(
      padding: const EdgeInsets.only(left: 04, right: 4),
      child: Container(
        height: 20,
        width: 60,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 116, 0, 6),
            borderRadius: BorderRadius.circular(2)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.health_and_safety, size: 20),
            Text('Health', style: Theme.of(context).textTheme.bodySmall)
          ],
        ),
      ),
    );
  }

  Padding studyTag() {
    return Padding(
      padding: const EdgeInsets.only(left: 04, right: 4),
      child: Container(
        height: 20,
        width: 60,
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 7, 0, 100),
            borderRadius: BorderRadius.circular(2)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.school_outlined, size: 20),
            Text('Study', style: Theme.of(context).textTheme.bodySmall)
          ],
        ),
      ),
    );
  }

//--------------------------------------------------------------------------
  Widget _showDeletButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 04, right: 4),
      child: IconButton(
          onPressed: () {
            widget.deleteTodo!();
          },
          icon: Image.asset(
            "assets/deleticon.png",
            height: 20,
          )),
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
        height: 20,
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
              "${widget.todo.priority}",
              style: Theme.of(context).textTheme.bodySmall,
            )
          ],
        ),
      ),
    );
  }

  String styleDateandTime(value) {
    return DateFormat("EEEE, MMM d, yyyy - hh:mm a").format(value);
    // we import "intl: ^0.18.1" in pubspec and import "import 'package:intl/intl.dart';" to used this DateFormat Property
    //more properties are on that site
    //https://i0.wp.com/www.flutterbeads.com/wp-content/uploads/2022/01/watermark_Datetime1.png?resize=492%2C1024&ssl=1
    //https://i0.wp.com/www.flutterbeads.com/wp-content/uploads/2022/01/watermark_Datetime_custom2x.png?resize=768%2C530&ssl=1
    // '${todo.todoTime.day}-${todo.todoTime.month}-${todo.todoTime.year}',------------(the old methord)
  }
}
