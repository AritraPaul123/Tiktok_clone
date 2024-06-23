import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class myUser{
  String email, myUsername, uid, proimage;
  myUser({
    required this.email,required this.uid, required this.myUsername, required this.proimage
});
  Map<String, dynamic> toJson() => {
      "email": email,
      "myUsername": myUsername,
      "uid": uid,
      "image": proimage
    };

  static myUser fromSnap(DocumentSnapshot snap){
    var snapshot=snap.data() as Map<String, dynamic>;
    return myUser(
      email: snapshot["email"],
      myUsername: snapshot["myUsername"],
      uid: snapshot["uid"],
      proimage: snapshot["image"]
    );
  }
}