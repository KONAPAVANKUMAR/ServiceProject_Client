import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../global.dart';
import '../main.dart';
import '../signup/UIfunctions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screen.dart';

Future getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token').toString();
  return token;
}

logout(context) async {
  // http get request from url
  var token;

  await getToken().then((value) {
    token = value;
  });

  await http.get(
    Uri.parse(logoutEndpoint),
    headers: {
      // 'Content-Type': 'application/json',
      'Authorization': 'Token ' + token,
    },
  ).then((response) {
    var responseJson = json.decode(response.body);
    var status = responseJson['status'];
    if (status == 'success') {
      //Navigate push Material Page Route
      while (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MyHomePage(title: "Service Provider"),
        ),
      );
    }
  });
}

getUserData() async {
  var token;
  var userData;
  await getToken().then((value) {
    token = value;
  });
  await http.get(Uri.parse(endpointDomain + 'users/currentuser'), headers: {
    'Authorization': 'Token ' + token,
  }).then((value) {
    var responseJson = json.decode(value.body);
    userData = responseJson;
  });
  return userData;
}

getServices() async {
  // http get request from url
  var services;
  var url = endpointDomain + 'service/list';
  return getUserData().then((value) async {
    var token;
    await getToken().then((value) {
      token = value;
    });

    await http.get(Uri.parse(url), headers: {
      'Authorization': 'Token ' + token,
    }).then((value) {
      var responseJson = json.decode(value.body);
      services = responseJson;
    });
  }).then((value) {
    return services;
  });
}

getBookingStatus(var serviceId, var clientId) async {
  // http get request from url
  var url = endpointDomain + 'service/$serviceId/$clientId/status';
  var token;
  await getToken().then((value) {
    token = value;
  });
  return http.get(Uri.parse(url), headers: {
    'Authorization': 'Token ' + token,
  }).then((value) {
    var responseJson = json.decode(value.body);
    return responseJson;
  });
}

bookService(var serviceId) async {
  // http get request from url
  var url = endpointDomain + 'service/$serviceId/selectService';
  return await getToken().then((token) async {
    return await http.post(Uri.parse(url), headers: {
      'Authorization': 'Token ' + token,
    });
  });
}
