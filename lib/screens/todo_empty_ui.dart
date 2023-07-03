import 'package:flutter/material.dart';
import 'package:todo_app/screens/todo_main.dart';

class TodoEmptyScreenWidget extends StatelessWidget {
  const TodoEmptyScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // appBar: _showAppBar(),
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
              style:
                  Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            Text('Tap + to add your tasks',
                style: Theme.of(context).textTheme.bodyMedium),
            // const Expanded(child: SizedBox()),
            // _showAddTaskButton(),
          ],
        ),
      ),
    );
  }
}
