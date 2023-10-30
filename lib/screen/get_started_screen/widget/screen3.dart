import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/utils/const_res.dart';
import '../../../utils/app_res.dart';
import '../../../utils/asset_res.dart';
import '../../../utils/color_res.dart';
import 'bottom_info_field.dart';

class Screen3 extends StatelessWidget {
  final VoidCallback onNextTap;
  final VoidCallback onSkipTap;

  const Screen3({
    Key? key,
    required this.onNextTap,
    required this.onSkipTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width,
      color: ColorRes.white,
      child: Stack(
        children: [
          Container(
            width: Get.width,
            height: Get.height / 1.9,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Center(
              child: Image.asset(
                AssetRes.getStarted3BG,
                width: Get.width,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            width: Get.width,
            height: Get.height / 1.9,
            child: Center(
              child: Image.asset(
                AssetRes.getStarted3Marker,
                width: Get.width / 2.1,
                fit: BoxFit.cover,
              ),
            ),
          ),
          BottomInfoField(
            title: AppRes.nearbyProfileOnMap,
            subTitle: AppRes.getStarted3Subtitle,
            onNextTap: onNextTap,
            onSkipTap: onSkipTap,
            buttonText: AppRes.allow,
          )
        ],
      ),
    );
  }
}
