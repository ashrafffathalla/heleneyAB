import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/utils/const_res.dart';
import '../../../utils/app_res.dart';
import '../../../utils/asset_res.dart';
import '../../../utils/color_res.dart';

class BottomInfoField extends StatelessWidget {
  final String title;
  final String subTitle;
  final VoidCallback onNextTap;
  final VoidCallback onSkipTap;
  final String buttonText;

  const BottomInfoField({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.onNextTap,
    required this.onSkipTap,
    required this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height,
      width: Get.width,
      child: Column(
        children: [
          const Spacer(),
          Text(
            title,
            style: const TextStyle(
              color: ColorRes.veryDarkGrey,
              fontSize: 25,
              fontFamily: FontRes.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            subTitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: ColorRes.grey,
              fontSize: 16,
            ),
          ),
          SizedBox(height: Get.height / 12),
          InkWell(
            onTap: onNextTap,
            child: Container(
              height: 48,
              width: 238,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    ColorRes.lightOrange1,
                    ColorRes.darkOrange,
                  ],
                ),
              ),
              child: Center(
                child: Text(
                  buttonText,
                  style: const TextStyle(
                    color: ColorRes.white,
                    fontSize: 15,
                    fontFamily: FontRes.semiBold,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: Get.height / 25),
          InkWell(
            onTap: onSkipTap,
            child: const Text(
              AppRes.skip,
              style: TextStyle(
                color: ColorRes.dimGrey1,
                fontSize: 15,
              ),
            ),
          ),
          SizedBox(height: Get.height / 25),
        ],
      ),
    );
  }
}
