import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/model/addressmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:location/location.dart';

class CheckOutProvider with ChangeNotifier {
  TextEditingController mobileNo = TextEditingController();
  TextEditingController street = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController area = TextEditingController();
  //TextEditingController setLocation = TextEditingController();
  LocationData? setLocation;

  validator(context,myType) async {
    if (mobileNo.text.isEmpty) {
      Fluttertoast.showToast(msg: "Please enter mobile number");
    } else if (street.text.isEmpty) {
      Fluttertoast.showToast(msg: "Please enter street number");
    } else if (city.text.isEmpty) {
      Fluttertoast.showToast(msg: "Please enter city");
    } else if (location.text.isEmpty) {
      Fluttertoast.showToast(msg: "Please enter location");
    } else if (area.text.isEmpty) {
      Fluttertoast.showToast(msg: "Please enter area");
    } else if (setLocation!.longitude == null) {
      Fluttertoast.showToast(msg: "Please set location");
    }


    /* else if (setLocation.text.isEmpty) {
      Fluttertoast.showToast(msg: "Please enter setLocation");
    }*/ else {
      await FirebaseFirestore.instance
          .collection("AddDelivaryAddress")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        "mobileNumber": mobileNo.text,
        "streetNumber": street.text,
        "city": city.text,
        "location": location.text,
        "area": area.text,
        "longitude": setLocation!.longitude,
        "latitude": setLocation!.latitude,
        "myType": myType.toString(),
      }).then((value) async {
        await Fluttertoast.showToast(msg: "add your address");
        Navigator.of(context).pop();
        notifyListeners();
      });
    }

    notifyListeners();
  }


  List<AddressModel > addresslist=[];
  AddressModel? addressModel;


  getAdress() async{
    List<AddressModel > newList=[];
    DocumentSnapshot ds= await FirebaseFirestore.instance.collection("AddDelivaryAddress").doc(FirebaseAuth.instance.currentUser!.uid).get();

    if(ds.exists){
      addressModel=AddressModel(
        area: ds.get("area"),
        city: ds.get("city"),
        latitude: ds.get("latitude"),
        longitude: ds.get("longitude"),
        myType: ds.get("myType"),
        streetNumber: ds.get("streetNumber"),
          mobileNumber: ds.get("mobileNumber"),
        location: ds.get("location"),


      );

      newList.add(addressModel!);
      notifyListeners();


    }

    addresslist=newList;
    notifyListeners();
  }


  get getAdressModelList{
    return addresslist;
}
  
}




















