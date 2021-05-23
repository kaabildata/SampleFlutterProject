import 'package:flutter/material.dart';

class ReusableTextfield extends StatelessWidget {
  final String hintText;
  final Widget icon;
  final String value;

  ReusableTextfield({@required this.hintText, this.icon, this.value});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Material(
        elevation: 8,
        color: Colors.indigo[100],
        child: TextField(
          onChanged: (value) {
            value = value;
          },
          decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              hintText: hintText,
              suffixIcon: icon),
        ),
      ),
    );
  }
}
