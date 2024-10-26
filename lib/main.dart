import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nutripair/screens/home.dart';
import 'package:nutripair/screens/login.dart';
import 'package:nutripair/screens/signup.dart';
import 'package:nutripair/screens/dietary_preference.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env"); // Load the .env file
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
          // Add your text styles here
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
        '/dietary-preference': (context) => DietaryPreferences(),
      },
    );
  }
}
