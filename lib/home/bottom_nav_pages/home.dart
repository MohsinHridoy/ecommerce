import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:ecommerce/home/bottom_nav_pages/cart.dart';
import 'package:ecommerce/home/bottom_nav_pages/favourite.dart';
import 'package:ecommerce/model/latestproduct.dart';
import 'package:ecommerce/model/products.dart';
import 'package:ecommerce/productdetails/productdetails.dart';
import 'package:ecommerce/provider/productprovider.dart';
import 'package:ecommerce/provider/reviewcartprovider.dart';
import 'package:ecommerce/search/search.dart';
import 'package:ecommerce/search/search2.dart';
import 'package:ecommerce/search/search2.dart';
import 'package:ecommerce/widget/homedrawer.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int count = 1;

  var _firestoreInstance = FirebaseFirestore.instance;
  ProductProvider? productProvider;

  List<String> _carouselImages = [];
  var productList = [];
  var index = 0;
  TextEditingController _searchController = TextEditingController();

  fetchFromFireStore() async {
    QuerySnapshot qn =
        await _firestoreInstance.collection("carousel-slider").get();

    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _carouselImages.add(
          qn.docs[i]["imagepath"],
        );
      }
    });

    return qn.docs;
  }

  Stream<List<Products>> fetchProductsFromFirebase() {
    return FirebaseFirestore.instance.collection("products").snapshots().map(
        (snapshot) => snapshot.docs
            .map((docs) => Products.fromJson(docs.data()))
            .toList());
  }

  fetchProductsFromFiresStore() async {
    QuerySnapshot productSnap =
        await _firestoreInstance.collection("products").get();

    for (int i = 0; i < productSnap.docs.length; i++) {
      productList.add({
        "productimage": productSnap.docs[i]["productimage"],
        "productname": productSnap.docs[i]["productname"],
        "productprice": productSnap.docs[i]["productprice"],
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState

    ProductProvider productProvider = Provider.of(context, listen: false);
    productProvider.fetchLatestProductData();

    fetchFromFireStore();
    fetchProductsFromFiresStore();

    // print(productList);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of(context);
    return Scaffold(
      drawer: HomeDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        readOnly: true,
                        //keyboardType:false,
                        // controller: _searchController,
                        decoration: InputDecoration(
                          hintText: "search",
                        ),

                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Search()));
                        },
                      ),
                    ),
                    Container(
                      height: 46,
                      width: 46,
                      child: Icon(Icons.search),
                    )
                  ],
                ),
                SizedBox(height: 10.0),
                Container(
                  height: 300,
                  child: Column(
                    children: [
                      Container(
                        height: 200,
                        child: CarouselSlider(
                          options: CarouselOptions(
                              autoPlay: true,
                              onPageChanged:
                                  (index1, CarouselPageChangedReason) {
                                setState(() {
                                  index = index1;
                                });
                              }
                              //   height: 100.0

                              ),
                          items: _carouselImages.map((i) {
                            return Container(
                                decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(i),
                                  fit: BoxFit.fitHeight),
                            ));
                          }).toList(),
                        ),
                      ),
                      DotsIndicator(
                        dotsCount:
                            _carouselImages == 0 ? 1 : _carouselImages.length,
                        position: index.toDouble(),
                        decorator: DotsDecorator(
                          color: Colors.black87, // Inactive color
                          activeColor: Colors.redAccent,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 200,
                  child: StreamBuilder<List<Products>>(
                      stream: fetchProductsFromFirebase(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text("It has some error");
                        } else if (snapshot.hasData) {
                          final users = snapshot.data!;

                          print(snapshot.data!.length);

                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: users.length,
                            itemBuilder: (context, index) {
                              print(users[index].productname);
                              return Container(
                                child: Text(users[index].productprice),
                              );
                            },
                          );
                        } else
                          return Text("");
                      }),
                ),
                Row(
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Latest Product"),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchTwo(
                                      product:
                                          productProvider!.getlatestProductList,
                                    )),
                          );

                          print("clickkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk");
                        },
                        child: Text("View All")),
                  ],
                ),
                SingleChildScrollView(
                    child: Row(
                  children: productProvider!.getlatestProductList
                      .map((e) => Counter(e))
                      .toList(),
                )),

                Row(
                  children: [
                    OutlinedButton(
                        child:Text("Alert Dialog") ,
                        onPressed: (){
                          showDialog(
                            context: context,
                            barrierDismissible: false, // user must tap button!
                            builder: (BuildContext context) {
                              return AlertDialog(
                                  content: ConstrainedBox(
                                    constraints: const BoxConstraints(maxHeight: 200, minHeight: 100),
                                    child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: 5,
                                        itemBuilder: (context, index) => Text(index.toString())),
                                  ));
                            },
                          );

                        }),
                  ],
                )

                /* Container(
                   height: 200,
                   child: ListView.builder(
                     scrollDirection: Axis.horizontal,
                     padding: const EdgeInsets.all(8),
                     itemCount: productList.length,
                     itemBuilder: (BuildContext context, int index) {
                     return GestureDetector(
                       onTap:(){
                         Navigator.push(context, MaterialPageRoute(builder: (_)=>ProductDetails(productList[index])));
                       }
                       ,
                       child: Container(
                       height: 150,
                        child:Column(

                          children: [

                            Container(
                                height: 100,

                                child:
                              Image.network(productList[index]["productimage"][0])

                          ) ,

                           Center(child: Text('Entry ${productList[index]["productname"]}')),

                            Text('${productList[index]["productprice"]}'),

                          ],

                    ),
                    // color: Colors.amber[colorCodes[index]],
                   ),
                     );
                    }
                   ),
                 ),*/
              ],
            ),
          ),
        ),
      ),
    );


  }




  Widget buildProducts(Products p) => ListTile(
        title: Text(p.productname),
        subtitle: Text(p.id),
      );

  Widget Counter(LatestProduct e) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => Favourite()));
      },
      child: Container(
          height: 50,
          width: 127,
          color: Colors.blue,
          child: Column(
            children: [
              Text(e.name),
              Count(
                cartId: e.id,
                cartName: e.name,
                // cartCount:e.price ,
                cartPrice: e.price.toString(),
                unit: e.unit,
              )
            ],
          )),
    );
  }
}

class Count extends StatefulWidget {
  String? cartId;
  String? cartName;
  String? cartPrice;
  List? unit;

  //String? cartCount;

  Count({this.cartId, this.cartName, this.cartPrice, this.unit
      //this.cartCount
      });

  @override
  _CountState createState() => _CountState();
}

class _CountState extends State<Count> {
  ReviewCartProvider? reviewCartProvider;
  int count = 1;
  int gram = 1;

  bool isAdd = false;

  getAndAddQuantity() {
    FirebaseFirestore.instance
        .collection("ReciewCartData")
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection("MyCarts")
        .doc(widget.cartId)
        .get()
        .then((value) => {
              if (this.mounted)
                {
                  if (value.exists)
                    {
                      setState(() {
                        count = int.parse(value.get("cartCount"));

                        isAdd = value.get("isAdd");

                        print(count);
                      })
                    }
                }
            });
  }

  @override
  Widget build(BuildContext context) {
    getAndAddQuantity();

    reviewCartProvider = Provider.of<ReviewCartProvider>(context);
    return isAdd == true
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return ListView.builder(
                            itemCount: widget.unit!.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  // setState(() {
                                  print("clickkk");
                                  gram = int.parse(widget.unit![index]);
                                  Navigator.pop(context);

                                  //  });
                                },
                                child: Container(
                                  child: Text(widget.unit![index]),
                                ),
                              );
                            });

                        /*Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        title: new Text('300'),
                        onTap: ()  {
                          setState(() {
                            gram=300;
                          });
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        title: new Text('200'),
                        onTap: () {

                          setState(() {
                            gram=200;
                          });
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        title: new Text('100'),
                        onTap: () {
                          setState(() {
                            gram=100;
                          });
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        title: new Text('50'),
                        onTap: () {
                          setState(() {
                            gram=50;
                          });
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );*/
                      });
                },
                child: Container(
                  child: Text("$gram"),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      color: Colors.purple),
                ),
              ),
              Container(
                height: 20,
                width: 65,
                child: Row(
                  children: [
                    GestureDetector(
                      child: Icon(Icons.remove),
                      onTap: () {
                        if (count == 1) {
                          setState(() {
                            isAdd = false;
                          });

                          reviewCartProvider!
                              .deleteReviewCart(cartId: widget.cartId);
                        }

                        if (count > 0) {
                          setState(() {
                            count--;
                          });
                          reviewCartProvider!.updateReviewCart(
                              cartId: widget.cartId,
                              cartName: widget.cartName,
                              cartPrice: widget.cartPrice,
                              cartCount: count.toString());
                        }
                      },
                    ),
                    Text("$count"),
                    GestureDetector(
                      child: Icon(Icons.add),
                      onTap: () {
                        setState(() {
                          count++;
                        });
                        reviewCartProvider!.updateReviewCart(
                            cartId: widget.cartId,
                            cartName: widget.cartName,
                            cartPrice: widget.cartPrice,
                            cartCount: count.toString());
                      },
                    ),
                  ],
                ),
              )
            ],
          )
        : Center(
            child: InkWell(
            child: Text("Add"),
            onTap: () {
              setState(() {
                isAdd = true;
              });

              reviewCartProvider!.addReviewCartData(
                  cartId: widget.cartId,
                  cartName: widget.cartName,
                  cartPrice: widget.cartPrice,
                  cartCount: count.toString());
            },
          ));
  }
}
