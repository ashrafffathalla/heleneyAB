// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:project/controller/edit_profile_screen_controller/edit_profile_screen_controller.dart';
import 'package:project/core/constant/app_photo.dart';
import 'package:project/core/constant/handeldataview.dart';
import 'package:project/view/widget/edit_profile_screen_widget/image_list_area.dart';
import 'package:project/view/widget/edit_profile_screen_widget/widget/text_fields_area.dart';
import 'package:sizer/sizer.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      body: GetBuilder<EditProfileScreenControllerIMP>(
        init: EditProfileScreenControllerIMP(),
        builder: (controller) => Column(
          children: [
            Container(
              alignment: Alignment.bottomLeft,
              height: 8.h,
              child: IconButton(
                onPressed: controller.onBackBtnTap,
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
                child: GestureDetector(
                  onTap: controller.onAllScreenTap,
                  child: SizedBox(
                    height: Get.height,
                    width: Get.width,
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            controller.isLoading
                                ? Expanded(
                                    child: Lottie.asset(AppPhotoLink.loading,
                                        height: 70, width: 70),
                                  )
                                : HandlingDataView(
                                    statusRequest: controller.statusRequest,
                                    widget: Expanded(
                                      child: SingleChildScrollView(
                                        keyboardDismissBehavior:
                                            ScrollViewKeyboardDismissBehavior
                                                .onDrag,
                                        physics: const BouncingScrollPhysics(),
                                        child: Column(
                                          children: [
                                            const SizedBox(height: 16),
                                            ImageListArea(
                                              imageList: controller.imageList,
                                              onImgRemove:
                                                  controller.onImageRemove,
                                              onAddBtnTap:
                                                  controller.onImageAdd,
                                            ),
                                            TextFieldsArea(
                                              model: controller,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
