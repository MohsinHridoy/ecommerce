import 'dart:ffi';

import 'package:flutter/material.dart';

class AddressModel{
  String? area;
  String? city;
  double latitude;
  double longitude;
  String? mobileNumber;
  String? myType;
  String? streetNumber;
  String? location;


  AddressModel({
    this.area,
    this.city,
    required this.latitude,
    required this.longitude,
    this.mobileNumber,
    this.myType,
    this.streetNumber,
    this.location,
});

}