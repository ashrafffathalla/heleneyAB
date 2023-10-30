import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:stacked/stacked.dart';

import '../../api_provider/api_provider.dart';
import '../../common/widgets/common_fun.dart';
import '../../common/widgets/loader.dart';
import '../../common/widgets/snack_bar_widget.dart';
import '../../utils/app_res.dart';

class SubmitRedeemScreenViewModel extends BaseViewModel {
  String coinValue = '0';
  TextEditingController accountDetailController = TextEditingController();
  String? paymentGateway = AppRes.paypal;
  String accountError = '';
  bool isEmpty = false;
  // InterstitialAd? interstitialAd;
  List<String> paymentList = [AppRes.paypal, AppRes.bankTransfer];

  void init() {
    coinValue = Get.arguments;
    // initInterstitialAds();
  }

  void onBackBtnTap() {
    Get.back();
  }

  // void initInterstitialAds() {
  //   CommonFun.interstitialAd((ad) {
  //     // interstitialAd = ad;
  //   });
  // }

  void onPaymentChange(String? value) {
    paymentGateway = value;
    notifyListeners();
  }

  void onSubmitBtnTap() async {
    if (!isValid()) return;
    Loader().lottieLoader();
    ApiProvider()
        .placeRedeemRequest(paymentGateway, accountDetailController.text)
        .then((value) {
      if (value.status == true) {
        Get.back();
        // if (interstitialAd != null) {
        //   // interstitialAd?.show().then((value) {
        //   //   Get.back();
        //   // });
        // } else {
        //   Get.back();
        // }
      } else {
        Get.back();
        SnackBarWidget.snackBar(message: '${value.message}');
      }
    });
  }

  bool isValid() {
    int i = 0;
    if (accountDetailController.text == '') {
      accountError = AppRes.enterAccountDetails;
      isEmpty = true;
      i++;
    }
    notifyListeners();
    return i == 0 ? true : false;
  }
}
