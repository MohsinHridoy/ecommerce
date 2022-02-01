import 'package:ecommerce/provider/userprovider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class HomeDrawer extends StatefulWidget {
  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {

  UserProvider? userProvider;

  Widget Listtile({String? title,IconData? icondata, VoidCallback? onTap}){
    return ListTile(
      title:Text(title!) ,
      leading:Icon(icondata) ,
      onTap:onTap ,
    );
}
  @override
  Widget build(BuildContext context) {

    userProvider=Provider.of(context);
    userProvider!.getUserInfo();

    return Drawer(
      child: Container(
        child: ListView(
          children: [
            DrawerHeader(child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blueGrey,
                  radius: 30.0,
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(userProvider!.getUserData.name),
                    Text(userProvider!.getUserData.phone),
                  ],
                ),
              ],
            )) ,

            SizedBox(
              height: 10.00,
            ),

            Listtile(
              title: "dddd",
              icondata: Icons.add,
              onTap: (){

              }
            ),

            Listtile(
                title: "dddd",
                icondata: Icons.add,
                onTap: (){

                }
            ),

            Listtile(
                title: "dddd",
                icondata: Icons.add,
                onTap: (){

                }
            ),
          ], 
        ),
      ),
    );
  }
}
