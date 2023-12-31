import 'dart:io';

import 'package:bubbly_camera/bubbly_camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/app_res.dart';
import '../../../utils/asset_res.dart';
import '../../../utils/color_res.dart';
import '../../../utils/const_res.dart';
import 'package:stacked/stacked.dart';

import '../../api_provider/api_provider.dart';
import '../../model/get_package.dart';

class PremiumScreenViewModel extends BaseViewModel {
  PageController pageController = PageController(initialPage: 0);
  int selectedOffer = 1;
  List<GetPackageData>? packageData = [];
  bool isLoading = false;
  int descIndex = 0;

  void init() {
    getPackageApiCall();
  }

  void getPackageApiCall() {
    isLoading = true;
    ApiProvider().getPackage().then((value) {
      packageData = value.data;
      isLoading = false;
      notifyListeners();
    });
  }

  List<String> descTitle = [
    AppRes.enjoyLive,
    AppRes.enjoyLive,
    AppRes.enjoyLive,
    AppRes.enjoyLive,
    AppRes.enjoyLive,
    AppRes.enjoyLive,
  ];
  List<String> descSubtitle = [
    AppRes.enjoyLiveDesc,
    AppRes.enjoyLiveDesc,
    AppRes.enjoyLiveDesc,
    AppRes.enjoyLiveDesc,
    AppRes.enjoyLiveDesc,
    AppRes.enjoyLiveDesc,
  ];

  void onBackBtnTap() {
    Get.back();
  }

  void onExclusivePageChange(int index) {
    notifyListeners();
  }

  void onOfferSelect(int index) {
    selectedOffer = index;
    notifyListeners();
  }

  void onContinueTap() {
    BubblyCamera.inAppPurchase(Platform.isAndroid
        ? packageData![selectedOffer].playid
        : packageData![selectedOffer].appid);
    //Get.back();
  }

  void onNoThanksTap() {
    Get.back();
  }
}
