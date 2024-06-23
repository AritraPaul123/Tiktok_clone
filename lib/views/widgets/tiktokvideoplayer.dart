import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class TiktokVideoPlayer extends StatefulWidget {
  String videourl;
  TiktokVideoPlayer({required this.videourl});
  @override
  State<TiktokVideoPlayer> createState() => _TiktokVideoPlayerState();
}

class _TiktokVideoPlayerState extends State<TiktokVideoPlayer> {
  late VideoPlayerController videoPlayerController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    videoPlayerController=VideoPlayerController.networkUrl(Uri.parse(widget.videourl))..initialize().then((value){
      videoPlayerController.play();
      videoPlayerController.setLooping(true);
    });
  }
  @override
 void dispose() {
    // TODO: implement dispose
    super.dispose();
    videoPlayerController.dispose();
  }
  void pausevideo(){
     videoPlayerController.value.isPlaying ? videoPlayerController.pause() : videoPlayerController.play();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        onTap: (){
          pausevideo();
        },
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: Colors.black38
          ),
          child: VideoPlayer(videoPlayerController),
        ),
      ),
    );
  }
}
