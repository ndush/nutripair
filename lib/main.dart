import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nutripair/home.dart';
import 'package:nutripair/login.dart';
import 'package:nutripair/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
        Navigator.pushReplacementNamed(context, '/signin');
      } else {
        print('User is signed in!');
        Navigator.pushReplacementNamed(context, '/home');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NutriPair',
      theme: ThemeData(
        primaryColor: Colors.yellow[700],
        scaffoldBackgroundColor: Colors.yellow[100],
        appBarTheme: AppBarTheme(
          color: Colors.yellow[700],
          iconTheme: IconThemeData(color: Colors.white),
        ),
        textTheme: TextTheme(


        ),
        iconTheme: IconThemeData(
          color: Colors.yellow[800],
        ),
      ),
      initialRoute: '/signin',
      routes: {
        '/': (context) => SignIn(),
        '/signin': (context) => SignIn(),
        '/signup': (context) => SignUp(),
        '/home': (context) => Home(),
      },
    );
  }
}
