// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/controller/login_screen_controller/login_screen_controller.dart';
import 'package:project/core/constant/app_photo.dart';
import 'package:project/core/constant/component.dart';
import 'package:project/core/constant/custom_text_form_field.dart';
import 'package:project/core/constant/handeldataview.dart';
import 'package:project/core/func/auth/valid_input.dart';
import 'package:project/view/widget/login_screen_widget/logo_login_widget.dart';
import 'package:project/view/widget/login_screen_widget/sign_with_account.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formState = GlobalKey();
    return WillPopScope(
      onWillPop: () async => false,
      child: Sizer(
        builder: (context, orientation, devicetype) => Scaffold(
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          body: GetBuilder<LoginScreencontrollerIMP>(
            init: LoginScreencontrollerIMP(),
            builder: (controller) => Form(
              key: formState,
              child: Column(
                children: [
                  SizedBox(
                    height: 8.h,
                    width: Get.width,
                  ),
                  Expanded(
                      child: HandlingDataView(
                    statusRequest: controller.statusRequest,
                    widget: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.sp),
                              topRight: Radius.circular(20.sp))),
                      child: SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints:
                              BoxConstraints(minHeight: Get.height - 3.h),
                          child: IntrinsicHeight(
                            child: Column(
                              children: [
                                LogoLoginwidget(),
                                CustomTextFormFild(
                                  mycontroller: controller.emailController,
                                  hintText: "Enter your email",
                                  lable: "E - Mail",
                                  suffixIcon: CupertinoIcons.envelope_fill,
                                  textInputType: TextInputType.emailAddress,
                                  validator: (val) {
                                    return validInput(val!, 5, 100, "email");
                                  },
                                ),
                                CustomTextFormFild(
                                  mycontroller: controller.passwordController,
                                  hintText: "Enter your password",
                                  lable: "Passowrd",
                                  suffixIcon: controller.iconDate,
                                  isShowText: controller.isShowPassword,
                                  sufficsIconTap: controller.changeShowPassword,
                                  textInputType: TextInputType.visiblePassword,
                                  validator: (val) {
                                    return validInput(val!, 5, 100, "password");
                                  },
                                ),
                                Container(
                                  alignment: Alignment.topRight,
                                  padding: EdgeInsets.only(right: 7.sp),
                                  child: TextButton(
                                    onPressed:
                                        controller.goToForrgetPasswordScreen,
                                    child: Text(
                                      "Forget Password !",
                                      textAlign: TextAlign.left,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 1.h),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 7.sp),
                                  child: Row(
                                    children: [
                                      SignWithAppleAndGmailWidget(
                                        logoName: "Sing in with gmail",
                                        logoAssets: AppPhotoLink.gmailLogo,
                                        ontap: controller.onGoogleTap,
                                      ),
                                      SizedBox(width: 7.w),
                                      SignWithAppleAndGmailWidget(
                                        logoName: "Sing in with apple",
                                        logoAssets: AppPhotoLink.appleLogo,
                                        ontap: controller.onAppleTap,
                                      ),
                                    ],
                                  ),
                                ),
                                Spacer(),
                                customButton(
                                  title: "LOGIN",
                                  onTap: () {
                                    if (formState.currentState!.validate()) {
                                      controller.login();
                                    } else {
                                      Get.snackbar("Error !!",
                                          "E-mail and password are required !",
                                          snackPosition: SnackPosition.BOTTOM);
                                    }
                                  },
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "If you don't have account?",
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayMedium,
                                    ),
                                    TextButton(
                                      onPressed: controller.goToRegisterScreen,
                                      child: Text(
                                        "Register NOW!".toUpperCase(),
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .appBarTheme
                                              .backgroundColor,
                                          fontSize: 9.sp,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 6.h),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
