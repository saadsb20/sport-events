import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sport_events/models/event_model.dart';
import 'package:sport_events/models/user_model.dart';
import 'package:sport_events/screens/addEvent.dart';
import 'package:sport_events/screens/login.dart';
import 'package:sport_events/screens/user_profile.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  _homeState createState() => _homeState();
}
class _homeState extends State<home> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  List Events =  [];
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
    .collection("users")
    .doc(user!.uid)
    .get()
    .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
     FirebaseFirestore.instance
    .collection("sportEvents")
    .get()
    .then((value) {
      if(value.docs.isNotEmpty){
        for(var doc in value.docs.toList()){
          Events.add(EventModel.fromMap(doc));
        }
      }
      setState(() {
        for(var doc in Events){
          print(doc.toString());
        }
      });
    });
  }
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
      body: StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            return ListView.builder(
                itemCount: Events.length,
                itemBuilder: (context, index){
                  return GestureDetector(
                    onTap: (){

                    },
                      child : Container(
                        width: 300,
                        height: 200,
                        child : Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          margin: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget> [
                               ListTile(
                                leading: Icon(Icons.sports_soccer, size: 60),
                                title: Text(Events[index].sport,style: TextStyle(fontSize: 30.0) ),
                                 subtitle: Text(
                                     Events[index].location,
                                     style: TextStyle(fontSize: 18.0)
                                 ),
                               ),
                              ButtonBar(
                                children: <Widget>[
                                  ElevatedButton(
                                    child: const Text('Participate'),
                                    onPressed: () {

                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                  ) ;
                }
            );
      },

      ),
      drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                height: 260,
                decoration: const BoxDecoration(
                  color: Color(0xFF1565C0),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(60),
                      bottomRight: Radius.circular(60)),
                ),
                child: DrawerHeader(
                  child:  Column(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration:  BoxDecoration(
                          shape: BoxShape.circle,
                          image:  DecorationImage(
                            image: NetworkImage("${loggedInUser.profilePicture}"),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "${loggedInUser.firstName} ${loggedInUser.lastName}",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                      SizedBox(height: 20,),
                      Text(
                        "${loggedInUser.email}",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  Navigator.push((context), MaterialPageRoute(builder: (context) => Profile()));
                },
                style: TextButton.styleFrom(primary: Theme.of(context).colorScheme.onPrimary),
                icon: Icon(Icons.person),
                label: Text('My Profile'),
              ),
              TextButton.icon(
                onPressed: () {
                },
                style: TextButton.styleFrom(primary: Theme.of(context).colorScheme.onPrimary),
                icon: Icon(Icons.event),
                label: Text('My Events'),
              ),
              TextButton.icon(
                onPressed: () {
                  Navigator.push((context), MaterialPageRoute(builder: (context) => addEvent()));
                },
                style: TextButton.styleFrom(primary: Theme.of(context).colorScheme.onPrimary),
                icon: Icon(Icons.event),
                label: Text('Add Event'),
              ),
            ],
          ),
        ),
    );

  }
  Future <void> Logout(BuildContext context) async{
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Login()));
  }
  
}