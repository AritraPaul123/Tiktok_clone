import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/views/screens/addvideoscreen.dart';
import 'package:tiktok_clone/views/screens/displayvideo.dart';
import 'package:tiktok_clone/views/screens/profileScreen.dart';
import 'package:tiktok_clone/views/screens/searchscreen.dart';

getRandomColor()=>[
  Colors.blueAccent,
  Colors.redAccent,
  Colors.greenAccent
][Random().nextInt(3)];

const bgcolor=Colors.black;
var buttoncolor=Colors.red[400];
const bordercolor=Colors.grey;

var pagelist=[Displayvideo(), const Searchscreen(), const Addvideoscreen(), Text("Messages"), Profilescreen(uid: FirebaseAuth.instance.currentUser!.uid,)];