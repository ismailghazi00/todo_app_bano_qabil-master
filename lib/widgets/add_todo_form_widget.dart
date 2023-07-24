import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_app/models/controller.dart';

enum TodoTagEnum {
  work,
  personal,
  health,
  study
} //Example of using 'enum' for dropdown Items

class AddTodoForm extends StatefulWidget {
  const AddTodoForm({super.key, this.controller, required this.setTheState});
  final TodoController? controller;
  final Function setTheState;
  @override
  State<AddTodoForm> createState() => _AddTodoFormState();
}

class _AddTodoFormState extends State<AddTodoForm> {
  String? userTitle, userDescription;
  File? usertodoimage;
  DateTime? userTodoTime;
  int userPriority = 0;
  String? userTag;
  //the veriables where the user data will temprory stored before we assigned these values to class

  List<String> TodoTagList = [
    'work',
    'personal',
    'health',
    'study'
  ]; //Example of using 'List' for dropdown Items
  TodoTagEnum? todoTagEnum; //initilizinf the enum that we have created above
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
                    userPrortyIncFuncation();
                  },
                  icon: Image.asset("assets/tag.png")),
              Text('$userPriority',
                  style: Theme.of(context).textTheme.bodySmall),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                child: DropdownButton(
                  //'item' is list of widget to display in drop down, could be taxt, container, icon oa any thing
                  items:
                      //items acept the listtype 'DropdownMenuItem'so we have to convet the enum to list with help of '.map'
                      TodoTagEnum.values
                          .map((e) => DropdownMenuItem(
                                //'DropdownMenuItem' list required the child to show in drop down, this is actual child that will show in drop down
                                child: Text(e.name),
                                //'value' is what we want to return by cliking on the child above
                                //in over case we returned e, which is elimnte or object that pas by .map funcation on by one
                                value: e.name.toString(),
                                //at the end we convert all this to list
                                //we return hole object (like return 'e') so we colud use any value from the 'e'/object but in that case we are going to stror this data in String type varibale so we have specify the name from e and also convert it in String with .toString
                              ))
                          .toList(),
                  //that value is a value to show as salected value  on top of dropdown
                  //or we are taling the drop down that this value is salected value
                  value: userTag,
                  onChanged: (onchangeValue) {
                    setState(() {
                      userTag = onchangeValue;
                    });
                  },
                  hint: const Text('Select a Tag'),
                  underline: Container(),
                  borderRadius: BorderRadius.circular(5),
                  //to remove a bed underline under the salacted tag
                ),
              ),
              const SizedBox(width: 15),
              IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                              height: 135,
                              //Bottom Sheet will adopt the size of continer that we returned, also the shape and color
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30)),
                              child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(children: [
                                    ListTile(
                                      onTap: () async {
                                        //to use Image Picker Property we first put the code to get permission of gallery or camerby usnig link
                                        //put "image_picker: ^1.0.0" in pubspec and impor "import 'package:image_picker/image_picker.dart';" at the top
                                        final ImagePicker picker =
                                            ImagePicker();
                                        //we furst instance/ Intilize the Time picker class liske we do with controller class than we use the pickImage funcation whish we need here
                                        XFile? image = await picker.pickImage(
                                            source: ImageSource.gallery);
                                        //like a tme picker we hold/save the value we got from imagepicker (the funcation returen a value in XFile) in a veiable image of a Type XFile
                                        if (image != null) {
                                          setState(() {
                                            usertodoimage = File(image.path);
                                            //To use File we must imort "import 'dart:io';",File is data type wich can holed the path and perform relative funcations
                                            //in that case we have created File Tipe variable in althe way our class and Controller model, in witch the image fle will be stored
                                          });
                                          Navigator.pop(context);
                                        }
                                      },
                                      tileColor:
                                          const Color.fromARGB(255, 75, 75, 75),
                                      title: Text('Pick  Image from Gallery',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium),
                                      trailing: const Icon(
                                        Icons.photo_library,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    ListTile(
                                      onTap: () async {
                                        //to use Image Picker Property we first put the code to get permission of gallery or camerby usnig link
                                        //put "image_picker: ^1.0.0" in pubspec and impor "import 'package:image_picker/image_picker.dart';" at the top
                                        final ImagePicker picker =
                                            ImagePicker();
                                        //we furst instance/ Intilize the Time picker class liske we do with controller class than we use the pickImage funcation whish we need here
                                        XFile? image = await picker.pickImage(
                                            source: ImageSource.camera);
                                        //like a tme picker we hold/save the value we got from imagepicker (the funcation returen a value in XFile) in a veiable image of a Type XFile
                                        if (image != null) {
                                          setState(() {
                                            usertodoimage = File(image.path);
                                            //To use File we must imort "import 'dart:io';",File is data type wich can holed the path and perform relative funcations
                                            //in that case we have created File Tipe variable in althe way our class and Controller model, in witch the image fle will be stored
                                          });
                                          Navigator.pop(context);
                                        }
                                      },
                                      tileColor:
                                          const Color.fromARGB(255, 75, 75, 75),
                                      title: Text('OR take a photo with camera',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium),
                                      trailing: const Icon(
                                        Icons.camera,
                                        color: Colors.white,
                                      ),
                                    )
                                  ])));
                        });
                  },
                  icon: const Icon(Icons.add_a_photo_outlined,
                      color: Colors.white)),
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
                        widget.controller?.addTodo(
                            userTitle!,
                            userDescription!,
                            usertodoimage,
                            userTodoTime!,
                            userPriority,
                            userTag,
                            context);
                        //the Funcation in TodoController Class needs these data to set Data in list specialy Context
                        await widget.controller?.setData();
                      });
                      widget.setTheState();
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

  // showModalBottomSheet(
  //   context: context,
  //   builder: (context) {
  //     return Container(
  //         height: 260,
  //         //Bottom Sheet will adopt the size of continer that we returned, also the shape and color
  //         decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(30)),
  //         child: Padding(
  //             padding: const EdgeInsets.all(10.0),
  //             child: Column(children: [
  //               ListTile(
  //                 onTap: () {
  //                   userTag = "Work";
  //                 },
  //                 tileColor:
  //                     const Color.fromARGB(255, 75, 75, 75),
  //                 title: Text('Work Tasky',
  //                     style: Theme.of(context)
  //                         .textTheme
  //                         .bodyMedium),
  //                 leading: const Icon(Icons.business,
  //                     color: Colors.white),
  //                 trailing: const Icon(Icons.arrow_right),
  //               ),
  //               const SizedBox(height: 10),
  //               ListTile(
  //                 onTap: () {
  //                   userTag = "Home";
  //                 },
  //                 tileColor:
  //                     const Color.fromARGB(255, 75, 75, 75),
  //                 title: Text('Home Task',
  //                     style: Theme.of(context)
  //                         .textTheme
  //                         .bodyMedium),
  //                 leading: const Icon(Icons.home,
  //                     color: Colors.white),
  //                 trailing: const Icon(Icons.arrow_right),
  //               ),
  //               const SizedBox(height: 10),
  //               ListTile(
  //                 onTap: () {
  //                   userTag = "Health";
  //                 },
  //                 tileColor:
  //                     const Color.fromARGB(255, 75, 75, 75),
  //                 title: Text('Health Task',
  //                     style: Theme.of(context)
  //                         .textTheme
  //                         .bodyMedium),
  //                 leading: const Icon(
  //                     Icons.health_and_safety,
  //                     color: Colors.white),
  //                 trailing: const Icon(Icons.arrow_right),
  //               ),
  //               const SizedBox(height: 10),
  //               ListTile(
  //                 onTap: () {
  //                   userTag = "Shoping";
  //                 },
  //                 tileColor:
  //                     const Color.fromARGB(255, 75, 75, 75),
  //                 title: Text('Shoping Task',
  //                     style: Theme.of(context)
  //                         .textTheme
  //                         .bodyMedium),
  //                 leading: const Icon(Icons.shopping_cart,
  //                     color: Colors.white),
  //                 trailing: const Icon(Icons.arrow_right),
  //               ),
  //               const SizedBox(height: 10),
  //             ])));
  //   });
}
