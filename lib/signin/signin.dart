import 'package:ecommerce/home/bottom_nav_pages/bottom_nav_controller.dart';
import 'package:ecommerce/home/homescreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailcontroller=new TextEditingController();
  TextEditingController passwordcontroller=new TextEditingController();

  signup() async{
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(

          email: emailcontroller.text.trim(),
          password: passwordcontroller.text.trim()
      );

      var authCredential=userCredential.user;

      if(authCredential!.uid.isNotEmpty)
      {
        print("Okkkkkkk");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BottomNavController()),
        );

      }
      else
      {
        print("Something is wrong");
      }



    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Container(
        child: Column(


            children: [
              ClipPath(
               // clipper: WaveClipper(),
                child: Container(
                  height: 200,
                  color: Colors.redAccent,
                ),
              ),
              TextField(
                controller: emailcontroller,
                decoration: new InputDecoration.collapsed(
                    hintText: 'Username'
                ),


              ),
              TextField(
                controller: passwordcontroller,
                decoration: new InputDecoration.collapsed(
                    hintText: 'Password'
                ),


              ),

              RaisedButton(
                  child: Text(
                      "Sign Up"
                  ),

                  onPressed: (){
                    print("okkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk");


                    signup();
                    print("okk");


                  }),

              GestureDetector(
                onTap: (){

                },
                child: Text(
                    "Sign In"
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
class WaveClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    // TODO: implement getClip

    var path=new Path();

    path.lineTo(0,size.height);
  //  throw UnimplementedError();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    throw UnimplementedError();
  }
  
}