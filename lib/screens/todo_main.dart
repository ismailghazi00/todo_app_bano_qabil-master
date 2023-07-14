import 'package:flutter/material.dart';
import 'package:todo_app/widgets/todo_tile_widget.dart';
import 'package:todo_app/screens/todo_empty_ui.dart';
import 'package:todo_app/models/controller.dart';
import 'package:todo_app/models/todo_class.dart';
import 'package:todo_app/widgets/bottom_sheet_widget.dart';

import '../widgets/add_todo_form_widget.dart';
import '../widgets/drawer.dart';
import '../widgets/serch_text_field.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  TodoController controller = TodoController();
  final GlobalKey<ScaffoldState> _key = GlobalKey();

//Class Name---objectName---Contrecter of Claass (we have to write this line)
//this is how we access the TodoController's Funcations/Lists etc
//we will just put the name of object befor the Func/List etc. to use Class's funcations etc like contrller.addTodo controller.todoList and put setstate wehere need

  @override
  void initState() {
    setState(() {
      controller.getData().then((value) => setState(() {}));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key, // Assign the key to Scaffold. use to assign drawer tothe buton
      backgroundColor: Colors.black,
      appBar: _showAppBar(),
      //instade of AppBar Hole coed we can only return the funcation
      //and put all the coed down from scaffold in  a funcation  to organizeover code
      drawer: const Drawer(child: DrawerWidget()),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              //ShowModalBottomSheet is a widget that will apear by pressed on flotting button
              //this widget is shown in half of screen
              //its required Context: Context
              //its also require builder: (Context) to buld w widget in the sheet
              //we have returened the prebult _ShowTodoAddForm
              context: context,
              builder: (context) {
                return AddTodoForm(controller: controller);
              },
              isScrollControlled: true, //to make BottomSheeet Scrollable
            ).then((value) => setState(() {}));
            //after performing the funcation set state in that page/screen also
            //because adding a Todo wont reflict in this page wo we need to set State in this page to
          },
          child: const Icon(Icons.add, size: 30, color: Colors.white)),
//the floating action button funcation is down  below with all  its propirties
//we can put thi sbutton any where but there it will align at right botom
      body: controller.todoList.isEmpty
          ? const TodoEmptyScreenWidget()
          //a pre-buld body widget
          :
          //new Center(child: condition == true ? new Container() : new Container())
          // if list is empty show Empty home screen funcation wich have all the body other vise show below one
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Column(
                children: [
                  SerchTextField(controller: controller ),
                  //as this need controller.SerchedList so we have to give it contrller in peramater
                  const SizedBox(
                    height: 20,
                  ),
                  //we use sized box Instade ofPadding
                  Expanded(
                    //Expande will use all the rmaing space, if we rape a widget with expaned the wiget (text/Container)  will expanded
                    //its is some thing like Flexcibel make the eidget flexcebale we can also use propert flex for both
                    child: ListView.builder(
                      itemBuilder: ((context, index) {
                        //"listViewBuilder" is widget to creat aq list view
                        //"itemBuilder" is required for "listViewBuilder" and it will build a wdiget for list view
                        //"itemBuilder" is required a funcation (Context, int/Index)
                        //context and Index is posation of the reurned widget, context is for the App and index is for us
                        //Indux is a posation number of the widget
                        //"itemBuilder" required a wediget and "itemCount" limits the lenght of the list
//------------------------------------------------------------------------------
                        Todo showedActiveTodo = controller.searchedTodoList !=
                                null //if serched llist is null/empty
                            //showedActiveTodo is a todo data set curently showing at screen and it is type of ToDo
                            ? controller.searchedTodoList![
                                index] //show the searchedTodoList[Index] in TodoTileWidget
                            : controller.todoList[
                                index]; //other vise show _todoList[Index] all todos in todoTileWidget
                        return TodoTileWidget(
                            //as we define TodoTileWidget required the Todo object (setof Data) todo and a funcation deleteTodo
                            todo: showedActiveTodo,
                            //as we have fineded that todo is object (set of data) in the TodoTileWidget Class
                            //to show the widget its need data and data is in this class in _todoList
                            //here we define that get todo data to show in widget from ShowedAciveTodo
                            //where showedActiveData is hole list or just sreched list defined just below
                            deleteTodo: () {
                              setState(() {
                                controller.todoList.removeAt(index);
                                controller.setData();
                                //to setData acording remove
                              });
                            });
                        //TodoTileWidget ia an STF class, in this class required the ToDo(Class) object (set of Data) todo
                        //and as now we have to show both the data in TodoTileWidget (Basicaly this is a tile) so if we are serching this will show Item and if serch is empty it will show previous data the todo object data
                      }),
                      itemCount: controller.searchedTodoList != null
                          ? controller.searchedTodoList!.length
                          : controller.todoList.length,
                      //we changed the auto buld tile count by list lenght, by we will creat tiles as per list lenth.
//------------------------------------------------------------------------------
                    ),
                  ),
                ],
              ),
            ),
    );
  }

////The Code Behaind the Screen///

  //App Bar Funcation
//
  AppBar _showAppBar() {
    //-------------------------------------------AppBarCoed
    return AppBar(
      leading: Padding(
          //we use leading for widget at right on Appbar
          padding: const EdgeInsets.only(left: 20),
          child: InkWell(
            //image at ritght now works as the Drawer Button
            onTap: () => _key.currentState!.openDrawer(),
            child: Image.asset("assets/sort.png"),
          )),
      title: const Text(
        'Todo',
      ),
      //Title Text Style, background color is listed in theme data
      actions: [
        //we use Actions to show 'A List of Widget' on left in Appbar
        //it by dfeult acept list type
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Image.asset(
            "assets/user.png",
            height: 42,
            width: 42,
          ),
        )
      ],
    );
  }

  Padding _showTageContainerHome() {
    return Padding(
      padding: const EdgeInsets.only(left: 04, right: 4),
      child: Container(
        height: 22,
        width: 60,
        decoration: BoxDecoration(
            color: const Color(0xffFF8080),
            borderRadius: BorderRadius.circular(2)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/homeicon.png',
            ),
            // const SizedBox(
            //   width: 1,
            // ),
            Text(
              'Home',
              style: Theme.of(context).textTheme.bodySmall,
            )
          ],
        ),
      ),
    );
  }
}
