import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'apiFunctions.dart';
import '../global.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class ServiceDetailPage extends StatefulWidget {
  ServiceDetailPage({required this.service});
  var service;
  @override
  _ServiceDetailPageState createState() => _ServiceDetailPageState();
}

class _ServiceDetailPageState extends State<ServiceDetailPage> {
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
              widget.service['name'],
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                  fontSize: 20,
                ),
              ),
            )),
        body: Center(
            child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              ListTile(
                title: Text(
                  'Service Name',
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.blue,
                    ),
                  ),
                ),
                subtitle: Text(
                  widget.service['name'],
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  'About',
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.blue,
                    ),
                  ),
                ),
                subtitle: Text(
                  widget.service['about'],
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  'Locations',
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.blue,
                    ),
                  ),
                ),
                subtitle: Text(
                  widget.service['feasiblelocations'],
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              ListTile(
                title: Text(
                  'Rating',
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.blue,
                    ),
                  ),
                ),
                subtitle: Text(
                  widget.service['rating'] + '/5',
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )));
  }
}
