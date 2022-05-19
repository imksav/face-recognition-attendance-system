import 'package:flutter/material.dart';

import '../libraries.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  // form key
  final _formKey = GlobalKey<FormState>();

// editing controller
  final firstNameEditingController = new TextEditingController();
  final secondNameEditingController = new TextEditingController();
  final emailEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final confirmPasswordEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // first name field
    final firstNameField = TextFormField(
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.person_rounded),
          prefixIconColor: Colors.red,
          contentPadding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
          labelText: "First Name",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),

      autofocus: false,
      controller: firstNameEditingController,
      keyboardType: TextInputType.name,
      // validator: (){},
      onSaved: (value) => firstNameEditingController.text = value!,
      textInputAction: TextInputAction.next,
    );

// second name field
    final secondNameField = TextFormField(
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.person_rounded),
          prefixIconColor: Colors.red,
          contentPadding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
          // hintText: "Enter your email address",
          labelText: "Second Name",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
      autofocus: false,
      controller: secondNameEditingController,
      keyboardType: TextInputType.name,
      // validator: (){},
      onSaved: (value) => secondNameEditingController.text = value!,
      textInputAction: TextInputAction.next,
    );

    // email field
    final emailField = TextFormField(
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.email),
          prefixIconColor: Colors.red,
          contentPadding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
          // hintText: "Enter your email address",
          labelText: "Email",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
      autofocus: false,
      controller: emailEditingController,
      keyboardType: TextInputType.emailAddress,
      // validator: (){},
      onSaved: (value) => emailEditingController.text = value!,
      textInputAction: TextInputAction.next,
    );

    // password field
    final passwordField = TextFormField(
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          prefixIconColor: Colors.red,
          contentPadding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
          // hintText: "Enter your email address",
          labelText: "Password",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
      autofocus: false,
      obscureText: true,
      controller: passwordEditingController,
      // validator: (){},
      onSaved: (value) => passwordEditingController.text = value!,
      textInputAction: TextInputAction.next,
    );

    // confirm password field
    final confirmPasswordField = TextFormField(
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          prefixIconColor: Colors.red,
          contentPadding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
          // hintText: "Enter your email address",
          labelText: "Confirm Password",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
      autofocus: false,
      controller: confirmPasswordEditingController,
      obscureText: true,

      // validator: (){},
      onSaved: (value) => confirmPasswordEditingController.text = value!,
      textInputAction: TextInputAction.done,
    );

    // sign up button

    final signupButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.red,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
        minWidth: MediaQuery.of(context).size.width,
        child: Text(
          "Sign Up",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        onPressed: () {},
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.blue,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        child: Image.asset(
                          "assets/images/sikshyatechnology.jpg",
                          height: MediaQuery.of(context).size.height * 0.2,
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(height: 20.0),
                      firstNameField,
                      SizedBox(height: 20.0),
                      secondNameField,
                      SizedBox(height: 20.0),
                      emailField,
                      SizedBox(height: 20.0),
                      passwordField,
                      SizedBox(height: 20.0),
                      confirmPasswordField,
                      SizedBox(height: 20.0),
                      signupButton,
                      SizedBox(height: 20.0),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already have an account?"),
                          SizedBox(width: 5.0),
                          GestureDetector(
                            child: Text(
                              "Sign In",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SigninScreen()));
                            },
                          )
                        ],
                      )
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
