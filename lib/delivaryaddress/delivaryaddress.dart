import 'package:ecommerce/delivaryaddress/customtextfield.dart';
import 'package:ecommerce/provider/checkoutprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DelivaryAddress extends StatefulWidget {
  @override
  _DelivaryAddressState createState() => _DelivaryAddressState();
}

enum AddressType { Home, Work, Others }

class _DelivaryAddressState extends State<DelivaryAddress> {
  var myType = AddressType.Home;

  CheckOutProvider? checkOutProvider;

  @override
  Widget build(BuildContext context) {
    checkOutProvider=Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Delivary Address"),
      ),
      body: ListView(
        children: [
          CustomTextField(labtext: "Mobile no",textEditingController: checkOutProvider!.mobileNo,),
          CustomTextField(labtext: "Street",textEditingController: checkOutProvider!.street,),
          CustomTextField(labtext: "City",textEditingController: checkOutProvider!.city,),
          CustomTextField(labtext: "Location",textEditingController: checkOutProvider!.location,),
          CustomTextField(labtext: "Area",textEditingController: checkOutProvider!.area,),
          InkWell(
            child: Text("set Location"),
            onTap: () {},
          ),
          ListTile(
            title: Text("Address Type *"),
          ),
          RadioListTile(
              value: AddressType.Work,
              groupValue: myType,
              title: Text("Work"),
              onChanged: (AddressType? value) {
                setState(() {
                  myType = value!;
                });
              }),
          RadioListTile(
              value: AddressType.Home,
              groupValue: myType,
              title: Text("Home"),
              onChanged: (AddressType? value) {
                setState(() {
                  myType = value!;
                });
              }),
          RadioListTile(
              value: AddressType.Others,
              groupValue: myType,
              title: Text("Others"),
              onChanged: (AddressType? value) {
                setState(() {
                  myType = value!;
                });
              }),
        ],
      ),
      bottomNavigationBar: Container(
        height: 30,
        child: GestureDetector(
            child: Text("Add Address"),

          onTap: (){
            print("okk111111111111111111");

            checkOutProvider!.validator(context,myType) ;
            print("okk");
          },
        ),
      ),
    );
  }
}
