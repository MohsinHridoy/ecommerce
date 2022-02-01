import 'package:ecommerce/home/bottom_nav_pages/bottom_nav_controller.dart';
import 'package:ecommerce/provider/checkoutprovider.dart';
import 'package:ecommerce/provider/productprovider.dart';
import 'package:ecommerce/provider/reviewcartprovider.dart';
import 'package:ecommerce/provider/userprovider.dart';
import 'package:ecommerce/signin/signin.dart';
import 'package:ecommerce/signup/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'form/userform.dart';
import 'home/bottom_nav_pages/favourite.dart';
import 'home/bottom_nav_pages/home.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
      ChangeNotifierProvider<ProductProvider>(
      create:(context)=> ProductProvider(),
      ),

          ChangeNotifierProvider<UserProvider>(
            create:(context)=> UserProvider(),
          ),

          ChangeNotifierProvider<ReviewCartProvider>(
            create:(context)=> ReviewCartProvider(),
          ),

          ChangeNotifierProvider<CheckOutProvider>(
            create:(context)=> CheckOutProvider(),
          ),
        ],

        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch: Colors.blue,
          ),
          home:  Favourite(),
        ),
    );

  }
}

