import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/controller/select_photo_screen_controller/select_phot_screen_controller.dart';
import 'package:project/view/widget/select_photo_widget/bottom_selection_list.dart';
import 'package:project/view/widget/select_photo_widget/full_image_view.dart';
import 'package:sizer/sizer.dart';

class SelectPhotoScreen extends StatelessWidget {
  const SelectPhotoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        body: GetBuilder<SelectPhotoScreenControllerIMP>(
          init: SelectPhotoScreenControllerIMP(),
          builder: (controller) => Column(
            children: [
              SizedBox(height: 8.h, width: Get.width),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.sp),
                          topRight: Radius.circular(20.sp))),
                  child: Column(
                    children: [
                      const SizedBox(height: 15),
                      SizedBox(height: Get.height / 25),
                      FullImageView(
                        imageList: controller.imageFileList,
                        pageController: controller.pageController,
                        fullName: controller.fullName,
                        age: controller.age,
                        address: controller.address,
                        bioText: controller.bioText,
                      ),
                      const Spacer(),
                      BottomSelectionList(
                        imageList: controller.imageFileList,
                        selectedIndex: controller.pageIndex,
                        onAddBtnTap: controller.onImageAdd,
                        onImgRemove: controller.onImageRemove,
                        onPlayBtnTap: controller.onPlayButtonTap,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
