import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'apiFunctions.dart';
import 'global.dart';
import 'signup/UIfunctions.dart';

import 'signup/screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Client',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: MyHomePage(title: 'Client'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //controller
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            widget.title,
            style: GoogleFonts.montserrat(
              textStyle: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ),
        body: Center(
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.deepPurple,
                  ),
                  padding: EdgeInsets.all(15),
                  // border radius

                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child: TextField(
                          controller: usernameController,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Username',
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
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                          controller: passwordController,
                          obscureText: true,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Password',
                          ),
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.white,
                          ),
                          child: Text('Login',
                              style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                  fontSize: 20,
                                  color: Colors.deepPurple,
                                ),
                              )),
                          onPressed: () {
                            if (usernameController.text.isEmpty ||
                                passwordController.text.isEmpty) {
                              showAlertDialog(context, 'Error',
                                  'Please fill all the fields');
                            } else {
                              authenticateClient(
                                  context,
                                  usernameController.text,
                                  passwordController.text);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Column(
                    children: [
                      Text('Dont have an account ?',
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                              fontSize: 20,
                            ),
                          )),
                      GestureDetector(
                        child: Text(
                          'Signup Here',
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                              fontSize: 20,
                              color: Colors.deepPurple,
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  SignupPage(title: "Signup Page"),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
