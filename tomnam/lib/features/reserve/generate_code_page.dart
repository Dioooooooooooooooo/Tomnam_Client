import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:tomnam/commons/widgets/headline_text.dart';
import 'package:tomnam/utils/constants/routes.dart';

class GenerateCodePage extends StatefulWidget {
  const GenerateCodePage({super.key});

  @override
  State<GenerateCodePage> createState() => _GenerateCodePageState();
}

class _GenerateCodePageState extends State<GenerateCodePage> {
  String? qrData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const HeadlineText(
          text: "Generate QR page",
          size: HeadlineSize.medium,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, scanQrCodePageRoute);
            },
            icon: const Icon(Icons.qr_code_scanner_outlined),
          ),
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(),
            // if (qrData != null) PrettyQrView.data(data: qrData!),
          ], // should have a way to get the ID of the reservation and make it into qr
        ),
      ),
    );
  }
}
