import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/controllers/uploadvideocontroller.dart';
import 'package:tiktok_clone/views/widgets/textinputfield.dart';
import 'package:video_player/video_player.dart';

class Addcaptionscreen extends StatefulWidget {
  File VideoFile;
  String VideoPath;
  Addcaptionscreen({required this.VideoFile, required this.VideoPath});

  @override
  State<Addcaptionscreen> createState() => _AddcaptionscreenState();
}

class _AddcaptionscreenState extends State<Addcaptionscreen> {
  TextEditingController _songnamecontroller=new TextEditingController();
  TextEditingController _captioncontroller=new TextEditingController();
  late VideoPlayerController videoPlayerController;
  Uploadvideocontroller uploadvideocontroller=Get.put(Uploadvideocontroller());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    videoPlayerController=VideoPlayerController.file(widget.VideoFile);
    videoPlayerController.initialize();
    videoPlayerController.play();
    videoPlayerController.setLooping(false);
    videoPlayerController.setVolume(0.7);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    videoPlayerController.pause();
    videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height/1.4,
              width: MediaQuery.of(context).size.width,
              child: VideoPlayer(videoPlayerController),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              height: MediaQuery.of(context).size.height/4,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Textinputfield(
                      controller: _songnamecontroller,
                      LabelText: "Song",
                      myIcon: Icons.music_note
                  ),
                  SizedBox(height: 20),
                  Textinputfield(
                      controller: _captioncontroller,
                      LabelText: "Caption",
                      myIcon: Icons.closed_caption
                  ),
                  SizedBox(height: 20),
                  Uploadstatus()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget Uploadstatus()=>
      GetBuilder<Uploadvideocontroller>(
        init: Uploadvideocontroller(),
          builder: (controller){
          if(controller.uploadTask?.snapshot != null){
            final snap=controller.uploadTask?.snapshot;
            Rx<double> progress=(snap!.bytesTransferred/snap.totalBytes).obs;
            return Container(
              color: buttoncolor,
              child: Column(
                children: [
                  Text("Uploading.."),
                  SizedBox(height: 3),
                  Obx((){return Text("${(progress * 100).toStringAsFixed(2)}");})
                  //LinearProgressIndicator(value: progress,color: Colors.blue)
                ],
              ),
            );
          }else{
            return ElevatedButton(onPressed: (){
              Uploadvideocontroller.instance.uploadVideo(_songnamecontroller.text, _captioncontroller.text, widget.VideoPath);
              setState(() {

              });
            }, child: Text("Upload"),style: ElevatedButton.styleFrom(backgroundColor: buttoncolor));
          }
          }
      );
}
