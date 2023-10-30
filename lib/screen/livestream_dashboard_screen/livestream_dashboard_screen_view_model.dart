import 'dart:io';

import 'package:bubbly_camera/bubbly_camera.dart';
import 'package:get/get.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:project/screen/submit_redeem_screen/submit_redeem_screen.dart';
import 'package:project/utils/const_res.dart';
import '../../../utils/app_res.dart';
import '../../../utils/asset_res.dart';
import '../../../utils/color_res.dart';
import 'package:stacked/stacked.dart';

import '../../api_provider/api_provider.dart';
import '../../common/widgets/common_fun.dart';
import '../../model/get_diamond_pack.dart';
import '../../model/user/registration_user.dart';
import '../bottom_diamond_shop/bottom_diamond_shop.dart';
import '../live_stream_history_screen/live_stream_history_screen.dart';
import '../live_stream_screen/live_stream_screen.dart';
import '../redeem_screen/redeem_screen.dart';

class LiveStreamDashBoardViewModel extends BaseViewModel {
  int eligible = 0;
  bool isLoading = false;
  RegistrationUserData? userData;
  String? coinValue;
  // BannerAd? bannerAd;

  void init() {
    getProfileApiCall();
    // getBannerAd();
  }

  void getProfileApiCall() {
    isLoading = true;
    ApiProvider().getProfile(userID: ConstRes.aUserId).then((value) async {
      userData = value?.data;
      eligible = value?.data?.canGoLive == 0
          ? 0
          : value?.data?.canGoLive == 1
              ? 1
              : 2;
      coinValue = value?.data?.wallet.toString() ?? '0';
      isLoading = false;
      notifyListeners();
    });
  }

  void onRedeemTap() {
    Get.to(() => const SubmitRedeemScreen(), arguments: coinValue)
        ?.then((value) {
      getProfileApiCall();
    });
  }

  void onAddCoinsBtnTap() {
    Get.bottomSheet(
      const BottomDiamondShop(),
      backgroundColor: ColorRes.transparent,
    ).then((value) {
      getProfileApiCall();
    });
  }

  void onDiamondPurchase(GetDiamondPackData? data) {
    BubblyCamera.inAppPurchase(
        Platform.isAndroid ? data?.androidProductId : data?.iosProductId);
  }

  void onBackBtnTap() {
    Get.back();
  }

  void onHistoryBtnTap() {
    Get.to(() => const LiveStreamHistory());
  }

  void onRedeemBtnTap() {
    Get.to(() => const RedeemScreen());
  }

  // void getBannerAd() {
  //   CommonFun.bannerAd((ad) {
  //     bannerAd = ad as BannerAd;
  //     notifyListeners();
  //   });
  // }

  void onApplyBtnTap() {
    Get.to(() => const LiveStreamScreen())?.then((value) {
      getProfileApiCall();
    });
  }
}
