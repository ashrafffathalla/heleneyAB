// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/controller/forget_password_screen_controller/forget_password_screen_controller.dart';
import 'package:project/core/constant/component.dart';
import 'package:project/core/constant/custom_text_form_field.dart';
import 'package:project/core/func/auth/valid_input.dart';
import 'package:project/view/widget/forget_password_screen_widget/forget_logo_widget.dart';
import 'package:sizer/sizer.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formState = GlobalKey();
    return Scaffold(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      body: GetBuilder<ForgetPasswordScreenControllerIMP>(
        init: ForgetPasswordScreenControllerIMP(),
        builder: (controller) => Sizer(
          builder: (context, orientation, devicetype) => Form(
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
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.sp),
                            topRight: Radius.circular(20.sp))),
                    child: SingleChildScrollView(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(minHeight: Get.height - 80),
                        child: IntrinsicHeight(
                          child: Column(
                            children: [
                              ForgetPasswordWidget(),
                              CustomTextFormFild(
                                mycontroller: controller.emailController,
                                hintText: "Enter your email",
                                lable: "E-Mail",
                                suffixIcon: CupertinoIcons.envelope_fill,
                                textInputType: TextInputType.emailAddress,
                                validator: (val) {
                                  return validInput(val!, 5, 100, "email");
                                },
                              ),
                              Spacer(flex: 1),
                              customButton(
                                title: "RESTART NOW",
                                onTap: () {
                                  if (formState.currentState!.validate()) {
                                    controller.resetBtnClick();
                                  } else {
                                    Get.snackbar("ERROR !!",
                                        "Please Enter Your e - mail",
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
