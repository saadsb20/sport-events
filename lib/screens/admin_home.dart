import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sport_events/screens/login.dart';
class Admin_home extends StatefulWidget {
  const Admin_home({Key? key}) : super(key: key);

  @override
  _Admin_homeState createState() => _Admin_homeState();
}

class _Admin_homeState extends State<Admin_home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade800,
        iconTheme: IconThemeData(color: Colors.white),
        actions: <Widget>[
          TextButton.icon(
            onPressed: () {
              Logout(context);
            },
            style: TextButton.styleFrom(primary: Colors.white),
            icon: Icon(Icons.logout),
            label: Text('Logout'),
          )
        ],
      ),
    );
  }
  Future <void> Logout(BuildContext context) async{
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Login()));
  }
}
