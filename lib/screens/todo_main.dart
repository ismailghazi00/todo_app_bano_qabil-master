import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/widgets/todo_tile_widget.dart';
import 'package:todo_app/screens/todo_empty_ui.dart';
import 'package:todo_app/models/controller.dart';
import 'package:todo_app/models/todo_class.dart';
import 'package:todo_app/widgets/bottom_sheet_widget.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  TodoController controller = TodoController();

//Class Name---objectName---Contrecter of Claass (we have to write this line)
//this is how we access the TodoController's Funcations/Lists etc
//we will just put the name of object befor the Func/List etc. to use Class's funcations etc like contrller.addTodo controller.todoList and put setstate wehere need
  String? userTitle, userDescription;
  DateTime? userTodoTime;
  int userPriority = 0;
//the veriables where the user data will temprory stored

  @override
  void initState() {
    setState(() {
      controller.getData();
      //We passed the funcation here to get the data by it self when the app restarts
      //also put this in SetState to set the State at run time
    });
    super.initState();
  }

  void userPrortyIncFuncation() {
    setState(() {
      userPriority++;
      print(userPriority);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _showAppBar(),
      //instade of AppBar Hole coed we can only return the funcation
      //and put all the coed down from scaffold in  a funcation  to organizeover code
      floatingActionButton: BottomSheetWidget(),
      // FloatingActionButton(
      //   onPressed: () {
      //     showModalBottomSheet(
      //         //ShowModalBottomSheet is a widget that will apear by pressed on flotting button
      //         //this widget is shown in half of screen
      //         //its required Context: Context
      //         //its also require builder: (Context) to buld w widget in the sheet
      //         //we have returened the prebult _ShowTodoAddForm
      //         context: context,
      //         builder: (context) {
      //           return _showTodoAddbottomSheet();
      //         },
      //         isScrollControlled: true,
      //         //to make BottomSheeet Scrollable
      //         shape: const RoundedRectangleBorder(
      //             //to give the bottom sheet a shape
      //             //using vertical top broder circullar with value 20 to round ap top adges
      //             borderRadius:
      //                 BorderRadius.vertical(top: Radius.circular(20))),
      //         backgroundColor: const Color(0xff1d1d1d)
      //         //bydeful bottomsheet coloe is white
      //         );
      //   },
      //   backgroundColor: const Color(0xff8687E7),
      //   child: const Icon(
      //     Icons.add,
      //     size: 30,
      //   ),
      // ),
//the floating action button funcation is down  below with all  its propirties
//we can put thi sbutton any where but there it will align at right botom
      body:
          // controller.todoList.isEmpty
          //     ? const TodoEmptyScreenWidget()
          //     //a pre-buld body widget
          //     :
          //new Center(child: condition == true ? new Container() : new Container())
          // if list is empty show Empty home screen funcation wich have all the body other vise show below one
          Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          children: [
            _showSerchTextField(),
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
//---------------------------------------------------------------------------------------
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
//----------------------------------------------------------------------------------------
              ),
            ),
          ],
        ),
      ),
    );
  }

////The Code Behaind the Screen///

//
  //App Bar Funcation
//
  AppBar _showAppBar() {
    return AppBar(
      backgroundColor: Colors.black,
      //when we put background color in AppBar its men Appbars's Background Color
      leading: Padding(
        //we use leading for widget at right on Appbar
        padding: const EdgeInsets.only(left: 20),
        child: Image.asset("assets/sort.png"),
      ),
      title: Text(
        'Todo',
        style: GoogleFonts.lato(
          fontWeight: FontWeight.w400,
          fontSize: 20,
        ),
      ),
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

//
  TextField _showSerchTextField() {
    return TextField(
      onChanged: (value) {
        setState(() {
          controller.searchTodo(value);
          //as serchTodo fncatuin need String value (serched Key), and that value will be obtained from text filed.
          //we wont use SetState in Controler Class sw we use it here
        });
      },
      cursorColor: const Color(0xff979797),
      //Blinking line where we type
      style: GoogleFonts.lato(
        fontWeight: FontWeight.w400,
        fontSize: 16,
        color: const Color(0xffAFAFAF),
      ),
      decoration: InputDecoration(
          fillColor: const Color(0xff1d1d1d),
          filled: true,
          prefixIcon: Padding(
            //the icon show at right in text field
            //we use also suffixIcon to show icon at left
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              "assets/search.png",
              height: 24,
              width: 24,
            ),
          ),
          hintText: "Search for your task...",
          hintStyle: GoogleFonts.lato(
            fontWeight: FontWeight.w400,
            fontSize: 16,
            color: const Color(0xffAFAFAF),
          ),
          border: const OutlineInputBorder(),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff979797)))),
    );
  }

//
//-------------------------------------BottomShet
  Widget _showTodoAddbottomSheet() {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          25, 25, 25, MediaQuery.of(context).viewInsets.bottom),
      //mediaQuery class read/collect/have the device data lenght and width
      // mediaQery.of return this data
      //now we are telling him that to view the bottom insets(adges/the value or where the botom starts) and start gettinh pading from this changed data
      // in short this will start from thechanged bottom
      //it is used when the keborde popups and all the widgets stared after the keborde, for them niw screen starts from keborde top
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        //bydefult column will take all the space avalibale, but its is not good for us this time sio we will give it the above propert to be as minumin as it can
        children: [
          Text(
            'Add Task',
            style: GoogleFonts.lato(
              fontSize: 23,
              color: Colors.white.withOpacity(0.87),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          //Text Field for title
          //
          //
          TextField(
            onChanged: (value) {
              userTitle = value;
            },
            cursorColor: const Color(0xff979797),
            //this style is input text style
            style: GoogleFonts.lato(
                fontSize: 18, fontWeight: FontWeight.w400, color: Colors.white),
            decoration: InputDecoration(
              //to use border hint text lable and etc we must use Input Decoration class
              border: const OutlineInputBorder(),
              //to use border property in text field we must insatate the "border: OutlineInputBorder()"
              //the to use propirties now we use proprities in "enabled propirties OutlinInputBorder"
              //this is normal border shows all the time
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(color: Color(0xff979797), width: 1),
              ),
              //focues border will only show when the curser is focuseed on the text filed
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(
                  color: Color(0xff979797),
                  width: 2,
                ),
              ),
              //this is hint text and below is hint text styling
              hintText: 'Title',
              hintStyle: GoogleFonts.lato(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.white.withOpacity(0.87)),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          //Text Field for Description
          //
          //
          TextField(
            cursorColor: const Color(0xff979797),
            onChanged: (value) {
              userDescription = value;
            },
            //this style is input text style
            style: textStyle(18),
            decoration: InputDecoration(
              //to use border hint text lable and etc we must use Input Decoration class
              border: const OutlineInputBorder(),
              //to use border property in text field we must insatate the "border: OutlineInputBorder()"
              //the to use propirties now we use proprities in "enabled propirties OutlinInputBorder"
              //this is normal border shows all the time
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(color: Color(0xff979797), width: 1),
              ),
              //focues border will only show when the curser is focuseed on the text filed
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                borderSide: BorderSide(
                  color: Color(0xff979797),
                  width: 2,
                ),
              ),
              //this is hint text and below is hint text styling
              hintText: 'Description',
              hintStyle: textStyle(16),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () async {
                    DateTime? datevalue = await showDatePicker(
                      // showDatePicker is an option to salect a time and date
                      //asyns and await is brother and sysetr it will helpe time and date.
                      //await will holde the coed until we salekt full tme
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2025),
                      //Below methoud/coed is to coller up DatePicker
                      builder: (context, child) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: const ColorScheme.light(
                              primary: Color.fromARGB(255, 105, 105, 105),
                              onPrimary: Colors.white,
                              onSurface: Colors.black,
                            ),
                            textButtonTheme: TextButtonThemeData(
                              style: TextButton.styleFrom(
                                foregroundColor: const Color.fromARGB(
                                    255, 105, 105, 105), // button text color
                              ),
                            ),
                          ),
                          child: child!,
                        );
                      },
                    );
                    TimeOfDay? timeValue = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                        //Below methoud/coed is to coller up TimePicker
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: const ColorScheme.light(
                                primary: Color.fromARGB(255, 105, 105, 105),
                                onPrimary: Colors.white,
                                onSurface: Colors.black,
                              ),
                              textButtonTheme: TextButtonThemeData(
                                style: TextButton.styleFrom(
                                  foregroundColor:
                                      const Color.fromARGB(255, 105, 105, 105),
                                ),
                              ),
                            ),
                            child: child!,
                          );
                        });
                    //bay a TimePicker we gaet time vale in TimeOfDay Varibale
                    setState(() {
                      //DateTime can hold both the time and date
                      //but ShowTimePicker can asign its value only to TimeofDay Wich can only hole time
                      userTodoTime = DateTime(datevalue!.year, datevalue.month,
                          datevalue.day, timeValue!.hour, timeValue.minute);
                      //so we have assigne the both values to date verable at once by above methord
                    });
                  },
                  icon: Image.asset("assets/timer.png")),
              const SizedBox(
                width: 15,
              ),
              IconButton(
                  onPressed: () {
                    userPrortyIncFuncation();
                  },
                  icon: Image.asset("assets/tag.png")),
              Text('$userPriority', style: textStyle(12)),
              const SizedBox(
                width: 15,
              ),
              IconButton(
                  onPressed: () {}, icon: Image.asset("assets/flag.png")),
              const Spacer(),
              const SizedBox(
                width: 15,
              ),
              const Spacer(),
              IconButton(
                  onPressed: () {
                    if (userTitle != null &&
                        userDescription != null &&
                        userTodoTime != null) {
                      setState(() {
                        //we call setState here becaue TodoClass cannot SetStae, thatsway we call setState here
                        controller.addTodo(userTitle!, userDescription!,
                            userTodoTime!, userPriority, context);
                        //the Funcation in TodoController Class needs these data to set Data in list specialy Context
                      });
                    }
                  },
                  icon: Image.asset("assets/send.png")),
            ],
          )
        ],
      ),
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
              style: textStyle(11),
            )
          ],
        ),
      ),
    );
  }
}

TextStyle textStyle(double S) {
  return GoogleFonts.lato(
      fontSize: S, fontWeight: FontWeight.w700, color: Colors.white);
}

TextStyle textStlSizeColor(double S, C) {
  return GoogleFonts.lato(fontSize: S, fontWeight: FontWeight.w700, color: C);
}
