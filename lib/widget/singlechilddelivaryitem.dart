import 'package:flutter/material.dart';

class SingleChildDelivaryItem  extends StatelessWidget {

String? title;
String? Adress;
String? number;
String? AdressType;

SingleChildDelivaryItem({
this.title,
this.Adress,
this.number,
this.AdressType
});

@override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(title!),

          Container(
            decoration: BoxDecoration(
              color: Colors.yellow
            ),

            child: Text(AdressType!),
          )

        ],
      ),
    );
  }
}
