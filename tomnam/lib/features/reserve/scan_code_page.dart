import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:tomnam/commons/widgets/headline_text.dart';
import 'package:tomnam/commons/widgets/title_text.dart';
import 'package:tomnam/utils/constants/routes.dart';
import 'package:logger/logger.dart';

class ScanCodePage extends StatefulWidget {
  const ScanCodePage({super.key});

  @override
  State<ScanCodePage> createState() => _ScanCodePageState();
}

class _ScanCodePageState extends State<ScanCodePage> {
  final _logger = Logger(
    printer: PrettyPrinter(),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const HeadlineText(
          text: "Scan QR code",
          size: HeadlineSize.medium,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.popAndPushNamed(context, generateQrCodePageRoute);
            },
            icon: const Icon(Icons.qr_code_scanner_outlined),
          ),
        ],
      ),
      body: MobileScanner(
        controller: MobileScannerController(
          detectionSpeed: DetectionSpeed.noDuplicates,
          returnImage: true,
        ),
        onDetect: (capture) {
          _logger.d(capture);
          final List<Barcode> barcodes = capture.barcodes;
          final Uint8List? image = capture.image;
          for (final barcode in barcodes) {
            _logger.d("Barcode found!", barcode.rawValue);
          }

          if (image != null) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: TitleText(
                      text: barcodes.first.rawValue ?? "",
                      size: TitleSize.medium),
                  content: Image(
                    image: MemoryImage(image),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
