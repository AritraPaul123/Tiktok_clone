import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/controllers/auth_controller.dart';
import 'package:tiktok_clone/controllers/profileController.dart';
import 'package:tiktok_clone/views/screens/displayvideo.dart';

class Profilescreen extends StatefulWidget {
  String uid;
  Profilescreen({required this.uid});

  @override
  State<Profilescreen> createState() => _ProfilescreenState();
}

class _ProfilescreenState extends State<Profilescreen> {
  final Profilecontroller profilecontroller = Get.put(Profilecontroller());
  final AuthController authController = Get.put(AuthController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profilecontroller.updateUID(widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Profilecontroller>(
        builder: (controller) {
          return controller.user.isEmpty ? const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          ) : Scaffold(
            appBar: AppBar(
              title: Text("@${controller.user["username"]}"),
              centerTitle: true,
              backgroundColor: Colors.grey,
              actions: [
                IconButton(onPressed: () {
                  Get.snackbar("Welcome To TikTok Clone App", "Version 1.0.0");
                },
                    icon: Icon(Icons.info_outline_rounded)
                )
              ],
            ),
            body: SafeArea(
              child:
              SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipOval(
                          child: CachedNetworkImage(imageUrl: controller
                              .user["profilepic"].toString(),
                            width: 100,
                            height: 100,
                            placeholder: (context,
                                url) => const CircularProgressIndicator(),
                            errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                            fit: BoxFit.cover,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text(controller.user["likes"] ?? "0",
                                style: const TextStyle(
                                    fontSize: 27, fontWeight: FontWeight.w600)),
                            const SizedBox(height: 10),
                            const Text("Likes", style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w400))
                          ],
                        ),
                        const SizedBox(width: 55),
                        Column(
                          children: [
                            Text(controller.user["followers"] ?? "0",
                                style: const TextStyle(
                                    fontSize: 27, fontWeight: FontWeight.w600)),
                            const SizedBox(height: 10),
                            const Text("Followers", style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w400))
                          ],
                        ),
                        const SizedBox(width: 30),
                        Column(
                          children: [
                            Text(controller.user["followings"] ?? "0",
                                style: const TextStyle(
                                    fontSize: 27, fontWeight: FontWeight.w600)),
                            const SizedBox(height: 10),
                            const Text("Following", style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w400))
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 35),
                    InkWell(
                      onTap: () {
                        widget.uid == FirebaseAuth.instance.currentUser!.uid
                            ? authController.signout()
                            : profilecontroller.followUser();
                      },
                      child: Container(
                        height: 35,
                        width: 185,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.white60,
                              width: 0.6
                          ),
                        ),
                        child: Center(
                          child: Text(widget.uid ==
                              FirebaseAuth.instance.currentUser!.uid
                              ? "Sign Out"
                              :
                          controller.user["isFollowing"] ? "Following" :
                          "Follow"
                            , style: const TextStyle(fontSize: 18),),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Divider(indent: 30, endIndent: 30, thickness: 2),
                    const SizedBox(height: 50),
                    GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1,
                            crossAxisSpacing: 2
                        ),
                        itemCount: controller.user["thumbnails"].length,
                        itemBuilder: (context, index) {
                          final thumbnail = controller
                              .user["thumbnails"][index];
                          final videourl=controller.user["videourl"][index];
                          return InkWell(
                            onTap: (){
                              Get.to(Displayvideo(videourl: videourl));
                            },
                            child: CachedNetworkImage(imageUrl: thumbnail,
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                            ),
                          );
                        }
                    )
                  ],
                ),
              ),
            ),
          );
        }
    );
  }
}
