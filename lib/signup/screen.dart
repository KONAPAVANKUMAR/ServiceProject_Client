import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../global.dart';

import 'UIfunctions.dart';
import 'apiFunctions.dart';

class SignupPage extends StatefulWidget {
  SignupPage({required this.title});
  final String title;
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  // controller
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Sign Up',
            style: GoogleFonts.montserrat(
              textStyle: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ),
        body: Center(
          child: Container(
            // border radius
            color: Colors.white,
            padding: EdgeInsets.all(20),
            child: Container(
              padding: EdgeInsets.all(20),
              // border radius
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.deepPurple,
              ),

              child: Column(
                mainAxisSize: MainAxisSize.min,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: TextField(
                      controller: _emailController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        border: InputBorder.none,
                      ),
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: TextField(
                      controller: _usernameController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: 'Username',
                        border: InputBorder.none,
                      ),
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    child: TextField(
                      obscureText: true,
                      controller: _passwordController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        border: InputBorder.none,
                      ),
                      style: GoogleFonts.montserrat(
                        textStyle: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(backgroundColor: Colors.white),
                    child: Text('Sign Up',
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                            fontSize: 20,
                            color: Colors.deepPurple,
                          ),
                        )),
                    onPressed: () {
                      if (_usernameController.text.isEmpty ||
                          _passwordController.text.isEmpty ||
                          _emailController.text.isEmpty) {
                        showAlertDialog(
                            context, 'Error', 'Please fill all the fields');
                      } else {
                        createClient(
                          context,
                          _usernameController.text,
                          _passwordController.text,
                          _emailController.text,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
