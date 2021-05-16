import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:exam_qrcode/Widgets/ColorsNConstants.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:geolocator/geolocator.dart';

Future studentlogin(String id, String password) async {
  final auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final result = await auth.signInWithEmailAndPassword(
    email: id + "@acu.com",
    password: password,
  );
  _firestore
      .collection(userscollection)
      .doc(id)
      .update({"ID": id, isloggedin: true, lastlogindate: DateTime.now()});
  return result;
}

Future scanqr(String coursename, String qrdate, String url) async {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  final Geoflutterfire geo = Geoflutterfire();
  Position currentpostion = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  GeoFirePoint point = geo.point(
      latitude: currentpostion.latitude, longitude: currentpostion.altitude);
  _firestore
      .collection(userscollection)
      .doc(auth.currentUser.email.split("@")[0])
      .update({
    "Course": coursename,
    'position': point.data,
    qrcreationdate: qrdate,
    lastscandate: DateTime.now(),
    "URL": url
  });
}
