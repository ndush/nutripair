import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:nutripair/screens/home.dart';
import 'screens/login.dart';
import 'screens/signup.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load the .env file
  await dotenv.load(fileName: ".env");

  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NutriPair',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: '/signin',
      routes: {
        '/signin': (context) => SignIn(),
        '/signup': (context) => SignUp(),
        '/main': (context) => MainScreen(), // Main screen with bottom navigation
      },
    );
  }
}
