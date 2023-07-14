import 'package:flutter/material.dart';
import 'package:todo_app/screens/todo_main.dart';
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
              decoration: textFieldCustomDecuration('Title')
              //A pre bulid Custom Input Decoratin Style with required peramaetr Hint Text
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
            decoration: textFieldCustomDecuration('Description'),
            //A pre bulid Custom Input Decoratin Style with required peramaetr Hint Text
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
                      //Color Scheem of Date Picker comes form the color scheem we difined in Theme data main.dart
                    );
                    // ignore: use_build_context_synchronously
                    TimeOfDay? timeValue = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                        //Below methoud/coed is to coller up TimePicker
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: const ColorScheme.dark(
                                primary: Color(0xff8687E7),
                                onPrimary: Colors.white,
                                surface: Color(0xff363636),
                                onSurface: Colors.white,
                                secondary: Color(0xff363636),
                                onSecondary: Color(0xff8687E7),
                              ),
                              textButtonTheme: TextButtonThemeData(
                                style: TextButton.styleFrom(
                                  foregroundColor: const Color(0xff8687E7),
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
                        //the Funcation in TodoController Class needs these data to set Data in list specialy Context
                        await widget.controller?.setData();
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

  InputDecoration textFieldCustomDecuration(String hinttext) {
    return InputDecoration(
      //to use border hint text lable and etc we must use Input Decoration class
      border: const OutlineInputBorder(),

      enabledBorder: //to use border property in text field we must insatate the "border: OutlineInputBorder()"
          //the to use propirties now we use proprities in "enabled propirties OutlinInputBorder"
          //this is normal border shows all the time
          const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              borderSide: BorderSide(color: Color(0xff979797), width: 1)),
      //focues border will only show when the curser is focuseed on the text filed
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        borderSide: BorderSide(
          color: Color(0xff979797),
          width: 2,
        ),
      ),
      //this is hint text and below is hint text styling
      hintText: hinttext,
      hintStyle: Theme.of(context)
          .textTheme
          .bodyMedium
          ?.copyWith(color: Colors.white.withOpacity(0.87)),
    );
  }
}
