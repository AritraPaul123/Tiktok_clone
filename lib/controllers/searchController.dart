import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../models/usermodel.dart';

class Searchcontroller extends GetxController{
  static Searchcontroller instance=Get.find();
  final Rx<List<myUser>> _usernames= Rx<List<myUser>>([]);
  List<myUser> get users=>_usernames.value;
  searchUsers(String query) async {
    try{
      if(query.isNotEmpty) {
        _usernames.bindStream(
            await FirebaseFirestore.instance.collection("users").where(
                "myUsername", isGreaterThanOrEqualTo: query).snapshots().map((
                QuerySnapshot snapshot) {
              List<myUser> retval = [];
              for (var element in snapshot.docs) {
                retval.add(myUser.fromSnap(element));
              }
              return retval;
            }));
      }
    }catch(e){
      Get.snackbar("Error", e.toString());
    }
  }
}