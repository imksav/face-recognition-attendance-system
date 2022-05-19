// import 'package:flutter/material.dart';

// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:fluttertoast/fluttertoast.dart';

// class Login extends StatefulWidget {
//   const Login({Key? key}) : super(key: key);

//   @override
//   State<Login> createState() => _LoginState();
// }

// class _LoginState extends State<Login> {
//   TextEditingController user = TextEditingController();
//   TextEditingController pass = TextEditingController();

//   Future login() async {
//     var url = "http://192.168.2.106/flutter_signup_login/login.php";
//     var response = await http.post(Uri.parse(url), body: {
//       "username": user.text,
//       "password": pass.text,
//     });
//     var data = json.decode(response.body);
//     print("================");
//     print(data);
//     print("================");

//     if (data == "Success") {
//       Fluttertoast.showToast(
//         msg: "Login Successful!",
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.CENTER,
//         timeInSecForIosWeb: 1,
//         backgroundColor: Colors.green,
//         textColor: Colors.white,
//         fontSize: 16.0,
//       );
//       Navigator.push(
//           context, MaterialPageRoute(builder: (context) => HomeScreen()));
//     } else {
//       Fluttertoast.showToast(
//         msg: "Username or Password Incorrect!",
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.CENTER,
//         timeInSecForIosWeb: 1,
//         backgroundColor: Colors.red,
//         textColor: Colors.white,
//         fontSize: 16.0,
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Login"),
//       ),
//       body: Container(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: Text("Login"),
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
//                 obscureText: false,
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
//                   child: Text("Login"),
//                   onPressed: () {
//                     login();
//                   },
//                 ),
//                 SizedBox(height: 10.0),
//                 MaterialButton(
//                   color: Colors.red,
//                   child: Text("Create a new account?"),
//                   onPressed: () {
//                     Navigator.push(context,
//                         MaterialPageRoute(builder: (context) => Register()));
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
