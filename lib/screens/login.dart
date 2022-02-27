import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sport_events/models/user_model.dart';
import 'package:sport_events/screens/admin_home.dart';
import 'package:sport_events/screens/home.dart';

class Login extends StatefulWidget {

  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  UserModel loggedInUser = UserModel();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Colors.blue.shade900,
          Colors.blue.shade500,
          Colors.blue.shade400,
        ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 80),
            // #login, #welcome
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Login",
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Welcome Back",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60)),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 60,
                        ),
                        // #email, #password
                        Container(
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
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
                                const SizedBox(height: 40),
                                Container(
                                  child: MaterialButton(
                                    shape: const StadiumBorder(),
                                    minWidth: 110,
                                    height: 45,
                                    color: Colors.blue.shade800,
                                    child: const Text('Login', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),textAlign: TextAlign.center,),
                                    onPressed: (){
                                      Login(emailController.text, passwordController.text);

                                    },
                                  ),
                                ),
                              ],
                            ),

                          ),
                        ),
                        const SizedBox(height: 30),
                        // #Register SNS
                         Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                           children: <Widget>[
                             Text("Don't you have an account ? "),
                             GestureDetector(
                               onTap: (){
                                 Navigator.pushNamed(context, "/register");
                               },
                               child: Text(
                                 "Register",
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
              ),
            ),
          ],
        ),
      ),
    );
  }
  void Login(String email,String password) async{
  if(_formKey.currentState!.validate()){
    await _auth
      .signInWithEmailAndPassword(email: email, password: password)
      .then((uid) => {
      Fluttertoast.showToast(msg: "Logged in successfully"),
      ChoosingRoute(),
    }).catchError((e){
      Fluttertoast.showToast(msg: e!.message);
    });
  }
  }
  void ChoosingRoute() {
    User? user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
      if(loggedInUser.role == 'user'){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> home()));
      }else if(loggedInUser.role == 'admin'){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> Admin_home()));
      }
    });

  }
}
