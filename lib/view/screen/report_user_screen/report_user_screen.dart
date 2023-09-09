import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/controller/report_screen_controller/report_screen_controller.dart';
import 'package:project/view/widget/report_screen_widget/report_bottomsheet.dart';
import 'package:sizer/sizer.dart';

class ReportUsersScreen extends StatelessWidget {
  const ReportUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: GetBuilder<ReportScreenControllerIMP>(
        init: ReportScreenControllerIMP(),
        builder: (controller) {
          // List<Images>? image = controller.registrationUserData?.images;
          return Column(
            children: [
              Container(
                alignment: Alignment.bottomLeft,
                height: 8.h,
                child: IconButton(
                  onPressed: controller.onBackBtnClick,
                  icon: Icon(
                    Icons.arrow_back_ios_new_outlined,
                    size: 16.sp,
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
                      constraints: BoxConstraints(minHeight: Get.height - 8.h),
                      child: IntrinsicHeight(
                        child: ReportBottomSheet(
                          onBackBtnTap: controller.onBackBtnClick,
                          showDropdown: controller.isShowDown,
                          onReasonTap: controller.onReasonTap,
                          reason: controller.reason,
                          checkBoxValue: controller.isCheckBox,
                          explainMore: controller.explainController,
                          reasonList: controller.reasonList,
                          onCheckBoxChange: controller.onCheckBoxChange,
                          onReasonChange: controller.onReasonChange,
                          onSubmitBtnTap: controller.onBackBtnClick,
                          fullName: '${controller.fullName}  ${controller.age}',
                          profileImage: controller.userImage,
                          address: controller.city,
                          explainMoreFocus: controller.explainMoreFocus,
                          explainMoreError: controller.explainMoreError,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
