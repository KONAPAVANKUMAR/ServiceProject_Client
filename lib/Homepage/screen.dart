import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'apiFunctions.dart';
import '../global.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

import 'serviceDetail.dart';

class HomePage extends StatefulWidget {
  HomePage({required this.title});
  final String title;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var token;
  var services;
  var servicesBackup;
  var isServicesLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getToken().then((token) {
      this.token = token;
    });
    getServices().then((services) {
      setState(() {
        this.services = services;
        servicesBackup = services;
        isServicesLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(''),
                Text(
                  widget.title,
                  style: GoogleFonts.montserrat(
                    textStyle: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      logout(context);
                    },
                    icon: Icon(
                      Icons.logout,
                    ))
              ],
            )),
        body: WillPopScope(
            onWillPop: () async => false,
            child: Container(
                padding: EdgeInsets.all(20),
                child: Center(
                  child: isServicesLoading
                      ? Center(child: CircularProgressIndicator())
                      : Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.deepPurple)),
                              child: TextField(
                                onChanged: (value) {
                                  setState(() {
                                    services = [];
                                  });
                                  for (var service in servicesBackup) {
                                    if (service['name']
                                        .toLowerCase()
                                        .contains(value.toLowerCase())) {
                                      setState(() {
                                        services.add(service);
                                      });
                                    }
                                  }
                                },
                                decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.search,
                                      color: Colors.deepPurple,
                                    ),
                                    border: InputBorder.none),
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
                              child: Expanded(
                                child: new ListView.builder(
                                    itemCount: services.length,
                                    itemBuilder: (context, index) {
                                      return ClipRRect(
                                        borderRadius: BorderRadius.circular(30),
                                        child: Card(
                                          elevation: 5,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.deepPurple,
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: ListTile(
                                              // tileColor: Colors.deepPurple,
                                              iconColor: Colors.white,
                                              title: Text(
                                                services[index]['name'],
                                                style: GoogleFonts.montserrat(
                                                  color: Colors.yellowAccent,
                                                  fontSize: 20,
                                                ),
                                              ),
                                              subtitle: Text(
                                                services[index]
                                                    ['feasiblelocations'],
                                                style: GoogleFonts.montserrat(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              trailing:
                                                  Icon(Icons.arrow_forward_ios),
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ServiceDetailPage(
                                                                service: services[
                                                                    index])));
                                              },
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            ),
                          ],
                        ),
                ))));
  }
}
