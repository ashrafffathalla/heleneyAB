// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/controller/start_data_user_intery_controller.dart/start_data_user_intery_controller.dart';
import 'package:project/core/constant/component.dart';
import 'package:project/core/constant/handeldataview.dart';
import 'package:project/view/widget/start_data_user_intery_widget/text_field_area/text_fields_area.dart';
import 'package:project/view/widget/start_data_user_intery_widget/top_card_area.dart';
import 'package:sizer/sizer.dart';

class StartDataUserInteryScreen extends StatelessWidget {
  const StartDataUserInteryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        body: GetBuilder<StartDataUserInteryControllerIMP>(
          init: StartDataUserInteryControllerIMP(),
          builder: (controller) => Column(
            children: [
              SizedBox(height: 8.h, width: Get.width),
              Expanded(
                child: HandlingDataView(
                  statusRequest: controller.statusRequest,
                  widget: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.sp),
                            topRight: Radius.circular(20.sp))),
                    child: SizedBox(
                      height: Get.height,
                      width: Get.width,
                      child: Column(
                        children: [
                          SizedBox(height: 20),
                          TopCardArea(fullName: controller.fullName),
                          SizedBox(height: 18),
                          TextFieldsArea(
                            addressController: controller.addressController,
                            bioController: controller.bioController,
                            ageController: controller.ageController,
                            gender: controller.gender,
                            addressFocus: controller.addressFocus,
                            ageFocus: controller.ageFocus,
                            bioFocus: controller.bioFocus,
                            onGenderTap: controller.onGenderTap,
                            onTextFieldTap: controller.onAllScreenTap,
                            showDropdown: controller.showDropdown,
                            onGenderChange: controller.onGenderChange,
                            bioError: controller.bioError,
                            addressError: controller.addressError,
                            ageError: controller.ageError,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 16, right: 16, bottom: 22),
                            child: SubmitButton2(
                                title: 'Next', onTap: controller.onNextTap),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
