import 'package:flutter/material.dart';
import 'package:todo_app/screens/todo_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/models/controller.dart';

class BottomSheetWidget extends StatefulWidget {
  const BottomSheetWidget({super.key});

  @override
  State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  TodoController controller = TodoController();
  String? userTitle, userDescription;
  DateTime? userTodoTime;
  int userPriority = 0;
//the veriables where the user data will temprory stored
  void userPrortyIncFuncation() {
    setState(() {
      userPriority++;
      print(userPriority);
    });
  }

  @override
  void initState() {
    setState(() {
      controller.getData();
      //We passed the funcation here to get the data by it self when the app restarts
      //also put this in SetState to set the State at run time
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
            //ShowModalBottomSheet is a widget that will apear by pressed on flotting button
            //this widget is shown in half of screen
            //its required Context: Context
            //its also require builder: (Context) to buld w widget in the sheet
            //we have returened the prebult _ShowTodoAddForm
            context: context,
            builder: (context) {
              return Padding(
                padding: EdgeInsets.fromLTRB(
                    //----------------------------------------------Use of MediaQuery Class for Kebord popup
                    25,
                    25,
                    25,
                    MediaQuery.of(context).viewInsets.bottom),
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
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                      decoration: InputDecoration(
                        //to use border hint text lable and etc we must use Input Decoration class
                        border: const OutlineInputBorder(),
                        //to use border property in text field we must insatate the "border: OutlineInputBorder()"
                        //the to use propirties now we use proprities in "enabled propirties OutlinInputBorder"
                        //this is normal border shows all the time
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide:
                              BorderSide(color: Color(0xff979797), width: 1),
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
                          borderSide:
                              BorderSide(color: Color(0xff979797), width: 1),
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
                                  // showDatePicker is an option to salek a time and date
                                  //asyns and await is brother and sysetr it will helpe time and date.
                                  //await will holde the coed until we salekt full tme
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2025));
                              TimeOfDay? timeValue = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now());
                              //bay a TimePicker we gaet time vale in TimeOfDay Varibale
                              setState(() {
                                //DateTime can hold both the time and date
                                //but ShowTimePicker can asign its value only to TimeofDay Wich can only hole time
                                userTodoTime = DateTime(
                                    datevalue!.year,
                                    datevalue.month,
                                    datevalue.day,
                                    timeValue!.hour,
                                    timeValue.minute);
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
                            onPressed: () {},
                            icon: Image.asset("assets/flag.png")),
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
                                  controller.addTodo(
                                      userTitle!,
                                      userDescription!,
                                      userTodoTime!,
                                      userPriority,
                                      context);
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
            },
            //---------------------------------------------other bottom sheet fetures
            isScrollControlled: true,
            //to make BottomSheeet Scrollable
            shape: const RoundedRectangleBorder(
                //to give the bottom sheet a shape
                //using vertical top broder circullar with value 20 to round ap top adges
                borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
            backgroundColor: const Color(0xff1d1d1d)
            //bydeful bottomsheet coloe is white
            );
      },
      //-----------------------------------------------------Flotting action button feture
      backgroundColor: const Color(0xff8687E7),
      child: const Icon(
        Icons.add,
        size: 30,
      ),
    );
  }
}
