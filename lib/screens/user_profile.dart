import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:sport_events/models/user_model.dart';
import 'package:sport_events/screens/home.dart';
import 'package:sport_events/screens/login.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = new TextEditingController();
  final TextEditingController lastNameController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController phoneController = new TextEditingController();
  File? file;
  bool? Edit = false ;
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
      firstNameController.text = loggedInUser.firstName!;
      lastNameController.text = loggedInUser.lastName!;
      emailController.text = loggedInUser.email!;
      phoneController.text = loggedInUser.phone!;
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
      body: Center(
        child : Edit == true ? Column(

          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            file == null ? InkWell(
              onTap : (){
                chooseImage();
              },
              child: Icon(
                Icons.image,size: 100,
              ),
            ) : Image.file(file!,width: 100,height: 100,),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
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
                     //        initialValue: loggedInUser.firstName,
                          onSaved: (value){
                            firstNameController.text = value!;
                          },
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                              hintText: "First Name",
                              hintStyle: TextStyle(color: Colors.grey),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(
                                width: 1,
                                color: Colors.blue.shade800),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
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
                        //    initialValue: loggedInUser.lastName,
                          onSaved: (value){
                            lastNameController.text = value!;
                          },
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                              hintText: "Last Name",
                              hintStyle: TextStyle(color: Colors.grey),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(
                                width: 1,
                                color: Colors.blue.shade800),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          ),
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
                         // initialValue: loggedInUser.email,
                          onSaved: (value){
                            emailController.text = value!;
                          },
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email),
                              hintText: "Email",
                              hintStyle: TextStyle(color: Colors.grey),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(
                                width: 1,
                                color: Colors.blue.shade800),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
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
                   //       initialValue: loggedInUser.phone,
                          onSaved: (value){
                            phoneController.text = value!;
                          },
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.phone),
                              hintText: "Phone Number",
                              hintStyle: TextStyle(color: Colors.grey),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(
                                width: 1,
                                color: Colors.blue.shade800),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
            FloatingActionButton(
              backgroundColor: Colors.blue.shade900,
              foregroundColor: Colors.black,
              onPressed: () {
                updateProfile(context);
              },
              child: Icon(Icons.check,color: Colors.white),
            ),
          ],
        ):Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Center(
              child: loggedInUser.profilePicture != 'null' ?  Container(
                alignment: Alignment.center,
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image:  DecorationImage(
                    image:  NetworkImage("${loggedInUser.profilePicture}"),
                  ),
                ),
              ) : Icon(
              Icons.image,
            ),
            ),
            SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "First Name",
                  style: TextStyle(fontSize: 12),

                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Expanded(child: Text("${loggedInUser.firstName}", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18))),
              ),
            SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Last Name",
                  style: TextStyle(fontSize: 12),

                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Expanded(child: Text("${loggedInUser.lastName}", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18))),
              ),
            SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Email",
                  style: TextStyle(fontSize: 12),

                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Expanded(child: Text("${loggedInUser.email}", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18))),
              ),
            SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Phone",
                  style: TextStyle(fontSize: 12),

                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Expanded(child: Text("${loggedInUser.phone}", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18))),
              ),
            SizedBox(height: 20),

            Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(30.0),
              child: FloatingActionButton(
                  backgroundColor: Colors.blue.shade900,
                  foregroundColor: Colors.black,
                  onPressed: () {
                    isEdit();
                  },
                  child: Icon(Icons.edit,color: Colors.white),
                ),
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
  chooseImage() async {
    XFile? xfile = await ImagePicker().pickImage(source: ImageSource.gallery);
    print("file : " + xfile!.path);
    file = File(xfile.path);
    setState(() {});
  }
  updateProfile(BuildContext context)async{
    UserModel userModel = UserModel();
    Map<String,dynamic> map = Map();
    if(file!=null){
      String url = await uploadImage();
      map['profilePicture'] = url;
    }
    map['email'] = emailController.text;
    map['firstName'] = firstNameController.text;
    map['lastName'] = lastNameController.text;
    map['phone'] = phoneController.text;
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid).update(map);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => home()));
  }
  Future <String> uploadImage() async{
    TaskSnapshot task =  await FirebaseStorage.instance.ref().child("profile").child(loggedInUser.uid !+ "_" + basename(file!.path)).putFile(file!);
    return task.ref.getDownloadURL();
  }
  isEdit(){
    Edit = true;
    setState(() {
    });
  }
}
