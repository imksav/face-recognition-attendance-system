import 'package:flutter/material.dart';


class DemoHomeScreen extends StatefulWidget {
  const DemoHomeScreen({Key? key}) : super(key: key);

  @override
  State<DemoHomeScreen> createState() => _DemoHomeScreenState();
}

class _DemoHomeScreenState extends State<DemoHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome"),
        centerTitle: true,
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              child: Image.asset("assets/images/sikshyatechnology.jpg"),
            ),
            Text("Welcome Back"),
            SizedBox(height: 10.0),
            Text("Name: "),
            SizedBox(height: 10.0),
            Text("Email: "),
            SizedBox(height: 10.0),
          ],
        ),
      )),
    );
  }
}
