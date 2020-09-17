import 'dart:convert';

import 'package:dr_app/components/confirmation_dialog.dart';
import 'package:dr_app/components/top_bar.dart';
import 'package:dr_app/data/models/models.dart';
import 'package:dr_app/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

/// The Scanner screen provides a way for users to scan QR Codes
/// and check-in brick-and-mortar outlets. In sequence, the
/// Home screen will adapt to display content specific to the scanned outlet.
class ScannerScreen extends StatefulWidget {
  static const id = "scanner_screen";

  @override
  _ScannerScreenState createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  QRViewController controller;

  void processQRCode(String scanData) {
    this.controller.pauseCamera();
    try {
      Map<String, dynamic> json = jsonDecode(scanData);
      QRCode code = QRCode.fromJson(json);
      _showDialog('${code.name}', 'Do you wish to check-in this restaurant?')
          .then((userConfirmed) {
        if (userConfirmed) {
          Navigator.pop(context, code.id);
        } else {
          this.controller.resumeCamera();
        }
      });
    } catch (e) {
      _showDialog('Uh-oh', 'QR-Code not valid')
          .then((value) => this.controller.resumeCamera());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Stack(
        children: <Widget>[
          QRView(
            key: qrKey,
            overlay: QrScannerOverlayShape(
                borderColor: LUColors.smoothWhite,
                borderRadius: 8,
                borderLength: 40,
                borderWidth: 12,
                cutOutSize: 240,
                cutOutBottomOffset: 100),
            onQRViewCreated: _onQRViewCreated,
          ),
          LUTopBar(
            icon: Icons.close,
            onNavigationButtonPressed: () => Navigator.of(context).pop(),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      processQRCode(scanData);
    });
  }

  Future<bool> _showDialog(String title, String message) async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return ConfirmationDialog(
          title: title,
          message: message,
          confirmActionTitle: 'Check-in',
          onConfirmPressed: () {
            Navigator.pop(context, true);
          },
          onCancelPressed: () {
            Navigator.pop(context, false);
          },
        );
      },
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
