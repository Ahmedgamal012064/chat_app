import 'package:flutter/material.dart';

class myTextField extends StatelessWidget {
  final String hinttext;
  final bool obscure;
  final dynamic keyboardType;
  final dynamic onChange;

  const myTextField(this.obscure,this.keyboardType,this.hinttext,this.onChange);

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscure,
      keyboardType: keyboardType,
      textAlign: TextAlign.center,
      onChanged: onChange,
      decoration: InputDecoration(
        hintText: hinttext,
        contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).accentColor,width: 1),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).primaryColor,width: 2),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    );
  }
}
