import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:tomnam/commons/widgets/headline_text.dart';
import 'package:tomnam/commons/widgets/label_text.dart';
import 'package:tomnam/commons/widgets/title_text.dart';
import 'package:logger/logger.dart';
import 'package:tomnam/utils/constants/routes.dart';
import 'package:tomnam/utils/constants/tomnam_pallete.dart';
import '../../.././commons/widgets/upper_navbar.dart';

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
      appBar: const UpperNavBar(true),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.2),
            const HeadlineText(text: 'Scan QR'),
            const SizedBox(height: 20),
            SizedBox(
              height: 270,
              width: 270,
              child: MobileScanner(
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
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: TitleText(
                              text: barcodes.first.rawValue ?? "",
                              size: TitleSize.medium),
                          content: SizedBox(
                            height: 370,
                            child: Column(
                              children: [
                                Image(
                                  image: MemoryImage(image),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pushNamed(
                                        confirmReservationRoute,
                                        arguments: {
                                          'reservationId':
                                              barcodes.first.rawValue
                                        });
                                  },
                                  style: const ButtonStyle(
                                    backgroundColor: WidgetStatePropertyAll(
                                        AppColors.accentGreenColor),
                                  ),
                                  child:
                                      const LabelText(text: "View Reservation"),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
