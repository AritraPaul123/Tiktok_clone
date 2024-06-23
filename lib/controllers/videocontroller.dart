import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../models/videomodel.dart';

class Videocontroller extends GetxController{
  static Videocontroller instance=Get.find();
  final Rx<List<Video>> _videolist=Rx<List<Video>>([]);
  List<Video> get videolist=>_videolist.value;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _videolist.bindStream(FirebaseFirestore.instance.collection("videos").snapshots().map((QuerySnapshot query){
    List<Video> retval=[];
    for(var element in query.docs){
      retval.add(Video.fromSnap(element));
    }
    return retval;
    }));
  }
  }
