import 'package:cloud_firestore/cloud_firestore.dart';

class Comment{
  String comment, profilepic, username, uid, id;
  final datepub;
  List likes;
  Comment({
    required this.comment,
    required this.profilepic,
    required this.username,
    required this.uid,
    required this.id,
    required this.likes,
    required this.datepub
});
  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "profilepic": profilepic,
      "comment": comment,
      "uid": uid,
      "id": id,
      "likes": likes,
      "datepub": datepub
    };
  }
    static Comment fromSnap(DocumentSnapshot snap){
    var snapshot=snap.data() as Map<String, dynamic>;
      return Comment(
        comment: snapshot["comment"],
        profilepic: snapshot["profilepic"],
        username: snapshot["username"],
        uid: snapshot["uid"],
        id: snapshot["id"],
        likes: snapshot["likes"],
        datepub: snapshot["datepub"]
      );
    }
}