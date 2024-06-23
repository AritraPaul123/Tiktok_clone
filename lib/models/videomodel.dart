import 'package:cloud_firestore/cloud_firestore.dart';

class Video{
  String username,uid,caption,songname,videourl,thumbnail,profilepic,id;
  List likes;
  int shareCount, commentsCount;
  Video({required this.username, required this.uid, required this.caption, required this.songname, required this.videourl,
    required this.thumbnail, required this.profilepic, required this.id, required this.likes, required this.commentsCount, required this.shareCount});

  Map<String, dynamic> toJson(){
    return {
      "username" : username,
      "uid" : uid,
      "caption" : caption,
      "songname" : songname,
      "videourl" : videourl,
      "thumbnail" : thumbnail,
      "profilepic" : profilepic,
      "id" : id,
      "likes" : likes,
      "shareCount" : shareCount,
      "commentsCount" : commentsCount
    };
  }
  static Video fromSnap(DocumentSnapshot snap){
    var snapshot=snap.data() as Map<String, dynamic>;
    return Video(
      username: snapshot["username"],
      uid: snapshot["uid"],
      caption: snapshot["caption"],
      songname: snapshot["songname"],
      videourl: snapshot["videourl"],
      thumbnail: snapshot["thumbnail"],
      profilepic: snapshot["profilepic"],
      id: snapshot["id"],
      likes: snapshot["likes"],
      shareCount: snapshot["shareCount"],
      commentsCount: snapshot["commentsCount"]
    );
  }
}