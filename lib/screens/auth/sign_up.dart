import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:king/screens/host_Meeting.dart';

import 'login.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({ Key? key }) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();

  void createAccount() async {
    String email = emailController.text.toString().trim();
    String password = passwordController.text.toString().trim();
    String cPassword = cPasswordController.text.toString().trim();

    if(email == "" || password == "" || cPassword == "") {
     Fluttertoast.showToast(msg: "Please fill all the required information",gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT);
    }
    else if(password != cPassword) {
      Fluttertoast.showToast(msg: "Password and Confirm Password must be Same",gravity: ToastGravity.BOTTOM,toastLength: Toast.LENGTH_SHORT);
    }
    else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
        if(userCredential.user != null) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyApp()));
        }
      } on FirebaseAuthException catch(ex) {
        log(ex.code.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Create an account"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: ListView(
            children: [

              Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [

                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                          labelText: "Email Address"
                      ),
                    ),

                    SizedBox(height: 10,),

                    TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                          labelText: "Password"
                      ),
                    ),

                    SizedBox(height: 10,),

                    TextField(
                      controller: cPasswordController,
                      decoration: InputDecoration(
                          labelText: "Confirm Password"
                      ),
                    ),

                    SizedBox(height: 20,),

                    CupertinoButton(
                      onPressed: () {
                        createAccount();
                      },
                      color: Colors.blue,
                      child: Text("Create Account"),
                    ), SizedBox(height: 20,),

                  ],
                ),
              ),
              SizedBox(height: 20,),
              OutlinedButton(onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
              }, child: Text("Already Have Account"),

              )
            ],
          ),
        ),
      ),
    );
  }
}