import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../global.dart';
import 'UIfunctions.dart';

createClient(BuildContext context, String username, String password,
    String email) async {
  await http.post(Uri.parse(createClientEndpoint), body: {
    "username": username,
    "password": password,
    "email": email,
  }).then((response) {
    var responseJson = json.decode(response.body);
    var message = responseJson['message'];
    print(message);
    var title;
    if (message == "client created") {
      title = "Success";
    } else {
      title = "Error";
    }
    showAlertDialog(context, title, message);
    if (message == "client created") {
      // 1 second delay
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      });
    }
  });
}
