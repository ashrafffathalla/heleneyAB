// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/controller/home_screen_controller/home_screen_controller.dart';
import 'package:project/view/widget/home_screen_widgt/custom_buttom_navbar_widget.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenControllerIMP>(
      init: HomeScreenControllerIMP(),
      builder: (controller) => WillPopScope(
        onWillPop: () async => false,
        child: Sizer(
          builder: (context, orientation, devicetype) => Scaffold(
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            body: Column(
              children: [
                SizedBox(height: 1.h),
                SizedBox(
                  height: 8.h,
                  width: Get.width,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                            controller.listOfStrings[controller.currentIndex],
                            style: Theme.of(context).textTheme.bodyLarge),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.sp),
                            topRight: Radius.circular(30.sp))),
                    child: Stack(
                      children: [
                        controller.screen[controller.currentIndex],
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: const CustomBottomNavBarWidget(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
