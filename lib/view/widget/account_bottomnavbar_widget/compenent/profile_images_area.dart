// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:project/core/constant/app_photo.dart';
import 'package:project/core/constant/component.dart';
import 'package:project/core/constant/link_api.dart';
import 'package:project/data/models/users/register_model.dart';
import 'package:project/view/widget/home_bottom_nav_bar_widget/compentent/topstory_home_bottomnavbar_widget.dart';
import 'package:project/view/widget/shimmer_screen_widget/shimmer_screen.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class ProfileImageArea extends StatelessWidget {
  final RegistrationUserData? userData;
  final PageController pageController;
  final VoidCallback onEditProfileTap;
  final VoidCallback onImageTap;
  final VoidCallback onMoreBtnTap;
  final VoidCallback onInstagramTap;
  final VoidCallback onFacebookTap;
  final VoidCallback onYoutubeTap;
  final bool isLoading;
  final bool isVerified;
  final bool Function(String? value) isSocialBtnVisible;

  const ProfileImageArea(
      {Key? key,
      this.userData,
      required this.pageController,
      required this.onEditProfileTap,
      required this.onMoreBtnTap,
      required this.onImageTap,
      required this.onInstagramTap,
      required this.onFacebookTap,
      required this.onYoutubeTap,
      required this.isLoading,
      required this.isVerified,
      required this.isSocialBtnVisible})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return fullImageView(context);
    } else {
      return Expanded(
        child: SizedBox(
          child: InkWell(
            onTap: onImageTap,
            child: Stack(
              children: [
                userData?.images == null || userData!.images!.isEmpty
                    ? Container(
                        width: Get.width,
                        height: Get.height,
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).buttonTheme.colorScheme!.error,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: SvgPicture.asset(AppPhotoLink.noImage),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        child: PageView.builder(
                          controller: pageController,
                          itemCount: userData?.images?.length,
                          physics: const ClampingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Image.network(
                              '${AppLink.aImageBaseUrl}${userData?.images?[index].image}',
                              fit: BoxFit.cover,
                              filterQuality: FilterQuality.medium,
                              /* loadingBuilder: (context, url, progress) {
                                    return ShimmerScreen.rectangular(
                                      width: Get.width,
                                      height: Get.height - 256,
                                      shapeBorder: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    );
                                  }, */
                              errorBuilder: (context, url, error) {
                                return Container(
                                  color: Theme.of(context)
                                      .buttonTheme
                                      .colorScheme!
                                      .error,
                                  child: SvgPicture.asset(AppPhotoLink.noImage),
                                );
                              },
                            );
                          },
                        ),
                      ),
                Column(
                  children: [
                    const SizedBox(height: 14),
                    TopStoryLineWidget(
                        images: userData?.images ?? [],
                        pageController: pageController),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          socialIcon(
                              AppPhotoLink.instegramLogo,
                              15,
                              onInstagramTap,
                              isSocialBtnVisible(userData?.instagram),
                              context),
                          socialIcon(
                              AppPhotoLink.facebookLogo,
                              21.0,
                              onFacebookTap,
                              isSocialBtnVisible(userData?.facebook),
                              context),
                          socialIcon(
                              AppPhotoLink.youtubeLogo,
                              20.16,
                              onYoutubeTap,
                              isSocialBtnVisible(
                                userData?.youtube,
                              ),
                              context),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 0, top: 7),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            width: Get.width,
                            padding: const EdgeInsets.fromLTRB(13, 9, 13, 12),
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
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('${userData?.fullname}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium),
                                    Text(" ${userData?.age ?? ''}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium),
                                    const SizedBox(width: 4),
                                    Visibility(
                                      visible: isVerified,
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                              height: 9,
                                              width: 9,
                                              color: Theme.of(context)
                                                  .primaryColorDark),
                                          SvgPicture.asset(
                                            AppPhotoLink.tickMark,
                                            height: 17.5,
                                            width: 18.33,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Visibility(
                                  visible: userData?.live?.isEmpty ?? false
                                      ? false
                                      : true,
                                  child: Row(
                                    children: [
                                      GradientWidget(
                                        child: Icon(
                                          CupertinoIcons.placemark,
                                          size: 18,
                                        ),
                                      ),
                                      const SizedBox(width: 6),
                                      Text(userData?.live ?? 'Unknown',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 7),
                                Text(
                                  userData?.bio ?? '',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  maxLines: 3,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                                right: 3.w, left: 3.w, bottom: 12.h),
                            child: InkWell(
                              onTap: onEditProfileTap,
                              borderRadius: BorderRadius.circular(10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaY: 15, sigmaX: 15),
                                  child: Container(
                                    height: 77,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Theme.of(context)
                                          .bottomNavigationBarTheme
                                          .unselectedItemColor!
                                          .withOpacity(0.33),
                                    ),
                                    child: Center(
                                      child: Text('Edit Profile',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 10, bottom: 12.h),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10),
                            onTap: onMoreBtnTap,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaY: 15, sigmaX: 15),
                                child: Container(
                                  height: 77,
                                  width: 56,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Theme.of(context)
                                        .bottomNavigationBarTheme
                                        .unselectedItemColor!
                                        .withOpacity(0.33),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      CupertinoIcons.ellipsis,
                                      color:
                                          Theme.of(context).primaryColorLight,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  Widget socialIcon(String icon, double size, VoidCallback onSocialIconTap,
      bool isVisible, BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: InkWell(
        onTap: onSocialIconTap,
        child: Container(
          height: 29,
          width: 29,
          margin: EdgeInsets.only(right: 7),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).primaryColorDark,
          ),
          child: Center(
            child: Image.asset(icon, height: size, width: size),
          ),
        ),
      ),
    );
  }

  Widget fullImageView(context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(left: 21, top: 10, right: 21, bottom: 20),
        child: Stack(
          children: [
            ShimmerScreen.rectangular(
              width: double.infinity,
              height: Get.height,
              shapeBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(21),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                child: Shimmer(
                  gradient: const LinearGradient(
                    colors: [
                      Colors.white24,
                      Colors.white38,
                      Colors.white54,
                    ],
                    stops: [
                      0.3,
                      0.6,
                      0.9,
                    ],
                    begin: Alignment(-1.0, -0.3),
                    end: Alignment(1.0, 0.3),
                    tileMode: TileMode.mirror,
                  ),
                  direction: ShimmerDirection.ltr,
                  child: Container(
                    width: double.infinity,
                    height: 5,
                    decoration: ShapeDecoration(
                        color: Theme.of(context).primaryColorDark,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4))),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                children: [
                  const Spacer(),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 90,
                      margin: const EdgeInsets.only(
                          right: 15, left: 15, bottom: 10),
                      padding: const EdgeInsets.all(5),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Theme.of(context)
                              .primaryColorDark
                              .withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: ShimmerScreen.rectangular(
                              height: 20,
                              width: 200,
                              shapeBorder: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            child: ShimmerScreen.rectangular(
                              height: 15,
                              width: 175,
                              shapeBorder: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(right: 5),
                            child: ShimmerScreen.rectangular(
                              height: 10,
                              width: double.infinity,
                              shapeBorder: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(5),
                                  bottomRight: Radius.circular(5),
                                ),
                              ),
                            ),
                          ),
                          const ShimmerScreen.rectangular(
                            height: 10,
                            width: 200,
                            shapeBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(0),
                              ),
                            ),
                          ),
                          ShimmerScreen.rectangular(
                            height: 10,
                            width: 250,
                            shapeBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(5),
                                topRight: Radius.circular(5),
                                bottomRight: Radius.circular(5),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Container(
                            height: 40,
                            margin: EdgeInsets.only(left: 15, bottom: 15),
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .primaryColorDark
                                  .withOpacity(0.5),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                                padding: EdgeInsets.only(
                                  left: 0,
                                ),
                                child: LottieBuilder.asset(
                                  AppPhotoLink.loading,
                                )),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 40,
                            margin: EdgeInsets.only(
                                left: 15, right: 15, bottom: 15),
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .primaryColorDark
                                    .withOpacity(0.5),
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: 0,
                              ),
                              child: LottieBuilder.asset(
                                AppPhotoLink.loading,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
