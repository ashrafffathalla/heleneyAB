// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/controller/home_screen_controller/home_screen_controller.dart';
import 'package:sizer/sizer.dart';

class CustomBottomNavBarWidget extends StatelessWidget {
  const CustomBottomNavBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10.sp, bottom: 14.sp, right: 10.sp),
      height: 8.h,
      decoration: BoxDecoration(
        color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        boxShadow: [
          BoxShadow(blurRadius: 30, offset: const Offset(0, 10)),
        ],
        borderRadius: BorderRadius.circular(50),
      ),
      child: GetBuilder<HomeScreenControllerIMP>(
        init: HomeScreenControllerIMP(),
        builder: (controller) => ListView.builder(
          itemCount: 4,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: Get.width * .02),
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              controller.changeIndex(index);
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Stack(
              children: [
                AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  curve: Curves.fastLinearToSlowEaseIn,
                  width: index == controller.currentIndex
                      ? Get.width * .34
                      : Get.width * .11,
                  alignment: Alignment.center,
                  child: AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    curve: Curves.fastLinearToSlowEaseIn,
                    height:
                        index == controller.currentIndex ? Get.width * .12 : 0,
                    width:
                        index == controller.currentIndex ? Get.width * .32 : 0,
                    decoration: BoxDecoration(
                      color: index == controller.currentIndex
                          ? Theme.of(context)
                              .bottomNavigationBarTheme
                              .selectedItemColor
                          : Theme.of(context)
                              .bottomNavigationBarTheme
                              .unselectedItemColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  curve: Curves.fastLinearToSlowEaseIn,
                  width: index == controller.currentIndex
                      ? Get.width * .31
                      : Get.width * .18,
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn,
                            width: index == controller.currentIndex
                                ? Get.width * .13
                                : 0,
                          ),
                          AnimatedOpacity(
                            opacity: index == controller.currentIndex ? 1 : 0,
                            duration: const Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn,
                            child: Text(
                                index == controller.currentIndex
                                    ? controller.listOfStrings[index]
                                    : '',
                                style: Theme.of(context)
                                    .bottomNavigationBarTheme
                                    .selectedLabelStyle),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          AnimatedContainer(
                            duration: Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn,
                            width: index == controller.currentIndex
                                ? Get.width * .03
                                : 20,
                          ),
                          Icon(
                            controller.listOfIcons[index],
                            size: Get.width * .076,
                            color: index == controller.currentIndex
                                ? Theme.of(context)
                                    .bottomNavigationBarTheme
                                    .selectedIconTheme!
                                    .color
                                : Theme.of(context)
                                    .bottomNavigationBarTheme
                                    .unselectedIconTheme!
                                    .color,
                          ),
                        ],
                      ),
                    ],
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
