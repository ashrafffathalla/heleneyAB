
// ignore_for_file: no_leading_underscores_for_local_identifiers
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/screen/get_started_screen/get_started_screen.dart';
import 'package:project/service/my_server.dart';
import 'package:project/utils/color_res.dart';
import 'package:project/utils/const_res.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

MyServices myServices = Get.find();
ThemeMode themeMode = ThemeMode.system;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();
  if (Platform.isIOS) {
    await Firebase.initializeApp(
      name: 'abudiyab',
      options: const FirebaseOptions(
        apiKey: "AIzaSyB2mmpDPtRFPDigxBvNo4PyQuo4-_ssSBY",
        appId: "1:467963202794:ios:a20bfd81ed7185e0fa9b93",
        messagingSenderId: "467963202794",
        projectId: "orangeflutter-c956e",
      ),
    );
  }else{
    await Firebase.initializeApp();
  }
  print('H!!!!');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  void initialize() {
    if (myServices.sharedPreferences.getBool('theme') == true) {
      Get.changeThemeMode(ThemeMode.dark);
    } else if (myServices.sharedPreferences.getBool('theme') == false) {
      Get.changeThemeMode(ThemeMode.light);
    } else {
      Get.changeThemeMode(ThemeMode.system);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Helnay',
        //localizationsDelegates: AppLocalizations.localizationsDelegates,
        // supportedLocales: AppLocalizations.supportedLocales,
       // supportedLocales: [
      //  _locale, // Spanish, no country code
       // ],
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
        fontFamily: FontRes.regular,
        primaryColor: ColorRes.orange,
    ),
    home: const GetStartedScreen(),
    );
  }}