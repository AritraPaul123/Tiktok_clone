import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:video_compress/video_compress.dart';

import '../models/videomodel.dart';

class Uploadvideocontroller extends GetxController{
  UploadTask? uploadTask;
  static Uploadvideocontroller instance=Get.find();
  var uuid=Uuid();
   uploadVideo(String songname, String caption, String videopath) async {
     try {
       String uid = await FirebaseAuth.instance.currentUser!.uid;
       DocumentSnapshot userdoc = await FirebaseFirestore.instance.collection(
           "users").doc(uid).get();
       String id = uuid.v1();
       String videourl = await _uploadVideoToStorage(id, videopath);
       String thumbnail = await _uploadThumbToStorage(videopath, id);
       Video video = Video(
           username: (userdoc.data() as Map<String, dynamic>)["myUsername"],
           uid: uid,
           caption: caption,
           songname: songname,
           videourl: videourl,
           thumbnail: thumbnail,
           profilepic: (userdoc.data() as Map<String, dynamic>)["image"],
           id: id,
           likes: [],
           commentsCount: 0,
           shareCount: 0
       );
       await FirebaseFirestore.instance.collection("videos").doc(id).set(
           video.toJson());
       Get.snackbar("Video Uploaded", "Thanks For Sharing Your Content");
       Get.back();
     }catch(e){
       Get.snackbar("Error Uploading Video", e.toString());
     }
   }
   Future<String> _uploadVideoToStorage(String videoid, String videopath) async {
     Reference reference=await FirebaseStorage.instance.ref().child("videos").child(videoid);
     uploadTask=reference.putFile(await _compressVideo(videopath));
     update();
     TaskSnapshot? snapshot=await uploadTask;
     String downloadURL=await snapshot!.ref.getDownloadURL();
     return downloadURL;
   }
    _compressVideo(String videopath) async {
      final compressedVideo=await VideoCompress.compressVideo(videopath,quality: VideoQuality.DefaultQuality);
      return compressedVideo?.file;
   }
  Future<String> _uploadThumbToStorage(String videopath, String thumbid) async {
    Reference reference=await FirebaseStorage.instance.ref().child("thumbnails").child(thumbid);
    UploadTask uploadTask=reference.putFile(await _getThumb(videopath));
    TaskSnapshot snapshot=await uploadTask;
    String downloadURL=await snapshot.ref.getDownloadURL();
    return downloadURL;
  }
  Future<File> _getThumb(String videopath) async {
     final thumbnail=await VideoCompress.getFileThumbnail(videopath);
     return thumbnail;
  }
}