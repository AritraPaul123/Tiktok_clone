import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/views/screens/profileScreen.dart';
import '../../controllers/searchController.dart';
import '../../models/usermodel.dart';

class Searchscreen extends StatelessWidget {
  const Searchscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Searchcontroller searchcontroller=Get.put(Searchcontroller());
    final TextEditingController _searchController=new TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          controller: _searchController,
          decoration: const InputDecoration(
            icon: Icon(Icons.search),
            hintText: "Search Username",
            enabledBorder: InputBorder.none,
            border: InputBorder.none,
            errorBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
            contentPadding: EdgeInsets.only(left: 15,right: 15,top: 11,bottom: 11)
          ),
          onChanged: (value){
            searchcontroller.searchUsers(value);
        },),
      ),
      body: Obx(() {
        return ListView.builder(
          shrinkWrap: true,
            itemCount: searchcontroller.users.length,
            itemBuilder: (context, index) {
              myUser user = searchcontroller.users[index];
              return ListTile(
                onTap: (){
                  Get.to(Profilescreen(uid: user.uid));
                },
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(user.proimage),
                ),
                title: Text(user.myUsername),
              );
            }
        );
      }
      ),
    );
  }
}
