import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class PaymentPage extends StatefulWidget {
  PaymentPage({required this.title});
  final String title;
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      routes: {
        "/": (_) => new WebviewScaffold(
              url: "https://razorpay.com/payment-link/plink_IZGVEGcC9lX9M8",
            ),
      },
    );
  }
}
