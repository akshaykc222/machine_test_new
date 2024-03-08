import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrCodeReader extends StatefulWidget {
  const QrCodeReader({super.key});

  @override
  State<QrCodeReader> createState() => _QrCodeReaderState();
}

class _QrCodeReaderState extends State<QrCodeReader> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        child: QRView(key: qrKey, onQRViewCreated: _onQRViewCreated),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      // Process the scanned QR code data
      String? qrData = scanData.code;
    });
  }
}
