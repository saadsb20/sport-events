import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sport_events/models/user_model.dart';
import 'package:sport_events/screens/home.dart';

class register extends StatefulWidget {
  const register({Key? key}) : super(key: key);
  static const String id = 'register';

  @override
  _registerState createState() => _registerState();
}

class _registerState extends State<register> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = new TextEditingController();
  final TextEditingController lastNameController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController phoneController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController ConfirmPasswordController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
              Colors.blue.shade900,
              Colors.blue.shade500,
              Colors.blue.shade400,
            ])),
        child: Column(
          children: [
            /// Sign up & Welcome
            Container(
                padding: const EdgeInsets.only(top:80, bottom: 30, right: 20),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    Text('Sign Up', style: TextStyle(color: Colors.white, fontSize: 40),),
                    SizedBox(height: 10),
                    Text('Welcome', style: TextStyle(color: Colors.white, fontSize: 18),),
                  ],
                )
            ),
            /// The rest
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(40),
                    topLeft: Radius.circular(40),
                  ),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.only(top: 10, right: 15, left: 15),
                child: Column(
                  children: [
                    /// Text Fields
                    Container(
                      child:Form(
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
                                controller: firstNameController,
                                keyboardType: TextInputType.text,
                                onSaved: (value){
                                  firstNameController.text = value!;
                                },
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.person),
                                    hintText: "First Name",
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
                                controller: lastNameController,
                                keyboardType: TextInputType.text,
                                onSaved: (value){
                                  lastNameController.text = value!;
                                },
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.person),
                                    hintText: "Last Name",
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
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                onSaved: (value){
                                  emailController.text = value!;
                                },
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.email),
                                    hintText: "Email",
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
                                controller: phoneController,
                                keyboardType: TextInputType.number,
                                onSaved: (value){
                                  phoneController.text = value!;
                                },
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.phone),
                                    hintText: "Phone Number",
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
                                controller: passwordController,
                                obscureText: true,
                                onSaved: (value){
                                  passwordController.text = value!;
                                },
                                textInputAction: TextInputAction.done,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.password),
                                    hintText: "Password",
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
                                controller: ConfirmPasswordController,
                                obscureText: true,
                                onSaved: (value){
                                  ConfirmPasswordController.text = value!;
                                },
                                textInputAction: TextInputAction.done,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.password),
                                    hintText: "Confirm Password",
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
                                register(emailController.text,passwordController.text);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("You have an account ? "),
                        GestureDetector(
                          onTap: (){
                            Navigator.pushNamed(context, "/");
                          },
                          child: Text(
                            "Log in",
                            style: TextStyle(
                                color: Colors.blue.shade800,
                                fontWeight: FontWeight.bold,
                                fontSize: 15
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void register(String email, String password) async{
    if(_formKey.currentState!.validate()){
      await _auth
        .createUserWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
            postDetailstoFireStore(),
      }).catchError((e){
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }
  postDetailstoFireStore() async{
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    UserModel userModel = UserModel();

    userModel.uid = user!.uid;
    userModel.email = user.email;
    userModel.firstName = firstNameController.text;
    userModel.lastName = lastNameController.text;
    userModel.phone = phoneController.text;
    userModel.role = 'user';

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully");

    Navigator.pushAndRemoveUntil((context), MaterialPageRoute(builder: (context) => home()),
            (route) => false);
  }
}