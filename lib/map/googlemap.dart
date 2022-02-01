import 'package:ecommerce/provider/checkoutprovider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';



class CustomGoogleMap extends StatefulWidget {
  @override
  _CustomGoogleMapState createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(23.828336, 90.366348),
    zoom: 14.4746,
  );
  GoogleMapController? controller;
  Location location=Location();
  void OnMapCreated(GoogleMapController value)
  {

    controller=value;

    location.onLocationChanged.listen((event) {
      controller!.animateCamera(CameraUpdate.newCameraPosition(
             CameraPosition(
                 target: LatLng(event.latitude!,event.longitude!),
               zoom: 52.00,

             )
      ));
    });
  }
  @override
  Widget build(BuildContext context) {
    CheckOutProvider provider=Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Map Location"),
      ),

      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: _kGooglePlex,
              onMapCreated: OnMapCreated,
              myLocationEnabled: true,


            ),

            Positioned(
              bottom: 20.0,
              child: RaisedButton(
                child: Text(
                  "Add Location"
                ),
                  onPressed: () async {

                  location.getLocation().then((value) {
                    setState(() {
                      provider.setLocation=value;

                    });

                  });

                  Navigator.of(context).pop();

                  }),
            )
          ],
        ),
      ),
    );
  }
}
