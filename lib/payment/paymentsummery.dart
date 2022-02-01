import 'package:ecommerce/payment/orderitem.dart';
import 'package:flutter/material.dart';

class PaymentSummery extends StatefulWidget {
  @override
  _PaymentSummeryState createState() => _PaymentSummeryState();
}
enum PaymentOptions{
  Online,
  Home
}
class _PaymentSummeryState extends State<PaymentSummery> {
var myPayment=PaymentOptions.Online;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
              title:Text("Payment Summery")
          ),
      body: ListView(
        children: [
          ListTile(
            title: Text("First Name & Last Name"),
            subtitle: Text("Address will be shown here"),

          ),

          Divider(
            height: 5,
          ),

          ExpansionTile(

              title: Text("Order item "),
            children: [
              OrderItem(),
              OrderItem(),
              OrderItem(),
              OrderItem(),
              OrderItem(),
            ],

          ),

          ListTile(
            title: Text("Sub Total"),
            trailing: Text("200 doller"),

          ),
          ListTile(
            title: Text("Discount "),
            trailing: Text("100 doller"),

          ),

          ListTile(
            title: Text("Shipping"),
            trailing: Text("200 doller"),

          ),

          Text("Payment Options"),

          RadioListTile(
              value: PaymentOptions.Online,
              groupValue: myPayment,
              title:Text("Online") ,
              onChanged: (PaymentOptions? vv){
                setState(() {
                  myPayment=vv!;
                });
              }),

          RadioListTile(
              value: PaymentOptions.Home,
              groupValue: myPayment,
              title:Text("Home") ,
              onChanged: (PaymentOptions? vv){
                setState(() {
                  myPayment=vv!;
                });
              }),


        ],
      ),

      bottomNavigationBar: ListTile(
        title: Text("Total Amount"),
        subtitle: Text("3000"),
        trailing: Container(
          height: 30.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Place Order"),
          ),
          decoration: BoxDecoration(
            color: Colors.purple,
            borderRadius: BorderRadius.circular(20.0)
          ),
        ),
      ),

    );
  }
}
