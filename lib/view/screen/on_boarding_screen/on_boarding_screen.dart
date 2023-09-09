// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/controller/on_boarding_screen_controller/on_boarding_screen_controller.dart';
import 'package:project/view/widget/on_barding_widget/dot_controller.dart';
import 'package:project/view/widget/on_barding_widget/on_boarding_button.dart';
import 'package:project/view/widget/on_barding_widget/page_view.dart';
import 'package:sizer/sizer.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OnBoardingContollerImp());
    return Sizer(
      builder: (context, orientation, devicetype) => Scaffold(
        body: SafeArea(
            child: Column(
          children: [
            Expanded(flex: 4, child: CustomPageViewOnBoarding()),
            Expanded(
              flex: 1,
              child: Column(
                children: const [
                  SizedBox(height: 50),
                  CustomDotControllerOnboarding(),
                  Spacer(flex: 10),
                  CustomButtonOnBoarding(),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}
