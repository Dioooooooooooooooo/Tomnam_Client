import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import '../../.././commons/widgets/upper_navbar.dart';

class GenerateCodePage extends StatefulWidget {
  final String? reservationId;

  const GenerateCodePage({super.key, this.reservationId});

  @override
  State<GenerateCodePage> createState() => _GenerateCodePageState();
}

class _GenerateCodePageState extends State<GenerateCodePage> {
  late String? qrData;

  @override
  void initState() {
    super.initState();
    // id to qr jake, angel, charlen, shan
    qrData = widget.reservationId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const UpperNavBar(false),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Your Reservation QR Code",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            if (qrData!.isNotEmpty)
              SizedBox(
                width: 250,
                height: 250,
                child: PrettyQrView.data(
                  data: qrData!,
                  errorCorrectLevel: QrErrorCorrectLevel.M,
                ),
              ),
            Text(
              "Reservation ID: $qrData",
              style: const TextStyle(fontSize: 14.0, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
