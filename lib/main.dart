import 'package:blogapp/pages/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel Blogs',
      theme: ThemeData(
        fontFamily: 'Abeeze', textSelectionTheme: const TextSelectionThemeData(selectionColor: Colors.white)
      ),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

