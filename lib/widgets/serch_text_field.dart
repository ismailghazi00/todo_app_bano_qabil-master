import 'package:flutter/material.dart';
import '../models/controller.dart'; //to use Controller's SercheList line 20

class SerchTextField extends StatefulWidget {
   const SerchTextField({super.key, this.controller});
  final TodoController? controller;
  //As This class dont recognize Controller, and we have to use it
  //for that we have to import the controller by peramater, and also initilize it line 06

  @override
  State<SerchTextField> createState() => _SerchTextFieldState();
}

class _SerchTextFieldState extends State<SerchTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
        setState(() {
          widget.controller?.searchTodo(value);
          //as serchTodo fncatuin need String value (serched Key), and that value will be obtained from text filed.
          // as this class dont recognize the Controller so we will call it by perameter
        });
      },
      cursorColor: const Color(0xff979797),
      //Blinking line where we type
      style: Theme.of(context)
          .textTheme
          .bodyLarge
          ?.copyWith(color: const Color(0xff979797)),
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
          hintStyle: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: const Color(0xff979797)),
          border: const OutlineInputBorder(),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff979797)))),
    );
  }
}
