import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/views/widgets/customaddicon.dart';

class Home extends StatefulWidget {
   Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
int pageindex=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageindex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: bgcolor,
        onTap: (index){
          setState(() {
            pageindex=index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled,size: 25),
            label: "Home"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.search,size: 25),
              label: "Search"
          ),
          BottomNavigationBarItem(
              icon: Customaddicon(),
            label: ""
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.message,size: 25),
              label: "Messages"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person,size: 25),
              label: "Profile",
          ),
        ],
      ),
      body: Center(
        child: pagelist[pageindex]),
      );
  }
}

