import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sport_events/screens/home.dart';
import 'package:sport_events/screens/register.dart';
import '/screens/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'sport events',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.cyan,
        ),
        initialRoute: '/',
    routes: {
    '/': (context) => const Login(),
    '/register': (context) => const register(),
    '/home': (context) => const home()
        }
        );


  }

}
