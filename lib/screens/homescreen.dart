import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/screens/todolist.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _showAppBar(),
      floatingActionButton: _showAddTaskFlotingButon(),
      body: Center(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(74, 74, 74, 10),
              child: Image.asset(
                "assets/checklist.png",
                width: 227,
                height: 227,
              ),
            ),
            Text(
              'What do you want to do today?',
              style: textStyle(20),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Tap + to add your tasks',
              style: textStyle(16),
            ),
            // const Expanded(child: SizedBox()),
            // _showAddTaskButton(),
          ],
        ),
      ),
    );
  }

  FloatingActionButton _showAddTaskFlotingButon() {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const TodoListScreen()));
      },
      backgroundColor: const Color(0xff8687E7),
      child: const Icon(
        Icons.add,
        size: 30,
      ),
    );
  }

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
        ),
      ],
    );
  }

  TextStyle textStyle(double w) {
    return GoogleFonts.lato(
        fontSize: w == null ? 16 : w,
        fontWeight: FontWeight.w700,
        color: Colors.white);
  }
}
