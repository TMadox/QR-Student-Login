import 'package:exam_qrcode/Logic/FireBaseManagment.dart';
import 'package:exam_qrcode/Widgets/ColorsNConstants.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: indigodye,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: width * 0.4,
              height: width * 0.4,
              child: ElevatedButton(
                  onPressed: () {
                    scanqr("Computer Graphics");
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.qr_code,
                        color: Colors.amber,
                        size: width * 0.1,
                      ),
                      Text(
                        "Scan QR",
                        style: TextStyle(color: indigodye),
                      ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    primary: Colors.white,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

class teestss extends StatefulWidget {
  @override
  _teestssState createState() => _teestssState();
}

class _teestssState extends State<teestss> {
  int shit = 1;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          setState(() {
            shit += 1;
          });
        },
        child: Text(shit.toString()));
  }
}
