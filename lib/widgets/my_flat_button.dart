import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyFlatButton extends StatelessWidget {
  final Text text;
  Color btnColor;
  Icon icon;
  final onPressed;
  MyFlatButton({
    required this.text,
    required this.btnColor,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return FlatButton(
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 20.0,
      ),
      splashColor: Colors.purple,
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => onPressed));
      },
      color: btnColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Row(
        children: [
          icon,
          SizedBox(width: 5.0),
          text,
        ],
      ),
      textColor: Colors.white,
    );
  }
}
