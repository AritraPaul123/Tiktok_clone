import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:video_compress/video_compress.dart';

class Albumrotator extends StatefulWidget {
  const Albumrotator({super.key});

  @override
  State<Albumrotator> createState() => _AlbumrotatorState();
}

class _AlbumrotatorState extends State<Albumrotator> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller=AnimationController(vsync: this,duration: Duration(seconds: 5));
    _controller.forward();
    _controller.repeat();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
      child: SizedBox(
        height: 38,
        width: 38,
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [
              Colors.grey,
              Colors.white
            ]),
            borderRadius: BorderRadius.circular(35)
          ),
          height: 38,
          width: 38,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(35),
            child: Image(image: NetworkImage("https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),),
          ),
        ),
      ),
    );
  }
}
