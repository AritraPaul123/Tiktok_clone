import 'package:flutter/material.dart';

class Profilebutton extends StatelessWidget {
  String profilepic;
  Profilebutton({required this.profilepic});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: 48,
      child: Stack(
        children: [
          Positioned(
              child: Container(
                height: 48,
                width: 48,
                padding: EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16)
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image(
                    image: NetworkImage(profilepic.toString()),
                    fit: BoxFit.cover,

                  ),
                ),
              )
          )
        ],
      ),
    );
  }
}
