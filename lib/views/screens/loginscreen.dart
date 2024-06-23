import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/controllers/auth_controller.dart';
import 'package:tiktok_clone/views/screens/signupscreen.dart';
import 'package:tiktok_clone/views/widgets/glitcheffect.dart';
import '../widgets/textinputfield.dart';

class Loginscreen extends StatelessWidget {
   Loginscreen({super.key});
  TextEditingController _emailcontroller=new TextEditingController();
  TextEditingController _passcontroller=new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GlitchEffect(child: Text("TikTok Clone",style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),)),
            SizedBox(height: 25),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Textinputfield(
                  controller: _emailcontroller,
                  LabelText: "Email",
                  myIcon: Icons.email
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Textinputfield(
                  controller: _passcontroller,
                  LabelText: "Password",
                  myIcon: Icons.password,
                  toHide: true,
              ),
            ),
            SizedBox(height: 38),
            ElevatedButton(onPressed: (){
                          AuthController.instance.Login(_emailcontroller.text, _passcontroller.text);
            },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                  child: Text("LOGIN",style: TextStyle(color: Colors.white,fontSize: 16),),
                )
            ),
            const SizedBox(height: 8),
            TextButton(onPressed: (){
              Get.offAll(Signupscreen());
            },
                child: const Text("Create New Account",style: TextStyle(color: Colors.blue,fontSize: 19,fontWeight: FontWeight.w700)
            ),
            )
  ]
        ),
      ),
    );
  }
}
