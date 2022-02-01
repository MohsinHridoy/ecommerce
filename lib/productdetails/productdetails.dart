import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:ecommerce/model/latestproduct.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatefulWidget {
  var product;


  ProductDetails(
  {
    this.product,

}
      );
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  var index;
  bool isFavourite=true;



  Future addToCart() async{
    FirebaseAuth mAuth=FirebaseAuth.instance;
    var user=mAuth.currentUser!.email;
    CollectionReference collectionReference=FirebaseFirestore.instance.collection("CartItem");

    return collectionReference.doc(user).collection("item").doc().set({
      "name":widget.product["productname"],
      "price":widget.product["productprice"],
    });
  }

  Future addToFavourite() async{
    FirebaseAuth mAuth=FirebaseAuth.instance;
    var user=mAuth.currentUser!.email;
    CollectionReference collectionReference=FirebaseFirestore.instance.collection("Favourite");

    return collectionReference.doc(user).collection("item").doc(DateTime.now().second.toString()+DateTime.now().minute.toString()).set({
      "name":widget.product["productname"],
      "price":widget.product["productprice"],
      "image":widget.product["productimage"],
      "dateTime":DateTime.now().second.toString()+DateTime.now().minute.toString()
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection("Favourite").doc(FirebaseAuth.instance.currentUser!.email).collection("item").where("name",isEqualTo: widget.product["productname"]).snapshots(),
            builder: (context,AsyncSnapshot snapshot) {
              //DocumentSnapshot dc=snapshot.data!.docs[index];

              //  DocumentSnapshot dc=snapshot.data;
              if(snapshot.data==null)
                {
                  return Text("sss");
                }
              return IconButton(

                icon: snapshot.data.docs.length==0? Icon(Icons.favorite_outline):Icon(Icons.favorite),
               // tooltip: 'Open shopping cart',
                onPressed: () {
                  snapshot.data.docs.length==0?
                /*  setState(() {
                    isFavourite=!isFavourite;

                  });*/
                 // isFavourite?

                      addToFavourite():Text("sss");


                  //FirebaseFirestore.instance.collection("Favourite").doc(FirebaseAuth.instance.currentUser!.email).collection("item").doc(snapshot.data.doc[index]["dateTime"]).delete();

                /*  var collection = FirebaseFirestore.instance.collection('users');

                  var snapshot = await collection.where('age', isGreaterThan: 20);*/




                  /*  FirebaseAuth mAuth=FirebaseAuth.instance;
                      var user=mAuth.currentUser!.email;
                      FirebaseFirestore.instance.collection("Favourite").doc(user).collection("item").doc(dc.id).delete();
                      DocumentReference doc_ref=Firestore.instance.collection("board").document(doc_id).collection("Dates").document();*/
                    /*  FirebaseFirestore.instance.collection("Favourite").doc(FirebaseAuth.instance.currentUser!.email).collection("item").where("name",isEqualTo: widget.product["productname"]).get().then((value){
                        value.docs.forEach((element) {
                          FirebaseFirestore.instance.collection("item").doc(element.id).delete();
                        });
                      });*/



                  // handle the press
                }
              );
            }
          ),

          IconButton(
            icon:isFavourite?Icon(Icons.done) :Icon(Icons.email), onPressed: () {
              setState(() {
                isFavourite=!isFavourite;

              });
          },
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              height:200 ,
              child: CarouselSlider(
                options: CarouselOptions(
                    autoPlay: true,

                    onPageChanged:(index1,CarouselPageChangedReason){
                      setState(() {
                        index=index1;
                      });
                    }
                  //   height: 100.0

                ),
                items: widget.product["productimage"].map<Widget>((i) {
                  return Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(image:NetworkImage(i),fit: BoxFit.fitHeight),

                      ));
                }).toList(),
              ),


            ),

         /*  DotsIndicator(
              dotsCount: widget.product["productimage"].toString()==0?1:widget.product["productimage"],
              position: index,
              decorator: DotsDecorator(
                color: Colors.black87, // Inactive color
                activeColor: Colors.redAccent,
              ),
            ),*/

            Text(widget.product["productname"]),
            Text(widget.product["productprice"]),

            RaisedButton(onPressed: (){
              addToCart();
            })



          ],
        ),
      ),
    );
  }
}
