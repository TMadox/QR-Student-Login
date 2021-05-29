import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_qrcode/MainPages/HomePage.dart';
import 'package:exam_qrcode/MainPages/LoginPage.dart';
import 'package:exam_qrcode/MainPages/SplashScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'MainPages/DashboardPage.dart';
import 'MainPages/UserHistoryPage.dart';
import 'Widgets/ColorsNConstants.dart';

class MyObserver implements WidgetsBindingObserver {
  final auth = FirebaseAuth.instance;
  int inactivetime;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  void didChangeAccessibilityFeatures() {}

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      final FirebaseFirestore _firestore = FirebaseFirestore.instance;
      _firestore
          .collection(userscollection)
          .doc(auth.currentUser.email.split("@")[0])
          .update({isloggedin: false});
      Get.offAll(() => LoginPage());
    }
  }

  @override
  void didChangeLocales(List<Locale> locales) {}

  @override
  void didChangeMetrics() {}

  @override
  void didChangePlatformBrightness() {}

  @override
  void didChangeTextScaleFactor() {}

  @override
  void didHaveMemoryPressure() {}

  @override
  Future<bool> didPopRoute() {
    throw UnimplementedError();
  }

  @override
  Future<bool> didPushRoute(String route) {
    throw UnimplementedError();
  }

  @override
  Future<bool> didPushRouteInformation(RouteInformation routeInformation) {
    throw UnimplementedError();
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final obs = MyObserver();
  WidgetsBinding.instance.addObserver(obs);
  runApp(ProviderScope(child: GetMaterialApp(home: HomePage())));
}
