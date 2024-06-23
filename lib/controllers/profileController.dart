

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class Profilecontroller extends GetxController {
  static Profilecontroller instance = Get.find();
  final Rx<Map<String, dynamic>> _user = Rx<Map<String, dynamic>>({});

  Map<String, dynamic> get user => _user.value;
  final Rx<String> _uid = " ".obs;

  updateUID(String uid) {
    _uid.value = uid;
    getUserDet();
  }

  getUserDet() async {
    try {
      List<String> thumbnails = [];
      List<String> videos = [];
      var myVideos = await FirebaseFirestore.instance.collection("videos")
          .where(
          "uid", isEqualTo: _uid.value)
          .get();
      if (myVideos.docs.isNotEmpty) {
        for (var element in myVideos.docs) {
          thumbnails.add((element.data() as dynamic)["thumbnail"]);
          videos.add((element.data() as dynamic)["videourl"]);
        }
      }
        var userDoc = await FirebaseFirestore.instance.collection("users").doc(
            _uid.value).get();
        String username = (userDoc.data() as dynamic)["myUsername"];
        String profilepic = (userDoc.data() as dynamic)["image"];
        int likes = 0;
        int followers = 0;
        int followings = 0;
        bool isFollowing = false;
        update();
        if (myVideos.docs.isNotEmpty) {
          for (var element in myVideos.docs) {
            likes += ((element.data() as dynamic)["likes"] as List).length;
          }
        }
        var followerDoc = await FirebaseFirestore.instance.collection("users")
            .doc(_uid.value).collection("followers")
            .get();
        var followingDoc = await FirebaseFirestore.instance.collection("users")
            .doc(_uid.value).collection("followings")
            .get();
        followers = followerDoc.docs.length;
        followings = followingDoc.docs.length;

        await FirebaseFirestore.instance.collection("users").doc(_uid.value)
            .collection("followers").doc(FirebaseAuth.instance.currentUser!.uid)
            .get()
            .then((value) {
          if (value.exists) {
            isFollowing = true;
          } else {
            isFollowing = false;
          }
        });

        _user.value = {
          "followings": followings.toString(),
          "followers": followers.toString(),
          "likes": likes.toString(),
          "isFollowing": isFollowing,
          "profilepic": profilepic,
          "username": username,
          "thumbnails": thumbnails,
          "videourl" : videos
        };
        update();
    }catch(e){
      Get.snackbar("Error", e.toString());
    }
  }

  followUser() async {
    var doc = await FirebaseFirestore.instance.collection("users").doc(
        _uid.value).collection("followers").doc(
        FirebaseAuth.instance.currentUser!.uid).get();
    if (!doc.exists) {
      await FirebaseFirestore.instance.collection("users").doc(_uid.value)
          .collection("followers").doc(FirebaseAuth.instance.currentUser!.uid)
          .set({});
      await FirebaseFirestore.instance.collection("users").doc(
          FirebaseAuth.instance.currentUser!.uid).collection("followings").doc(
          _uid.value).set({});
      _user.value.update(
          "followers", (value) => (int.parse(value) + 1).toString());
    } else {
      await FirebaseFirestore.instance.collection("users").doc(_uid.value)
          .collection("followers").doc(FirebaseAuth.instance.currentUser!.uid)
          .delete();
      await FirebaseFirestore.instance.collection("users").doc(
          FirebaseAuth.instance.currentUser!.uid).collection("followings").doc(
          _uid.value).delete();
      _user.value.update(
          "followers", (value) => (int.parse(value) - 1).toString());
    }
    _user.value.update("isFollowing", (value) => !value);
    update();
  }
}