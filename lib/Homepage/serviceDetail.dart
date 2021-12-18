import 'dart:convert';

import 'package:clientapp/Homepage/widgets/bookingbutton.dart';
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
  var serviceId;
  var clientId;
  var bookingStatus;
  var loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var service = widget.service;
    serviceId = service['_id'];
    getUserData().then((value) {
      clientId = value['id'];
      return clientId;
    }).then((clientId) {
      getBookingStatus(serviceId, clientId).then((value) {
        if (value['Message'] == 'invalid Route') {
          setState(() {
            bookingStatus = 'Not Booked';
          });
        } else if (value['status'] == null) {
          setState(() {
            bookingStatus = 'Pending';
          });
        }
      });
    }).then((e) {
      setState(() {
        loading = false;
      });
    });
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
        body: !loading
            ? Center(
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
                    bookingButton(widget.service, clientId)
                  ],
                ),
              ))
            : Center(child: CircularProgressIndicator()));
  }
}
