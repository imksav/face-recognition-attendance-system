// import 'package:attendance_system/screens/login.dart';
// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:fluttertoast/fluttertoast.dart';

// class Register extends StatefulWidget {
//   const Register({Key? key}) : super(key: key);

//   @override
//   State<Register> createState() => _RegisterState();
// }

// class _RegisterState extends State<Register> {
//   TextEditingController user = TextEditingController();
//   TextEditingController pass = TextEditingController();

//   Future register() async {
//     var url = "http://192.168.2.106/flutter_signup_login/register.php";
//     var response = await http.post(Uri.parse(url),
//         body: {"username": user.text, "password": pass.text});

//     var data = json.decode(response.body);
//     print("================");
//     print(data);
//     print("================");
//     if (data == "Success ") {
//       Fluttertoast.showToast(
//         msg: "User already exist!",
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.CENTER,
//         timeInSecForIosWeb: 1,
//         backgroundColor: Colors.red,
//         textColor: Colors.white,
//         fontSize: 16.0,
//       );
//       // Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
//     } else {
//       Fluttertoast.showToast(
//         msg: "Registration Successfull!",
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.CENTER,
//         timeInSecForIosWeb: 1,
//         backgroundColor: Colors.green,
//         textColor: Colors.white,
//         fontSize: 16.0,
//       );
//       Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Register"),
//       ),
//       body: Container(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Text("Register"),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: TextField(
//                 controller: user,
//                 decoration: InputDecoration(
//                     labelText: 'Username',
//                     prefixIcon: Icon(Icons.person),
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10.0))),
//               ),
//             ),
//             SizedBox(height: 20.0),
//             Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: TextField(
//                 controller: pass,
//                 obscureText: true,
//                 decoration: InputDecoration(
//                     labelText: 'Password',
//                     prefixIcon: Icon(Icons.lock),
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10.0))),
//               ),
//             ),
//             SizedBox(height: 10.0),
//             Column(
//               children: [
//                 MaterialButton(
//                   color: Colors.green,
//                   child: Text("Register"),
//                   onPressed: () {
//                     register();
//                   },
//                 ),
//                 SizedBox(height: 10.0),
//                 MaterialButton(
//                   color: Colors.red,
//                   child: Text("Already a member?"),
//                   onPressed: () {
//                     Navigator.push(context,
//                         MaterialPageRoute(builder: (context) => Login()));
//                   },
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
