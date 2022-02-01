import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/delivareydetails/delivarydetails.dart';
import 'package:ecommerce/model/reviewcartmodel.dart';
import 'package:ecommerce/provider/reviewcartprovider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:provider/provider.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  ReviewCartProvider? provider;
  FirebaseAuth mAuth=FirebaseAuth.instance;
  List<ReviewCartModel>? dddd;
  //var user=;
  @override
  Widget build(BuildContext context) {
     provider=Provider.of(context);
     provider!.getReviewCartData();
     dddd=provider!.getAllReviewcartList;
     //var hh= provider!.getTotalPrice();

    // print(provider!.getTotalPrice());



    return Scaffold(
      body:SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.black12,
                height: 300,
                width: 500,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection("CartItem").doc(mAuth.currentUser!.email).collection("item").snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if(snapshot.hasError)
                      {
                        return Text("Somethimg error");
                      }
                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (BuildContext context,index){
                          DocumentSnapshot dc=snapshot.data!.docs[index];
                          return Card(
                            elevation: 5.0,
                            child: ListTile(
                              title: Text(dc["name"]),
                              //subtitle: Text(dc["price"]),
                              trailing: GestureDetector(
                                child: CircleAvatar(
                                  child:Icon(Icons.delete),
                                ),
                                onTap: (){
                                  FirebaseFirestore.instance.collection("CartItem").doc(mAuth.currentUser!.email).collection("item").doc(dc.id).delete();
                                },
                              ),

                            ),
                          );
                        });
                  },

                ),
              ),

              Container(
                height: 200,
                width: 500,

                child: ListView.builder(
                    itemCount:provider!.reviewcartList!.length ,

                    itemBuilder: (context,index){
                      ReviewCartModel model=provider!.reviewcartList![index];
                      return Container(
                        child: Column(
                          children: [
                            Text(model.cartName!),
                            Text(model.cartCount!)

                          ],
                        )
                      );
                    }),



              ),


              Row(
                children: [
                  Text(
                   "${provider!.getTotalPrice()}"
                  ),

                  MaterialButton(
                      child:Text("Add Address")   ,
                      onPressed: () {
                       if(dddd!.isEmpty){
                          Fluttertoast.showToast(
                             msg: "This is Center Short Toast"

                         );
                        }


                          Navigator.push(context, MaterialPageRoute(builder: (_)=>DelivaryDetails()));




                      })
                ],
              )
            ],
          ),
        ),
      ) ,
    );
  }
}
