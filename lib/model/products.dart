


class Products{
  String id;
  String productname;
  String productprice;
  var productimage;

  Products(
  {
    required this.id,
    required this.productname,
    required this.productprice,
    required this.productimage,


}
 );


  static Products fromJson(Map<String,dynamic> json )=>Products(
    id:json["id"],
    productname:json["productname"],
    productprice:json["productprice"],
    productimage:json["productimage"],

  );


}