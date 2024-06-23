import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/controllers/commentController.dart';
import 'package:tiktok_clone/models/commentModel.dart';
import 'package:tiktok_clone/views/widgets/textinputfield.dart';
import 'package:timeago/timeago.dart' as tago;

class Commentscreen extends StatelessWidget {
  String id;
  Commentscreen({required this.id});

  @override
  Widget build(BuildContext context) {
    Commentcontroller commentcontroller=Get.put(Commentcontroller());
    final TextEditingController _commentController=new TextEditingController();
    final Size=MediaQuery.of(context).size;
    commentcontroller.updatePostId(id);
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: Size.height,
          width: Size.width,
          child: Column(
            children: [
              Expanded(
                child: Obx(() {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: commentcontroller.comments.length,
                      itemBuilder: (context, index) {
                        Comment comment = commentcontroller.comments[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(comment.profilepic),
                          ),
                          title: Row(
                            children: [
                              Text(comment.username, style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.redAccent),),
                              const SizedBox(width: 5),
                              Text(comment.comment,
                                  style: const TextStyle(fontSize: 14))
                            ],
                          ),
                          subtitle: Row(
                            children: [
                              Text(tago.format(comment.datepub.toDate()),
                                style: const TextStyle(fontWeight: FontWeight.bold,
                                    fontSize: 11),),
                              const SizedBox(width: 5),
                              Text("${comment.likes.length.toString()} likes",
                                  style: const TextStyle(fontWeight: FontWeight.bold,
                                      fontSize: 11))
                            ],
                          ),
                          trailing: IconButton(
                              onPressed: () {
                                commentcontroller.likeComment(comment.id);
                              },
                              icon: comment.likes.contains(
                                  FirebaseAuth.instance.currentUser!.uid)
                                  ? const Icon(Icons.favorite, color: Colors.red)
                                  : const Icon(Icons.favorite_outline_rounded)
                          ),
                        );
                      }
                  );
                }
                ),
              ),
              const Divider(),
              ListTile(title:  Textinputfield(controller: _commentController, LabelText: "Comment", myIcon: Icons.comment),trailing: TextButton(child: Text("Send",style: TextStyle(fontSize: 16,color: Colors.blue),),onPressed: (){commentcontroller.postComment(_commentController.text);},),)
            ],
          ),
        ),
      )
    );
  }
}
