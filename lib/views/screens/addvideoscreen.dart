import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/controllers/auth_controller.dart';

class Addvideoscreen extends StatelessWidget {
  const Addvideoscreen({super.key});

  showOptions(BuildContext context) {
      showDialog(context: context, builder: (context)=>SimpleDialog(
      children: [
        SimpleDialogOption(
          child: Text("Choose From Gallery"),
          onPressed: ()=>AuthController.instance.pickVideo(ImageSource.gallery),
        ),
        SimpleDialogOption(
          child: Text("Take A Video"),
          onPressed: ()=>AuthController.instance.pickVideo(ImageSource.camera),
        ),
        SimpleDialogOption(
          child: Text("Cancel"),
          onPressed: (){
            Navigator.pop(context);
          }
        ),
      ],
  ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: (){showOptions(context);},
          child: Container(
            height: 70,
            width: 120,
            decoration: BoxDecoration(
              color: buttoncolor
            ),
            child:Center(child: const Text("ADD VIDEO",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: Colors.white),)),
          ),
        ),
      ),
    );
  }
}
