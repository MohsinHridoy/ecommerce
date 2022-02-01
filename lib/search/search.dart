import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String? value;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              TextFormField(
                onChanged: (val){
                  setState(() {
                    value=val;
                  //  print(value);
                  });
                },
                decoration:InputDecoration(
                  hintText: "Search"
                ) ,
              ),

              Expanded(
                child: Container(
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance.collection("products").where("productname",isEqualTo:value ).snapshots(),
                    builder:(BuildContext context,AsyncSnapshot<QuerySnapshot>snapshot)
                    {
                      if(snapshot.hasError)
                        {
                          return Center(child: Text("Something has error"));
                        }
                      if(snapshot.connectionState==ConnectionState.waiting)
                        {
                          return Center(child: Text("Loading"));
                        }

                      return ListView(
                        children:snapshot.data!.docs.map((DocumentSnapshot document) {

                          Map<String,dynamic> data=document.data() as Map<String,dynamic>;

                          return ListTile(
                            title: Text(data['productname']),
                            leading: Image.network(data['productimage'][0]),

                          );
                        }).toList() 
                      );
                    },
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
