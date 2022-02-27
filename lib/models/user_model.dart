class UserModel{
  String? uid;
  String? email;
  String? firstName;
  String? lastName;
  String? role;
  String? profilePicture;
  String? phone;

  UserModel({this.uid,this.email,this.firstName,this.lastName,this.role,this.profilePicture,this.phone});

  factory UserModel.fromMap(map){
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      role: map['role'],
      profilePicture: map['profilePicture'],
      phone: map['phone']
    );
  }
  Map<String,dynamic> toMap(){
    return {
      'uid':uid,
      'email' : email,
      'firstName' : firstName,
      'lastName' : lastName,
      'role': role,
      'profilePicture': profilePicture,
      'phone' : phone
    };
  }
}