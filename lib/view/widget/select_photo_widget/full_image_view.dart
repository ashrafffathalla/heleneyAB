// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:project/core/constant/app_photo.dart';
import 'package:project/core/constant/component.dart';

class FullImageView extends StatelessWidget {
  final List<File>? imageList;
  final PageController pageController;
  final String fullName;
  final int? age;
  final String address;
  final String bioText;

  const FullImageView({
    Key? key,
    required this.imageList,
    required this.pageController,
    required this.fullName,
    required this.age,
    required this.address,
    required this.bioText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height / 1.65,
      margin: const EdgeInsets.symmetric(horizontal: 36),
      child: Stack(
        children: [
          imageList == null || imageList!.isEmpty
              ? Container(
                  width: Get.width,
                  height: Get.height / 1.65,
                  decoration: BoxDecoration(
                      color: Theme.of(context).buttonTheme.colorScheme!.error,
                      borderRadius: BorderRadius.circular(20)),
                  child: SvgPicture.asset(
                    AppPhotoLink.noImage,
                    height: 100,
                    width: 100,
                  ),
                )
              : PageView.builder(
                  controller: pageController,
                  itemCount: imageList?.length,
                  physics: const ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return FractionallySizedBox(
                      widthFactor: 1 / pageController.viewportFraction,
                      child: Container(
                        width: Get.width,
                        height: Get.height / 1.65,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(File(imageList![index].path)),
                          ),
                        ),
                      ),
                    );
                  },
                ),
          SizedBox(
            width: Get.width,
            height: Get.height / 1.65,
            child: Column(
              children: [
                const SizedBox(height: 14),
                TopStoryLine(
                    pageController: pageController, images: imageList ?? []),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(left: 9),
                  child: Row(
                    children: [
                      socialIcon(AppPhotoLink.instegramLogo, 13.58, context),
                      socialIcon(AppPhotoLink.facebookLogo, 18.0, context),
                      socialIcon(AppPhotoLink.youtubeLogo, 18.26, context),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 9, right: 9, bottom: 9, top: 7),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        width: Get.width,
                        padding: EdgeInsets.symmetric(
                            vertical: 8.15, horizontal: 11.77),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context)
                              .bottomNavigationBarTheme
                              .unselectedItemColor!
                              .withOpacity(0.33),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                      text: fullName,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium),
                                  TextSpan(
                                      text: " ${age ?? ''}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                GradientWidget(
                                  child:
                                      Icon(CupertinoIcons.placemark, size: 17),
                                ),
                                const SizedBox(width: 6),
                                Text(address,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Text(bioText,
                                style: Theme.of(context).textTheme.bodyMedium),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget socialIcon(String icon, double size, BuildContext context) {
    return Container(
      height: 27,
      width: 27,
      margin: EdgeInsets.only(right: 6.34),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).primaryColorLight,
      ),
      child: Center(
        child: SvgPicture.asset(icon,
            height: size, width: size, fit: BoxFit.cover),
      ),
    );
  }
}

class TopStoryLine extends StatefulWidget {
  final List<File> images;
  final PageController pageController;

  const TopStoryLine(
      {Key? key, required this.images, required this.pageController})
      : super(key: key);

  @override
  State<TopStoryLine> createState() => _TopStoryLineState();
}

class _TopStoryLineState extends State<TopStoryLine> {
  int currentPosition = 0;
  int lastCurrentPosition = 0;

  @override
  Widget build(BuildContext context) {
    widget.pageController.addListener(() {
      currentPosition = widget.pageController.page?.round() ?? 0;
      if (currentPosition != lastCurrentPosition) {
        if (mounted) {
          lastCurrentPosition = currentPosition;
          setState(() {});
        }
      }
    });
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 31),
      child: Row(
        children: List.generate(widget.images.length, (index) {
          return Expanded(
            child: Container(
              margin: const EdgeInsets.only(right: 3),
              height: 2.7,
              width: (Get.width - 62) / widget.images.length,
              decoration: BoxDecoration(
                color: currentPosition == index
                    ? Theme.of(context).primaryColorLight
                    : Theme.of(context).primaryColorLight.withOpacity(0.30),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
        }),
      ),
    );
  }
}
