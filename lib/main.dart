import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/screens/login_ui_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        bottomSheetTheme: const BottomSheetThemeData(
          //----------------------------BottomSheetTheme
          shape: RoundedRectangleBorder(
              //get a rounded shape bydefult its squre corner
              borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20)) //it will make top ages rounded
              ),
          backgroundColor: Color(0xff1d1d1d), //bedfult its white
        ),
        //--------------------------------Floating Action Button Theme
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor:
              Color(0xff8687E7), //Floating Action button backgrund Color
        ),
        appBarTheme: AppBarTheme(
            //-----------------------------AppBarTheme
            centerTitle: true, //to make title center
            backgroundColor: Colors.black,
            titleTextStyle: GoogleFonts.lato(
                fontWeight: FontWeight.w400,
                fontSize: 20)), //aap bar Title Text Style
        textTheme: TextTheme(
          //-------------------------------Text Themes
          bodyLarge: GoogleFonts.lato(
              fontSize: 18, color: Colors.white.withOpacity(0.87)),
          bodyMedium: GoogleFonts.lato(
              fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),
          bodySmall: GoogleFonts.lato(
              fontSize: 12, fontWeight: FontWeight.w700, color: Colors.white),
        ),
        colorScheme: const ColorScheme(
            brightness: Brightness.dark,
            primary: Color(0xff8687E7),
            onPrimary: Colors.white,
            secondary: Color(0xff363636),
            onSecondary: Colors.grey,
            error: Colors.red,
            onError: Colors.white,
            background: Colors.black,
            onBackground: Colors.white,
            surface: Color(0xff8687E7),
            onSurface: Colors.white),

        primarySwatch: Colors.blue,
      ),
      home: const LogInScreen(),
    );
  }
}
