// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/controller/option_screen_controller/option_screen_controller.dart';
import 'package:project/core/constant/app_photo.dart';
import 'package:project/view/widget/option_screen_widget/button_option_widget.dart';
import 'package:project/view/widget/option_screen_widget/widget_center_option_screen.dart';
import 'package:sizer/sizer.dart';

class OptionScreen extends StatelessWidget {
  const OptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      body: GetBuilder<OptionScreenControllerIMP>(
        init: OptionScreenControllerIMP(),
        builder: (controller) => Column(
          children: [
            SizedBox(
                height: 8.h,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: IconButton(
                        onPressed: controller.onBackBtnTap,
                        icon: Icon(
                          Icons.arrow_back_ios_new_outlined,
                          size: 10.sp,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 7.sp, bottom: 3.sp),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: PopupMenuButton<String>(
                          onSelected: (value) {
                            controller.onMoreBtnTap(value);
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 3,
                          itemBuilder: (BuildContext context) {
                            return {'Dark', 'Light'}.map(
                              (String choice) {
                                return PopupMenuItem<String>(
                                  value: choice,
                                  child: Text(choice),
                                );
                              },
                            ).toList();
                          },
                          child: Icon(
                            CupertinoIcons.gear_alt,
                            size: 10.sp,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.sp),
                        topRight: Radius.circular(20.sp))),
                child: Column(
                  children: [
                    SizedBox(height: 3.h),
                    Center(
                      child: Image.asset(
                        AppPhotoLink.logoHelnay,
                        width: Get.width,
                        height: 27.h,
                        fit: BoxFit.contain,
                        color: Theme.of(context).primaryColorLight,
                      ),
                    ),
                    WebViewTermsAndPrivcey(
                        title: 'Privacy Policy',
                        ontap: controller.onPrivacyPolicyTap),
                    SizedBox(height: 2.h),
                    WebViewTermsAndPrivcey(
                        title: 'Terms Of Use',
                        ontap: controller.onTermsOfUseTap),
                    Spacer(),
                    Center(
                      child: Text('Version : 1.0.0',
                          style: Theme.of(context).textTheme.displayLarge),
                    ),
                    SizedBox(height: 2.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.sp),
                      child: SizedBox(
                        width: Get.width,
                        child: OptionButtonWidget(
                            titleButton: 'Delete Account'.toUpperCase(),
                            onButtonClick: controller.onDeleteAccountTap),
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.sp),
                      child: SizedBox(
                        width: Get.width,
                        child: OptionButtonWidget(
                            titleButton: 'Logout Account'.toUpperCase(),
                            onButtonClick: controller.onLogoutTap),
                      ),
                    ),
                    SizedBox(height: 2.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
