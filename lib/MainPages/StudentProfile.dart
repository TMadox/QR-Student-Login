import 'package:exam_qrcode/Widgets/ColorsNConstants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'UserHistoryPage.dart';

class StudentProfile extends StatelessWidget {
  var student = Get.arguments;
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Student Profile"),
        backgroundColor: redpurple,
      ),
      body: Container(
        padding: EdgeInsets.only(top: height * 0.02),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection(userscollection)
                      .doc(student)
                      .snapshots(),
                  builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.hasData) {
                      return SettingsList(
                        backgroundColor: Colors.white,
                        sections: [
                          SettingsSection(
                              title: 'Profile info',
                              titleTextStyle:
                                  TextStyle(color: indigodye, fontSize: 15),
                              tiles: snapshot.data
                                  .data()
                                  .keys
                                  .where(
                                    (element) => !element.contains(RegExp(
                                        "\\b(?:position|isLoggedin|Last URL Joined)\\b")),
                                  )
                                  .map(
                                    (e) => SettingsTile(
                                      titleTextStyle:
                                          TextStyle(color: redpurple),
                                      title: e,
                                      subtitle: snapshot.data.data()[e]
                                              is Timestamp
                                          ? snapshot.data
                                              .data()[e]
                                              .toDate()
                                              .toString()
                                          : snapshot.data.data()[e].toString(),
                                      onPressed: (BuildContext context) {},
                                    ),
                                  )
                                  .toList()),
                        ],
                      );
                    } else {
                      return Center(
                        child: Text("Loading"),
                      );
                    }
                  }),
            ),
            ElevatedButton(
              onPressed: () {
                Get.to(() => UserHistoryPage(),
                    arguments: [student, userscollection]);
              },
              child: Text("My History"),
              style: ElevatedButton.styleFrom(primary: redpurple),
            ),
            SizedBox(
              height: height * 0.1,
            )
          ],
        ),
      ),
    );
  }
}
