import 'package:exam_qrcode/Logic/GeneralStateManagement.dart';
import 'package:exam_qrcode/MainPages/DashboardPage.dart';
import 'package:exam_qrcode/MainPages/ProfilePage.dart';
import 'package:exam_qrcode/Widgets/QR.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:exam_qrcode/Widgets/ColorsNConstants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'UserHistoryPage.dart';

class HomePage extends HookWidget {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final state = useProvider(generalmanagment);
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
                    Get.dialog(
                      QR(),
                      useSafeArea: true,
                      barrierDismissible: true,
                    );
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
            Visibility(
              visible: !auth.currentUser.email.contains("admin"),
              child: Container(
                  margin: EdgeInsets.only(top: 100),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: redpurple),
                      onPressed: () {
                        Get.to(() => ProfilePage(), arguments: [
                          auth.currentUser.email.split("@")[0],
                          userscollection
                        ]);
                      },
                      child: Text("History"))),
            ),
            Visibility(
              visible: auth.currentUser.email.contains("admin"),
              child: Container(
                  margin: EdgeInsets.only(top: 100),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: redpurple),
                      onPressed: () {
                        Get.to(() => DashboardPage());
                      },
                      child: Text("Dashboard"))),
            )
          ],
        ),
      ),
    );
  }
}

void checkadmin() {}
