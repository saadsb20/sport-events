import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sport_events/models/event_model.dart';
import 'package:sport_events/models/user_model.dart';
import 'package:sport_events/screens/login.dart';

class addEvent extends StatefulWidget {
  const addEvent({Key? key}) : super(key: key);

  @override
  _addEventState createState() => _addEventState();
}

class _addEventState extends State<addEvent> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  EventModel SportEvent = EventModel();
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
      participantsController.text = loggedInUser.firstName!;
    });
  }
  final _formKey = GlobalKey<FormState>();
  final TextEditingController sportController = new TextEditingController();
  final TextEditingController locationController = new TextEditingController();
  final TextEditingController participantsNumberController = new TextEditingController();
  final TextEditingController maxAgeController = new TextEditingController();
  final TextEditingController minAgeController = new TextEditingController();
  final TextEditingController cityController = new TextEditingController();
  final TextEditingController participantsController = new TextEditingController();
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
      body : Padding(
        padding: EdgeInsets.all(20.0),

        child:Container(
          child: Form(
            key: _formKey,
            child: Column(
              children:  [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: Colors.grey.shade200)),
                  ),
                  child:  TextFormField(
                    controller: sportController,
                    keyboardType: TextInputType.text,
                    onSaved: (value){
                      sportController.text = value!;
                    },
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.sports),
                        hintText: "Sport",
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: Colors.grey.shade200)),
                  ),
                  child:  TextFormField(
                    controller: locationController,
                    keyboardType: TextInputType.text,
                    onSaved: (value){
                      locationController.text = value!;
                    },
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.location_on),
                        hintText: "Location",
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: Colors.grey.shade200)),
                  ),
                  child:  TextFormField(
                    controller: cityController,
                    keyboardType: TextInputType.text,
                    onSaved: (value){
                      cityController.text = value!;
                    },
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.location_city),
                        hintText: "City",
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: Colors.grey.shade200)),
                  ),
                  child:  TextFormField(
                    controller: participantsNumberController,
                    keyboardType: TextInputType.number,
                    onSaved: (value){
                      participantsNumberController.text = value!;
                    },
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person_add),
                        hintText: "Participants Number",
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: Colors.grey.shade200)),
                  ),
                  child:  TextFormField(
                    controller: maxAgeController,
                    keyboardType: TextInputType.number,

                    onSaved: (value){
                      maxAgeController.text = value!;
                    },
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.perm_contact_calendar_sharp),
                        hintText: "Maximum age",
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: Colors.grey.shade200)),
                  ),
                  child:  TextFormField(
                    controller: minAgeController,
                    keyboardType: TextInputType.number,

                    onSaved: (value){
                      minAgeController.text = value!;
                    },
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.perm_contact_calendar_sharp),
                        hintText: "Minimum age",
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none),
                  ),
                ),
                const SizedBox(height: 30),
                /// Sign Up
                MaterialButton(
                  shape: const StadiumBorder(),
                  minWidth: 110,
                  height: 45,
                  color:  Colors.blue.shade800,
                  child: const Text('SignUp', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),textAlign: TextAlign.center,),
                  onPressed: (){
                    addEvent();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future <void> Logout(BuildContext context) async{
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Login()));
  }
  addEvent()async{
    Map<String,dynamic> map = Map();
    EventModel eventModel = EventModel();
    eventModel.sport = sportController.text;
    eventModel.location = locationController.text;
    eventModel.participantsNumber = int.parse(participantsNumberController.text) ;
    eventModel.maxAge = int.parse(maxAgeController.text) ;
    eventModel.minAge = int.parse(minAgeController.text) ;
    eventModel.city = cityController.text;
    eventModel.participants?[0] = loggedInUser.firstName!;
    eventModel.creatorUid = loggedInUser.uid ;
   await FirebaseFirestore.instance
        .collection("sportEvents")
        .doc().set(eventModel.toMap());
   print(map);
   Fluttertoast.showToast(msg: "Event created successfully");

  }
}
