import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/screens/todolist.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Login',
              style: textStyle(32),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 5),
              child: Text('Usernmae', style: textStyle(16)),
            ),
            TextField(
                style: textStyle(15),
                cursorColor: const Color(0xff979797),
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    enabledBorder: borderOutlineStyle(),
                    focusedBorder: borderOutlineStyle())),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 5),
              child: Text('Password', style: textStyle(16)),
            ),
            TextField(
                style: textStyle(15),
                obscureText: true,
                cursorColor: const Color(0xff979797),
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    enabledBorder: borderOutlineStyle(),
                    focusedBorder: borderOutlineStyle())),
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  //if we applay expanded in row it will expened in widthe else the widget raped in expanded will epnded in all the space avalibale n hight
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TodoListScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff8687E7),
                        minimumSize: const Size(327, 55)),
                    child: Text(
                      'Login',
                      style: textStyle(16),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  TextStyle textStyle(double w) {
    return GoogleFonts.lato(
        fontSize: w == null ? 16 : w,
        fontWeight: FontWeight.w700,
        color: Colors.white);
  }

  OutlineInputBorder borderOutlineStyle() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(color: Colors.white, width: 01));
  }
}
