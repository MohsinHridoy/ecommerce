import 'package:ecommerce/delivaryaddress/delivaryaddress.dart';
import 'package:ecommerce/map/googlemap.dart';
import 'package:ecommerce/payment/paymentsummery.dart';
import 'package:ecommerce/provider/checkoutprovider.dart';
import 'package:ecommerce/widget/singlechilddelivaryitem.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DelivaryDetails extends StatefulWidget {
  @override
  _DelivaryDetailsState createState() => _DelivaryDetailsState();
}

class _DelivaryDetailsState extends State<DelivaryDetails> {
 /* List<Widget> adress=[
   *//*SingleChildDelivaryItem(
      title: "as",
      Adress: "sssssss",
      AdressType: "22",
      number: "11",
    ) ,*//*
  ];*/
  @override
  Widget build(BuildContext context) {
    CheckOutProvider checkOutProvider=Provider.of<CheckOutProvider>(context);
    checkOutProvider.getAdress();
    print(checkOutProvider.getAdressModelList);
    print(FirebaseAuth.instance.currentUser!.uid);
    return Scaffold(
      appBar: AppBar(
        title:Text("Add Adddress"),
      ),

      floatingActionButton: FloatingActionButton(
          child:Icon(
            Icons.add
          ),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (_)=>CustomGoogleMap()));
        },
      ),

      body: ListView(
        children: [
          ListTile(
            title: Text("Delivary Details"),
          ),
          Divider(
            height: 5.00,
          ),
          checkOutProvider.getAdressModelList.isEmpty?

              Container(
                child:  Text("No DAta")

              ):

          Column(
            children:checkOutProvider.getAdressModelList.map<Widget>((e) {
                    return SingleChildDelivaryItem(
                      title: e.city,
                      Adress: e.streetNumber,
                      AdressType: e.myType=="AddressType.Others"?"Others":e.myType=="AddressType.Home"?"Home":"Work",
                      number: e.mobileNumber,
                    ) ;
            }).toList()/* [

              SingleChildDelivaryItem(
                title: "as",
                Adress: "sssssss",
                AdressType: "22",
                number: "11",
              ) ,
            ],*/
          ),
        ],
      ),

      bottomNavigationBar: GestureDetector(
        onTap: (){
          checkOutProvider.getAdressModelList==0?
          Navigator.push(context, MaterialPageRoute(builder: (_)=>DelivaryAddress())):          Navigator.push(context, MaterialPageRoute(builder: (_)=>PaymentSummery()));


        },
        child: Container(
          height:45 ,
          child:  checkOutProvider.getAdressModelList==0? Text("Add Address"):Text("Add Payment"),
          decoration: BoxDecoration(
            color: Colors.grey
          ),
        ),
      ),
    );
  }
}
