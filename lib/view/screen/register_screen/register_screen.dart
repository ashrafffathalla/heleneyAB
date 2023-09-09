// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/controller/register_screen_controller/register_screen_controller.dart';
import 'package:project/core/constant/component.dart';
import 'package:project/core/constant/custom_text_form_field.dart';
import 'package:project/core/constant/handeldataview.dart';
import 'package:project/core/func/auth/valid_input.dart';
import 'package:project/view/widget/register_widget/logo_register_widget.dart';
import 'package:sizer/sizer.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formState = GlobalKey();
    return Sizer(
      builder: (context, orientation, devicetype) => Scaffold(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        body: GetBuilder<RegisterScreenControllerIMP>(
          init: RegisterScreenControllerIMP(),
          builder: (controller) => Form(
            key: formState,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.bottomLeft,
                  height: 8.h,
                  child: IconButton(
                    onPressed: controller.goBack,
                    icon: Icon(
                      Icons.arrow_back_ios_new_outlined,
                      size: 10.sp,
                      color: Colors.black,
                    ),
                  ),
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
                              BoxConstraints(minHeight: Get.height - 5.h),
                          child: IntrinsicHeight(
                            child: Column(
                              children: [
                                LogoRegisterwidget(),
                                CustomTextFormFild(
                                  mycontroller: controller.nameController,
                                  hintText: "Enter your Name",
                                  lable: "Full Name",
                                  suffixIcon: CupertinoIcons.person_alt_circle,
                                  textInputType: TextInputType.emailAddress,
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return "Please enter your name";
                                    }
                                    return null;
                                  },
                                ),
                                CustomTextFormFild(
                                  mycontroller: controller.emailController,
                                  hintText: "Enter your e-mail",
                                  lable: "E-mail",
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
                                CustomTextFormFild(
                                  mycontroller: controller.confirmPwdController,
                                  hintText: "Enter your Confirm Password",
                                  lable: "Confirm Passowrd",
                                  suffixIcon: CupertinoIcons.eye_slash_fill,
                                  isShowText: controller.isShowPasswordConf,
                                  textInputType: TextInputType.visiblePassword,
                                  validator: (val) {
                                    return validInput(val!, 5, 100, "password");
                                  },
                                ),
                                CustomTextFormFild(
                                  mycontroller: controller.ageController,
                                  hintText: "Enter your age",
                                  lable: "AGE",
                                  suffixIcon: CupertinoIcons.phone_circle,
                                  textInputType: TextInputType.number,
                                  validator: (val) {
                                    return validInput(val!, 1, 100, 'val');
                                  },
                                ),
                                Spacer(),
                                customButton(
                                  title: "Sign UP".toUpperCase(),
                                  onTap: () {
                                    if (formState.currentState!.validate()) {
                                      controller.onContinueTap();
                                    } else {
                                      Get.snackbar("ERROR !!",
                                          "You must full all fields",
                                          snackPosition: SnackPosition.BOTTOM);
                                    }
                                  },
                                ),
                                SizedBox(height: 2.h),
                              ],
                            ),
                          ),
                        ),
                      ),
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
