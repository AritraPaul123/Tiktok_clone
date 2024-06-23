import 'dart:io';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/models/usermodel.dart';
import 'package:tiktok_clone/views/screens/addcaptionscreen.dart';
import 'package:tiktok_clone/views/screens/home.dart';
import 'package:tiktok_clone/views/screens/loginscreen.dart';

class AuthController extends GetxController{
  File? ProImg;
  static AuthController instance=Get.find();
  late Rx<User?> _user;
  User get user=>_user.value!;
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    _user=Rx<User?>(FirebaseAuth.instance.currentUser);
    _user.bindStream(FirebaseAuth.instance.authStateChanges());
    ever(_user, _setInitialView);
  }
  _setInitialView(User? user) async {
     if(user==null){
       Get.offAll(()=>Loginscreen());
     }else{
       Get.offAll(()=>Home());
     }
  }
  pickVideo(ImageSource src) async {
    final video= await ImagePicker().pickVideo(source: src);
    if(video!=null){
      Get.snackbar("Video Selected", video.path);
      Get.off(()=>Addcaptionscreen(VideoFile: File(video.path), VideoPath: video.path));
    }else{
      Get.snackbar("Error Selecting Video", "Please Choose A Different Video");
    }
  }
  pickImage() async {
   final image=await ImagePicker().pickImage(source: ImageSource.gallery);
   if(image==null) return;
   final img=File(image.path);
   this.ProImg=img;
  }
  @override
   void SignUp(String email, String password, String username, File? image) async {
     try {
       if(email.isNotEmpty && password.isNotEmpty && username.isNotEmpty && image!=null){
         UserCredential credential = await FirebaseAuth.instance
             .createUserWithEmailAndPassword(email: email, password: password);
         String downloadURL=await _uploadPic(image);
         myUser user=myUser(email: email, uid: credential.user!.uid, myUsername: username, proimage: downloadURL);
         await FirebaseFirestore.instance.collection("users").doc(credential.user!.uid).set(user.toJson());
       }else{
         Get.snackbar("Error!", "Please Fill All The Required Fields");
       }
     }catch(e){
       Get.snackbar("Error Ocurred", e.toString());
     }
   }
   Future<String> _uploadPic(File image) async {
     Reference reference=await FirebaseStorage.instance.ref().child("profilePics").child(FirebaseAuth.instance.currentUser!.uid);
     UploadTask uploadTask=reference.putFile(image);
     TaskSnapshot taskSnapshot=await uploadTask;
     String dwnloadURL=await taskSnapshot.ref.getDownloadURL();
     return dwnloadURL;
   }
   void Login(String email, String password) async {
    try{
      if(email.isNotEmpty && password.isNotEmpty){
        await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      }else{
        Get.snackbar("Error!", "Please Fill All The Required Fields");
      }
   }catch(e){
      Get.snackbar("Error Occured", e.toString());
    }
    }
 likedVideos(String id) async {
    var uid=AuthController.instance.user.uid;
    DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection("videos").doc(id).get();
    if(await isLiked(id)){
      await FirebaseFirestore.instance.collection("videos").doc(id).update({
        "likes" : FieldValue.arrayRemove([uid])
      });
    }else{
      await FirebaseFirestore.instance.collection("videos").doc(id).update({
        "likes" : FieldValue.arrayUnion([uid])
      });
    }
  }
  shareVideo(String vid) async {
    DocumentSnapshot doc=await FirebaseFirestore.instance.collection("videos").doc(vid).get();
    int newShareCount=(doc.data() as dynamic)["shareCount"]+1;
    await FirebaseFirestore.instance.collection("videos").doc(vid).update({
      "shareCount" : newShareCount
    });
  }
  Future<bool> isLiked(String id) async {
    var uid=AuthController.instance.user.uid;
    DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection("videos").doc(id).get();
    if((snapshot.data() as dynamic)["likes"].contains(uid)){
      return true;
    }else{
      return false;
    }
  }
  signout() async {
    await FirebaseAuth.instance.signOut();
    Get.offAll(Loginscreen());
  }
}