

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
class UserProvider with ChangeNotifier{
  User1? user11;


  sendUserToDb({String? username,String? phone,String? age,String? value,String? date}) async {
    FirebaseAuth mAuth = FirebaseAuth.instance;
    var email = mAuth.currentUser!.email;
    final users = FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid);

    final user = User1(

        id: users.id,
        name: username!,
        phone: phone!,
        age: age!,
        value: value,
        date: date!

    );


    final json = user.toJson();

    var add = await users.set(
        json); //.then((value) => Navigator.of(context).push(MaterialPageRoute(builder: (context) => BottomNavController())));

    return add;


    /*   final json=({
         'name': namecontroller.text, // John Doe
         'phone': phonenumbercontroller.text, // Stokes and Sons
         'date': datecontroller.text, // 42 'phone': company, // Stokes and Sons
         'age': agecontroller.text,
         'value': value,
       });
*/
    // var ggh= await  users.doc().set(json);

    // return  ggh;

    /*   return users.doc(email)
        .set({
      'name': namecontroller.text, // John Doe
      'phone': phonenumbercontroller.text, // Stokes and Sons
      'date': datecontroller.text, // 42 'phone': company, // Stokes and Sons
      'age': agecontroller.text,
      'value': value,
        // 42
    })
        .then((value) =>             Navigator.of(context).push(MaterialPageRoute(builder: (context) => BottomNavController()))
      )
        .catchError((error) => print("Failed to add user: $error"));*/

  }

  getUserInfo() async {
    User1? user;
    var ss = await FirebaseFirestore.instance.collection('users').doc(
        FirebaseAuth.instance.currentUser!.uid).get();


    print(FirebaseAuth.instance.currentUser!.uid);

    if (ss.exists) {
      user = User1(
          id: ss.get('id'),
          name: ss.get('name'),
          phone: ss.get('phone'),
          age: ss.get('age'),
          value: ss.get('value'),
          date: ss.get('date'));
    }
    user11 = user;

    notifyListeners();
  }

  User1 get getUserData{
    return user11!;
  }

}