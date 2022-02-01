
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/model/reviewcartmodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class ReviewCartProvider with ChangeNotifier{

  List<ReviewCartModel>?  reviewcartList;



  Future addReviewCartData({String? cartId,String? cartName,String? cartPrice,String? cartCount,bool? isAdd}) async{
    
   final reviewCart= FirebaseFirestore.instance.collection("ReciewCartData").doc(FirebaseAuth.instance.currentUser!.email).collection("MyCarts").doc(cartId);



      final  addReviewCartItem=ReviewCartModel(
       id:cartId,
      cartName:cartName,
      cartPrice:cartPrice,
      cartCount:cartCount,
        isAdd: true

    );

      final json=addReviewCartItem.toJson();

      var add=await reviewCart.set(json);

      return add;





  }



  getReviewCartData() async{

    List<ReviewCartModel> newcartItem=[];


    QuerySnapshot querySnapshot=await  FirebaseFirestore.instance.collection("ReciewCartData").doc(FirebaseAuth.instance.currentUser!.email).collection("MyCarts").get();

 querySnapshot.docs.forEach((element) {
   ReviewCartModel  mm=ReviewCartModel(
     id:element.get("id"),
     cartName: element.get("cartName"),
     cartPrice: element.get("cartPrice"),
     cartCount: element.get("cartCount")

   );

    newcartItem.add(mm);



 } );

    reviewcartList=newcartItem;

    notifyListeners();

  }


  get getAllReviewcartList{
    return reviewcartList;
  }

  deleteReviewCart({String? cartId}) {
    FirebaseFirestore.instance.collection("ReciewCartData").doc(
        FirebaseAuth.instance.currentUser!.email).collection("MyCarts").doc(
        cartId).delete();
    notifyListeners();
  }



    updateReviewCart({String? cartId,String? cartName,String? cartPrice,String? cartCount}) async{

      final reviewCart= FirebaseFirestore.instance.collection("ReciewCartData").doc(FirebaseAuth.instance.currentUser!.email).collection("MyCarts").doc(cartId);



      final  addReviewCartItem=ReviewCartModel(
          id:cartId,
          cartName: cartName,
          cartPrice: cartPrice,
          cartCount:cartCount,

      );

      final json=addReviewCartItem.toJson();

      var update=await reviewCart.update(json);

      return update;


      notifyListeners();


    }


  getTotalPrice(){
     double totalList=0.0;
     getAllReviewcartList!.forEach((element) {
       print(element.cartPrice);

       totalList+=double.parse(element.cartPrice);

      // print(totalList);

     } );

     print(totalList);

     return totalList;

    // notifyListeners();


  }

}