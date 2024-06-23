import 'package:flutter/material.dart';
import 'package:tiktok_clone/controllers/auth_controller.dart';
import 'package:tiktok_clone/views/widgets/glitcheffect.dart';
import '../widgets/textinputfield.dart';

class Signupscreen extends StatelessWidget {
  Signupscreen({super.key});
  TextEditingController _emailcontroller=new TextEditingController();
  TextEditingController _setpasscontroller=new TextEditingController();
  TextEditingController _confirmpasscontroller=new TextEditingController();
  TextEditingController _usercontroller=new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GlitchEffect(child: Text("Welcome To TikTok",style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),)),
            SizedBox(height: 10),
            Stack(
              children: [
                const CircleAvatar(radius: 50, backgroundImage: NetworkImage("https://media.istockphoto.com/vectors/default-profile-picture-avatar-photo-placeholder-vector-illustration-vector-id1223671392?k=6&m=1223671392&s=170667a&w=0&h=zP3l7WJinOFaGb2i1F4g8IS2ylw0FlIaa6x3tP9sebU="),),
                Positioned(
                  bottom: 0,
                    right: 5,
                    child: InkWell(
                      onTap: (){
                           AuthController.instance.pickImage();
                      },
                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                                        ),
                                        child: Icon(Icons.camera_alt,color: Colors.black87,),
                                      ),
                    ))
              ],
            ),
            SizedBox(height: 25),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Textinputfield(
                  controller: _usercontroller,
                  LabelText: "Username",
                  myIcon: Icons.person
              ),
            ),
            SizedBox(height: 20),
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
                controller: _setpasscontroller,
                LabelText: "Set Password",
                myIcon: Icons.password,
                toHide: true,
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Textinputfield(
                  controller: _confirmpasscontroller,
                  LabelText: "Confirm Password",
                  myIcon: Icons.password
              ),
            ),
            SizedBox(height: 38),
            ElevatedButton(onPressed: (){
              AuthController.instance.SignUp(_emailcontroller.text, _confirmpasscontroller.text, _usercontroller.text, AuthController.instance.ProImg);
            },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                  child: Text("SIGN UP",style: TextStyle(color: Colors.white,fontSize: 16),),
                )
            )
          ],
        ),
      ),
    );
  }
}
