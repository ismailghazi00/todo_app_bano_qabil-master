import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 220,
              child: Flexible(
                  //child will be Flexible with givien width (incase of Column)
                  child: Lottie.asset('assets/task.json', fit: BoxFit.fill)),
              //fit: BoxFit.Fill will make the Lottie to fill up all the space
              //To use Lottie Animation we have to ad depandacy and import Library, than we will use it like Image
              //https://lottiefiles.com/
              //https://rive.app/
            ),
            const SizedBox(
              height: 100,
            ),
            Text('Designed by Ismail Ghazi',
                style: Theme.of(context).textTheme.bodySmall)
          ],
        ),
      ),
    );
  }
}
