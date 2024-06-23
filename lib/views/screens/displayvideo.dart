import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:tiktok_clone/controllers/auth_controller.dart';
import 'package:tiktok_clone/controllers/videocontroller.dart';
import 'package:tiktok_clone/views/screens/commentScreen.dart';
import 'package:tiktok_clone/views/screens/profileScreen.dart';
import 'package:tiktok_clone/views/widgets/albumrotator.dart';
import 'package:tiktok_clone/views/widgets/profilebutton.dart';

import '../widgets/tiktokvideoplayer.dart';

class Displayvideo extends StatelessWidget {
  String? videourl;
  Displayvideo({this.videourl});
  @override
  final Videocontroller videocontroller=Get.put(Videocontroller());
  final AuthController authController=Get.put(AuthController());
  void share(String vid) async {
    await FlutterShare.share(title: "Download New TikTok Clone app",
      text: "Watch Interesting Short Videos On TikTok Clone App",
    );
    authController.shareVideo(vid);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Obx(() {
         return PageView.builder(
           scrollDirection: Axis.vertical,
           itemCount: videocontroller.videolist.length,
             controller: PageController(initialPage: 0,viewportFraction: 1),
             itemBuilder: (context, index){
             final data=videocontroller.videolist[index];
             return InkWell(
               onDoubleTap: (){
                 authController.likedVideos(data.id);
               },
               child: Stack(
                   children: [
                    TiktokVideoPlayer(videourl: videourl ?? data.videourl),
                     Container(
                       margin: const EdgeInsets.only(left: 15, bottom: 10),
                       child: Column(
                         mainAxisAlignment: MainAxisAlignment.end,
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text(data.username.toString(),style: const TextStyle(fontSize: 19.5,fontWeight: FontWeight.w500,color: Colors.white),),
                           Text(data.caption.toString(),style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w400,color: Colors.white),),
                           Text(data.songname.toString(),style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.white))
                         ],
                       ),
                     ),
                     Positioned(
                       right : 5,
                         bottom: 10,
                         child: Column(
                           mainAxisAlignment: MainAxisAlignment.spaceAround,
                           children: [
                             InkWell(
                               onTap: (){
                                 Get.to(Profilescreen(uid: data.uid));
                               },
                                 child: Profilebutton(profilepic: data.profilepic.toString())),
                             const SizedBox(height: 2),
                             Column(
                               children: [
                                 IconButton(onPressed: (){AuthController.instance.likedVideos(data.id);}, icon: data.likes.contains(FirebaseAuth.instance.currentUser!.uid)? const Icon(Icons.favorite,size: 38, color: Colors.red) : const Icon(Icons.favorite_outline_rounded,size: 38,color: Colors.white)),
                                 Text(data.likes.length.toString(),style: const TextStyle(color: Colors.white,fontSize: 13),)
                               ],
                             ),
                             Column(
                               children: [
                                 IconButton(onPressed: (){ Get.to(Commentscreen(id: data.id,)); }, icon: const Icon(Icons.comment,size: 32,color: Colors.white,)),
                                 Text(data.commentsCount.toString(),style: const TextStyle(color: Colors.white,fontSize: 13),)
                               ],
                             ),
                             Column(
                               children: [
                                 IconButton(onPressed: (){share(data.id);}, icon:const Icon(Icons.send,size: 31,color: Colors.white,)),
                                 Text(data.shareCount.toString(),style:const TextStyle(color: Colors.white,fontSize: 13),)
                               ],
                             ),
                             const Padding(
                               padding: EdgeInsets.all(3),
                                 child: Albumrotator()
                             )
                           ],
                         )
                     ),
                   ],
               ),
             );
             }
         );
  }
       ),
    );
  }
}
