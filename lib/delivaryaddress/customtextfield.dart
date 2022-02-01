import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  TextEditingController? textEditingController;
  String? labtext;
  TextInputType? keyboardType;
  CustomTextField({
    this.labtext,
    this.keyboardType,
    this.textEditingController
  });


  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
          label:Text(labtext!)
      ),
      keyboardType:keyboardType ,
    );
  }
}
