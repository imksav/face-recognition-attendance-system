import 'package:flutter/material.dart';

import '../libraries.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blue,
      elevation: 0.0,
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.menu),
        iconSize: 28.0,
      ),
      actions: <Widget>[
        IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SigninScreen()));
          },
          icon: const Icon(Icons.logout_rounded),
          iconSize: 28.0,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
