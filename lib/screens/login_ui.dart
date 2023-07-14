import 'package:flutter/material.dart';
import 'package:todo_app/screens/splash_screen.dart';
import 'package:todo_app/screens/todo_main.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  void swtichtheSplashScreen() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const TodoListScreen(),
        ));
  }

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
              style:
                  Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 32),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 5),
              child: Text('Usernmae',
                  style: Theme.of(context).textTheme.bodyMedium),
            ),
            TextField(
                style: Theme.of(context).textTheme.bodyMedium,
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
              child: Text('Password',
                  style: Theme.of(context).textTheme.bodyMedium),
            ),
            TextField(
                style: Theme.of(context).textTheme.bodyMedium,
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
                      Future.delayed(
                          const Duration(seconds: 2), swtichtheSplashScreen);
                      //Future.delayed will perform the funcation (discribed at the end) after the duration discribed in Duration
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SplashScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff8687E7),
                        minimumSize: const Size(327, 55)),
                    child: Text(
                      'Login',
                      style: Theme.of(context).textTheme.bodyMedium,
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

  OutlineInputBorder borderOutlineStyle() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(color: Colors.white, width: 01));
  }
}
