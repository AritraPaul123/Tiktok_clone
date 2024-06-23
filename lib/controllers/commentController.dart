//import 'dart:nativewrappers/_internal/vm/lib/core_patch.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/models/commentModel.dart';

class Commentcontroller extends GetxController{
  static Commentcontroller instance=Get.find();
  String _postID="";
  final Rx<List<Comment>> _comments=Rx<List<Comment>>([]);
  List<Comment> get comments=>_comments.value;
  updatePostId(String id){
    this._postID=id;
    fetchComment();
  }
  fetchComment() async{
    try {
      _comments.bindStream(
          await FirebaseFirestore.instance.collection("videos").doc(_postID)
              .collection("comments").snapshots()
              .map((QuerySnapshot query) {
            List<Comment> retval = [];
            for (var element in query.docs) {
              retval.add(Comment.fromSnap(element));
            }
            return retval;
          }));
    }catch(e){
      Get.snackbar("Error Fetching Comment", e.toString());
    }
  }
  postComment(String commentText) async{
    try {
      var uid = await FirebaseAuth.instance.currentUser!.uid;
      if (commentText.isNotEmpty) {
        var userdoc = await FirebaseFirestore.instance.collection("users").doc(
            uid).get();
        var alldocs = await FirebaseFirestore.instance.collection("videos").doc(
            _postID).collection("comments").get();
        int len = alldocs.docs.length;
        Comment comment = Comment(
            username: (userdoc.data() as dynamic)["myUsername"],
            profilepic: (userdoc.data() as dynamic)["image"],
            comment: commentText,
            uid: (userdoc.data() as dynamic)["uid"],
            id: "Comments $len",
            datepub: DateTime.now(),
            likes: []
        );
        await FirebaseFirestore.instance.collection("videos").doc(_postID)
            .collection("comments").doc("Comments $len")
            .set(comment.toJson());
        DocumentSnapshot doc = await FirebaseFirestore.instance.collection(
            "videos").doc(_postID).get();
        await FirebaseFirestore.instance.collection("videos")
            .doc(_postID)
            .update({
          "commentsCount": (doc.data() as dynamic)["commentsCount"] +1
        });
      } else {
        Get.snackbar("Please Write Something", "Comment Cannot Be Empty");
      }
    }catch(e){
      Get.snackbar("Error Uploading Comment", e.toString());
    }
  }
  likeComment(String commentID) async {
    try{
      var uid=await FirebaseAuth.instance.currentUser!.uid;
      var userdoc=await FirebaseFirestore.instance.collection("users").doc(uid).get();
      if(await isCommentLiked(commentID)){
      await FirebaseFirestore.instance.collection("videos").doc(_postID).collection("comments").doc(commentID).update({
        "likes" : FieldValue.arrayRemove([uid])
      });
      }else {
        await FirebaseFirestore.instance.collection("videos").doc(_postID).collection("comments").doc(commentID).update({
          "likes" : FieldValue.arrayUnion([uid])
        });
      }
    }catch(e){
      Get.snackbar("Error Ocurred", e.toString());
    }
  }
  Future<bool> isCommentLiked(String commentid) async {
    var uid=await FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection("videos").doc(_postID).collection("comments").doc(commentid).get();
    if((snapshot.data() as dynamic)["likes"].contains(uid)){
      return true;
    }else{
      return false;
    }
  }
}