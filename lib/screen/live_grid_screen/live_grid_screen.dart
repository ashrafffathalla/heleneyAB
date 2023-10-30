import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:project/screen/live_grid_screen/widgets/custom_grid_view.dart';
import 'package:project/utils/const_res.dart';
import '../../../utils/app_res.dart';
import '../../../utils/asset_res.dart';
import '../../../utils/color_res.dart';
import 'package:stacked/stacked.dart';

import '../../common/widgets/loader.dart';
import 'live_grid_screen_view_model.dart';
import 'widgets/live_grid_top_area.dart';

class LiveGridScreen extends StatelessWidget {
  const LiveGridScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LiveGridScreenViewModel>.reactive(
      onModelReady: (model) {
        model.init();
      },
      viewModelBuilder: () => LiveGridScreenViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: ColorRes.white,
          body: Column(
            children: [
              LiveGridTopArea(
                onBackBtnTap: model.onBackBtnTap,
                onGoLiveTap: model.goLiveBtnClick,
                userData: model.registrationUser,
              ),
              if (!model.isLoading)
                CustomGridView(
                  userData: model.userData,
                  onImageTap: model.onLiveStreamProfileTap,
                )
              else
                Expanded(
                  child: Loader().lottieWidget(),
                ),
              const SizedBox(
                height: 10,
              ),
              if (model.bannerAd != null)
                Container(
                  alignment: Alignment.center,
                  width: model.bannerAd?.size.width.toDouble(),
                  height: model.bannerAd?.size.height.toDouble(),
                  child: AdWidget(ad: model.bannerAd!),
                ),
            ],
          ),
        );
      },
    );
  }
}
