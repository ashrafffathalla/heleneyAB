// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:project/controller/start_screen_controller/start_screen_controller.dart';
import 'package:project/core/constant/app_photo.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<StartScreenControllerIMP>(
        init: StartScreenControllerIMP(),
        builder: (controller) => Column(
          children: [
            Expanded(
              child: Lottie.asset(
                AppPhotoLink.logoStart,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
