

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/model/latestproduct.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class ProductProvider with ChangeNotifier{

   LatestProduct? latestProduct;
  List<LatestProduct> allLatestProduct=[];

    fetchLatestProductData() async{
      List<LatestProduct> newList=[];

      QuerySnapshot ds= await FirebaseFirestore.instance.collection("Latest").get();

      ds.docs.forEach((element) {
        latestProduct=LatestProduct(id: element.get("id"), name:element.get("name") , price:element.get("price"),unit: element.get("unit") );

        newList.add(latestProduct!);

        

      });

      allLatestProduct=newList;
      notifyListeners();

    }

   List<LatestProduct> get getlatestProductList {
     return allLatestProduct;
   }


   List<String> alertItem = [
     "1",
     "1",
     "1",
     "1",
     "1",
     "1",
     "1",
     "1",
     "1",
     "1",
     "1",
     "1",
     "1",
     "1",
     "1",
   ];

    List<String> get getALertItem{
      return alertItem;
    }

}