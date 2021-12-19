import 'package:clientapp/Paymentpage/screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../apiFunctions.dart';
import '../serviceDetail.dart';

class bookingButton extends StatefulWidget {
  const bookingButton(this.service, this.clientId);
  final service;
  final clientId;
  @override
  State<bookingButton> createState() => _bookingButtonState();
}

class _bookingButtonState extends State<bookingButton> {
  var serviceId;
  var service;
  var clientId;
  var textOnButton = "Book Now";
  Color buttonColor = Colors.orange;
  Color buttonTextColor = Colors.white;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    serviceId = widget.service['_id'];
    service = widget.service;
    clientId = widget.clientId;

    getBookingStatus(serviceId, clientId).then((value) {
      print(value);
      if (value['Message'] == null) {
        setState(() {
          textOnButton = "Pending";
          buttonColor = Colors.yellow;
          buttonTextColor = Colors.black;
        });
      } else if (value['Message'] == 'invalid Route') {
        setState(() {
          textOnButton = "Book Now";
        });
      } else if (value['Message'] == 'accepted') {
        setState(() {
          textOnButton = "Accepted";
          buttonColor = Colors.green;
          buttonTextColor = Colors.white;
        });
      } else if (value['Message'] == 'rejected') {
        setState(() {
          textOnButton = "Rejected";
          buttonColor = Colors.red;
          buttonTextColor = Colors.white;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        if (textOnButton == "Book Now") {
          bookService(serviceId).then((value) {
            if (value.statusCode == 200) {
              setState(() {
                textOnButton = "Pending";
                buttonColor = Colors.yellow;
                buttonTextColor = Colors.black;
              });
            }
          });

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PaymentPage(title: 'Payment')));
        }
      },
      style: TextButton.styleFrom(backgroundColor: buttonColor),
      child: Text(
        textOnButton,
        style: GoogleFonts.montserrat(
          textStyle: TextStyle(fontSize: 20, color: buttonTextColor),
        ),
      ),
    );
  }
}
