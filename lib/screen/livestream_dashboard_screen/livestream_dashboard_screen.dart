import 'package:flutter/material.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:project/screen/livestream_dashboard_screen/livestream_dashboard_screen_view_model.dart';
import 'package:project/screen/livestream_dashboard_screen/widgets/center_area_livestream_dashboard.dart';
import 'package:project/utils/const_res.dart';
import '../../../utils/app_res.dart';
import '../../../utils/asset_res.dart';
import '../../../utils/color_res.dart';
import 'package:stacked/stacked.dart';

import '../../common/widgets/loader.dart';
import 'widgets/top_area_livestream_dashboard.dart';

class LiveStreamDashBoard extends StatelessWidget {
  const LiveStreamDashBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LiveStreamDashBoardViewModel>.reactive(
      onModelReady: (model) {
        model.init();
      },
      viewModelBuilder: () => LiveStreamDashBoardViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: ColorRes.white,
          body: Column(
            children: [
              TopAreaLiveStreamDashBoard(onBackBtnTap: model.onBackBtnTap),
              Container(
                height: 1,
                margin: const EdgeInsets.symmetric(horizontal: 7),
                width: MediaQuery.of(context).size.width,
                color: ColorRes.grey5,
              ),
              model.isLoading
                  ? Expanded(child: Loader().lottieWidget())
                  : CenterAreaLiveStreamDashBoard(
                      onRedeemTap: model.onRedeemTap,
                      eligible: model.eligible,
                      onHistoryBtnTap: model.onHistoryBtnTap,
                      onRedeemBtnTap: model.onRedeemBtnTap,
                      onAddCoinsBtnTap: model.onAddCoinsBtnTap,
                      onApplyBtnTap: model.onApplyBtnTap,
                      wallet: model.userData?.wallet,
                      totalCollection:
                          model.userData?.totalCollected.toString(),
                      totalStream: model.userData?.totalStreams.toString(),
                    ),
              const SizedBox(
                height: 10,
              ),
              // if (model.bannerAd != null)
                // Container(
                //   alignment: Alignment.center,
                //   width: model.bannerAd?.size.width.toDouble(),
                //   height: model.bannerAd?.size.height.toDouble(),
                //   child: AdWidget(ad: model.bannerAd!),
                // ),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
        );
      },
    );
  }
}
