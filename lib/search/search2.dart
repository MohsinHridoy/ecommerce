
import 'package:ecommerce/model/latestproduct.dart';
import 'package:flutter/material.dart';

class SearchTwo extends StatefulWidget {
  List<LatestProduct>? product;

  SearchTwo({
   required this.product,
});


  @override
  _Search2State createState() => _Search2State();
}

class _Search2State extends State<SearchTwo> {

  @override
  void initState() {
    // TODO: implement initState
    print(widget.product!.length);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:Text("TestINg"),
      ),

      body:Container(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: widget.product!.length,
                //shrinkWrap: true,

                  itemBuilder: (context,index){
                    var ss=widget.product![index];
                    return  SampleItem(
                      name: ss.name,
                    );

                    /*Container(
                      child: Text(ss.name),
                    );*/


                    /* Column(
                      children: widget.product!.map((e) => SampleItem(
                          name: e.name,

                      )).toList(),

                    );*/
                  }),
            )
          ],
        ),
      )
    );
  }
}



class SampleItem extends StatelessWidget {

   String? name;

   SampleItem({
     this.name
});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.purpleAccent,
      child: Column(
        children: [
          Text(
            name!,
            style: TextStyle(
              fontSize: 20,
              color: Colors.blue
            ),
          ),

          Row(
            children: [
              Text("50grm"),
            ],
          )
        ],
      ),
    );
  }
}
