import 'dart:convert';
import 'package:exam_qrcode/Logic/FireBaseManagment.dart';
import 'package:exam_qrcode/Logic/GeneralStateManagement.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class QR extends HookWidget {
  @override
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode result;
  QRViewController controller;
  @override
  Widget build(BuildContext context) {
    final state = useProvider(generalmanagment);
    void _onQRViewCreated(QRViewController controller) {
      this.controller = controller;
      controller.scannedDataStream.listen((scanData) async {
        controller.dispose();
        final js = json.decode(scanData.code);
        state.setresult(js["name"]);
        state.setloadingstate();
        await scanqr(js["name"], js["date"], js["src"]);
        state.setloadingstate();
        Get.back();
        _launchURL(js["src"]);
      });
    }

    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: state.isloading,
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 5,
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: (result != null)
                    ? Text(
                        'Barcode Type: ${result.format}   Data: ${result.code}')
                    : Text('Scan a code'),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                child: Text("Back"))
          ],
        ),
      ),
    );
  }
}

void _launchURL(String url) async =>
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
