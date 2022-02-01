import 'package:flutter/material.dart';

class OrderItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: Image.network("https://firebasestorage.googleapis.com/v0/b/ecommerce-7bdb7.appspot.com/o/carousel-image%2Fphoto-1505740420928-5e560c06d30e.jpg?alt=media&token=e2ef16b0-f68d-491a-8241-7cedbf54344d"),
        title: Row(
          children: [
            Text("food name"),
            Text("300 doller"),
            Text("5"),
          ],
        ),

      ),
    );
  }
}
