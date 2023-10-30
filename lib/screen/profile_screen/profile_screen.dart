import 'package:flutter/material.dart';
import 'package:project/screen/profile_screen/profile_screen_view_model.dart';
import 'package:project/screen/profile_screen/widget/profile_images_area.dart';
import 'package:project/screen/profile_screen/widget/profile_top_area.dart';
import '../../../utils/app_res.dart';
import '../../../utils/asset_res.dart';
import '../../../utils/color_res.dart';
import '../../../utils/const_res.dart';
import 'package:stacked/stacked.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileScreenViewModel>.reactive(
      onModelReady: (model) {
        model.init();
      },
      viewModelBuilder: () => ProfileScreenViewModel(),
      builder: (context, model, child) {
        return SizedBox(
          child: Column(
            children: [
              ProfileTopArea(
                onNotificationTap: model.onNotificationTap,
                onSearchTap: model.onSearchBtnTap,
              ),
              ProfileImageArea(
                userData: model.userData,
                pageController: model.pageController,
                onEditProfileTap: model.onEditProfileTap,
                onMoreBtnTap: model.onMoreBtnTap,
                onImageTap: model.onImageTap,
                onInstagramTap: model.onInstagramTap,
                onFacebookTap: model.onFBTap,
                onYoutubeTap: model.onYoutubeTap,
                isLoading: model.isLoading,
                isVerified: model.userData?.isVerified == 2 ? true : false,
                isSocialBtnVisible: model.isSocialBtnVisible,
              ),
            ],
          ),
        );
      },
    );
  }
}
