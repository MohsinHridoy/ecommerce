
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/home/bottom_nav_pages/bottom_nav_controller.dart';
import 'package:ecommerce/model/user.dart';
import 'package:ecommerce/provider/userprovider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class UserForm extends StatefulWidget {
  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {

  UserProvider? userProvider;
  final dropdownItems=['Male','Female','Others'];
  TextEditingController namecontroller=new TextEditingController();
  TextEditingController phonenumbercontroller=new TextEditingController();
  TextEditingController datecontroller=new TextEditingController();
  TextEditingController agecontroller=new TextEditingController();

  String? value;

  Future<void> showDatePickerDialog(BuildContext context) async{
    final DateTime? datePicker=await showDatePicker(
      context:context ,
        initialDate: DateTime(DateTime.now().year -15),

        firstDate: DateTime(DateTime.now().year-20),

        lastDate: DateTime(DateTime.now().year)

    );

    if(datePicker!=null)
      {
        setState(() {
            datecontroller.text="${datePicker.day}/${datePicker.month}/${datePicker.year}";
        });
      }
  }

  sendUserToDb() async {

    FirebaseAuth mAuth=FirebaseAuth.instance;
    var email=mAuth.currentUser!.email;
    final  users = FirebaseFirestore.instance.collection('users').doc();

       final user= User1(

           id:users.id,
           name:namecontroller.text,
           phone:phonenumbercontroller.text,
           age:agecontroller.text,
           value:value,
           date:datecontroller.text

           );


       final json=user.toJson();

       var add=await users.set(json).then((value) => Navigator.of(context).push(MaterialPageRoute(builder: (context) => BottomNavController())));

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

  DropdownMenuItem<String> dropDownMenuItem(String item)
  {
       return DropdownMenuItem(
         value: item,
         child: Text(
           item
         ),
       );
  }
  @override
  Widget build(BuildContext context) {
    userProvider=Provider.of<UserProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              TextField(
                controller: namecontroller,
                  decoration:InputDecoration(
                    label: Text(
                      "ENter ur namne"
                    )
                  )
              ),
              TextField(
                controller:phonenumbercontroller ,
                  decoration:InputDecoration(
                      label: Text(
                          "ENter ur phone Number"
                      )
                  )
              ),
              TextField(
                controller: datecontroller,
                  decoration:InputDecoration(
                      label: Text(
                          "20/01/2016"
                      ),
                    /*suffixIcon: GestureDetector(
                      onTap: (){
                        showDatePickerDialog(context);
                      },
                      child: Icon(
                        Icons.add,

                      ),
                    ),*/

                    suffixIcon: IconButton(
                      onPressed: (){
                        print("okkkkk");
                        showDatePickerDialog(context);

                      },

                      icon: Icon(
                        Icons.add
                      ),


                    )
                  ),

              ),
              DropdownButton<String>(
                value: value,

                  items: dropdownItems.map(dropDownMenuItem).toList(),

                  onChanged: (value)=> setState(() {
                    this.value= value;
                  })

                  ),



              TextField(
                controller: agecontroller,
                  decoration:InputDecoration(
                      label: Text(
                          "ENter ur ageENter ur phone Number"
                      )
                  )
              ),

              RaisedButton(
                  child: Text(
                    "COntinue"
                  ),

                  onPressed: (){

                    userProvider!.sendUserToDb(
                      username: namecontroller.text,
                      phone: phonenumbercontroller.text,
                      age:agecontroller.text,
                      value: value,
                      date: datecontroller.text
                    );

                   // sendUserToDb();

                  }

              )
            ],
          ),
        ),
      ),
    );
  }
}
