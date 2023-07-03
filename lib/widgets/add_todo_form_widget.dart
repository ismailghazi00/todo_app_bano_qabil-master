import 'package:flutter/material.dart';
import 'package:todo_app/screens/todo_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/models/controller.dart';

class AddTodoForm extends StatefulWidget {
  const AddTodoForm({super.key, this.controller});
  final TodoController? controller;
  @override
  State<AddTodoForm> createState() => _AddTodoFormState();
}

class _AddTodoFormState extends State<AddTodoForm> {
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
  Widget build(BuildContext context) {
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
            style:
                Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 23),
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
            style: Theme.of(context).textTheme.bodyLarge,
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
              hintStyle: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.white.withOpacity(0.87)),
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
            style: Theme.of(context).textTheme.bodyLarge,
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
                hintStyle: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.white.withOpacity(0.87))),
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
                    // userPrortyIncFuncation();
                  },
                  icon: Image.asset("assets/tag.png")),
              Text('$userPriority',
                  style: Theme.of(context).textTheme.bodySmall),
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
                      setState(() async {
                        //we call setState here becaue TodoClass cannot SetStae, thatsway we call setState here
                        widget.controller?.addTodo(userTitle!, userDescription!,
                            userTodoTime!, userPriority, context);
                        await widget.controller
                            ?.setData()
                            .then((value) => setState(() {}));
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
}
