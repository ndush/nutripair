import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nutripair/screens/login.dart';
import 'package:nutripair/screens/signup.dart';
import 'package:nutripair/screens/dietary_preference.dart';
import 'package:nutripair/screens/meal_builder.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
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
        Navigator.pushReplacementNamed(context, '/signin');
      } else {
        Navigator.pushReplacementNamed(context, '/dietary-preference');
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
        appBarTheme: AppBarTheme(color: Colors.yellow[700]),
      ),
      initialRoute: '/signin',
      routes: {
        '/': (context) => SignIn(),
        '/signin': (context) => SignIn(),
        '/signup': (context) => SignUp(),
        '/dietary-preference': (context) => DietaryPreferences(),
        '/meal-builder': (context) => MealBuilder(),
      },
    );
  }
}
