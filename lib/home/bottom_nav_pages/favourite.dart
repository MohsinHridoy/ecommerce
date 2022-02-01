import 'package:flutter/material.dart';


class Favourite extends StatefulWidget {
  @override
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child:OutlinedButton(
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

      ),
    );
  }
}
