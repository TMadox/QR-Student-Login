import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:exam_qrcode/Widgets/ColorsNConstants.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:get_mac/get_mac.dart';

Future studentlogin(String id, String password) async {
  final auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final result = await auth.signInWithEmailAndPassword(
    email: id + "@acu.com",
    password: password,
  );
  if (!id.contains("admin")) {
    _firestore.collection(userscollection).doc(id).update(
        {studentid: id, isloggedin: true, lastlogindate: DateTime.now()});
  }
  return result;
}

Future scanqr(String course, String qrdate, String url) async {
  Map temp;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  DocumentSnapshot student = await _firestore
      .collection(userscollection)
      .doc(auth.currentUser.email.split("@")[0])
      .get();
  final Geoflutterfire geo = Geoflutterfire();
  Position currentpostion = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  GeoFirePoint point = geo.point(
      latitude: currentpostion.latitude, longitude: currentpostion.altitude);
  ////////////////////////////////////User History//////////////////////////////////////////
  temp = student.data()[coursescounter];
  if (student.data()[coursescounter].isEmpty) {
    temp[course] = 1;
    await _firestore
        .collection(userscollection)
        .doc(auth.currentUser.email.split("@")[0])
        .update({coursescounter: temp});
  } else if (student.data()[coursescounter].containsKey(course)) {
    temp[course] += 1;
    await _firestore
        .collection(userscollection)
        .doc(auth.currentUser.email.split("@")[0])
        .update({coursescounter: temp});
  } else if (!student.data()[coursescounter].containsKey(course)) {
    temp[course] = 1;
    await _firestore
        .collection(userscollection)
        .doc(auth.currentUser.email.split("@")[0])
        .update({coursescounter: temp});
  }
  await _firestore
      .collection(userscollection)
      .doc(auth.currentUser.email.split("@")[0])
      .update({
    lastcoursejoined: course,
    'position': point.data,
    lastscandate: DateTime.now(),
    "Last URL Joined": url,
  }).whenComplete(() => _firestore
              .collection(userscollection)
              .doc(auth.currentUser.email.split("@")[0])
              .collection("History")
              .add({
            coursename: course,
            // "URL": url,
            scandate: DateTime.now(),
            "Login Date": student.data()[lastlogindate],
            qrcreationdate: qrdate
          }));
  print("test");
////////////////////////////////////Course History//////////////////////////////////////////
  await _firestore
      .collection(coursescollection)
      .doc(course)
      .set({"Department": "Electricity", "Name": course}).whenComplete(
          () async => _firestore
                  .collection(coursescollection)
                  .doc(course)
                  .collection("History")
                  .add({
                coursename: course,
                studentname: student.data()[studentname],
                studentid: auth.currentUser.email.split("@")[0],
                scandate: DateTime.now(),
                studentmac: await GetMac.macAddress,
                qrcreationdate: qrdate
              }));
}

final firebasestudentstream = StreamProvider<QuerySnapshot>((ref) {
  CollectionReference users =
      FirebaseFirestore.instance.collection(userscollection);
  return users.snapshots();
});
final firebasecoursestream = StreamProvider<QuerySnapshot>((ref) {
  CollectionReference users =
      FirebaseFirestore.instance.collection(coursescollection);
  return users.snapshots();
});
