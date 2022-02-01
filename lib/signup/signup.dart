import 'package:ecommerce/form/userform.dart';
import 'package:ecommerce/signin/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailcontroller=new TextEditingController();
  TextEditingController passwordcontroller=new TextEditingController();

    signup() async{
      try {
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(

            email: emailcontroller.text,
            password: passwordcontroller.text
        );

        var authCredential=userCredential.user;

        if(authCredential!.uid.isNotEmpty)
          {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => UserForm()));
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

                     print("okkkk");
                     signup();
                     print("okkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk");


                  }),

              GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignIn()),
                  );
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
