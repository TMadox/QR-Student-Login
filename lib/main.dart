import 'package:exam_qrcode/MainPages/HomePage.dart';
import 'package:exam_qrcode/MainPages/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ProviderScope(child: GetMaterialApp(home: HomePage())));
}
