import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController? nameController;
  TextEditingController? agecontroller;
  TextEditingController? phonecontroller;

  updateData()
  {
    FirebaseAuth mAuth=FirebaseAuth.instance;
    var email=mAuth.currentUser!.email;
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return users.doc(email)
        .update({
      'name': nameController!.text, // John Doe
      'phone': phonecontroller!.text, // Stokes and Sons
      'age': agecontroller!.text,

      // 42
    })
        .then((value) =>          print("okk")
    )
        .catchError((error) => print("Failed to add user: $error"));
  }
  itemWidget(data){
    return Column(
      children: [
        TextFormField(
          controller:nameController=TextEditingController(text: data['name']) ,
        ),
        TextFormField(
          controller:agecontroller=TextEditingController(text:data['age']) ,

        ),
        TextFormField(
          controller:phonecontroller=TextEditingController(text:data['phone']) ,

        ),

        RaisedButton(onPressed: (){
          updateData();
        })
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.email).snapshots(),
        builder: (context, snapshot) {
          var data=snapshot.data;
          return itemWidget(data);
        }
      ),
    );
  }
}
