

class ReviewCartModel{
  String? id;
  String? cartName;
  String? cartPrice;
  String? cartCount;
  bool? isAdd;

  ReviewCartModel({
    this.id,
    this.cartName,
    this.cartPrice,
    this.cartCount,
    this.isAdd
});


 static ReviewCartModel fromJson(Map<String,dynamic> json )=>ReviewCartModel(
    id:json["id"],
    cartName:json["productname"],
    cartPrice:json["productprice"],
    cartCount:json["productimage"],


  );


  Map<String,dynamic> toJson(){
    return
      {
        "id":id,
        "cartName":cartName,
        "cartPrice":cartPrice,
        "cartCount":cartCount,
        "isAdd":true

      };

  }

}