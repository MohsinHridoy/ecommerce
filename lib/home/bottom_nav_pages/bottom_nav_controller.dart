import 'package:ecommerce/home/bottom_nav_pages/cart.dart';
import 'package:ecommerce/home/bottom_nav_pages/favourite.dart';
import 'package:ecommerce/home/bottom_nav_pages/profile.dart';
import 'package:flutter/material.dart';

import 'home.dart';



class BottomNavController extends StatefulWidget {
  @override
  _BottomNavControllerState createState() => _BottomNavControllerState();
}

class _BottomNavControllerState extends State<BottomNavController> {
  final _pages=[Home(),Cart(),Favourite(),Profile()];
  int _currentIndedx=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
      //  type: BottomNavigationBarType.fixed,

        //currentIndex :2,
       unselectedItemColor: Colors.yellow,

       selectedItemColor: Colors.purpleAccent,

        items: [
          BottomNavigationBarItem(icon:Icon(Icons.home),title: Text("Home")),
          BottomNavigationBarItem(icon:Icon(Icons.shopping_cart),title: Text("Cart")),
          BottomNavigationBarItem(icon:Icon(Icons.local_fire_department),title: Text("Favourite")),
          BottomNavigationBarItem(icon:Icon(Icons.pregnant_woman_rounded),title: Text("Profile"),),
        ],
        onTap: (index){
          setState(() {
            _currentIndedx=index;
          });
        },

      ),
      body:_pages[_currentIndedx] ,

    );
  }
}
