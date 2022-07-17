import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyFlatButton extends StatelessWidget {
  final Text text;
  Color btnColor;
  Icon icon;
  // ignore: prefer_typing_uninitialized_variables
  final onPressed;
  // ignore: use_key_in_widget_constructors
  MyFlatButton({
    required this.text,
    required this.btnColor,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FlatButton(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 7.0,
        ),
        splashColor: Colors.purple,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => onPressed));
        },
        color: btnColor,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        // ignore: sort_child_properties_last
        child: Row(
          children: [
            icon,
            text,
          ],
        ),
        textColor: Colors.white,
      ),
    );
  }
}
