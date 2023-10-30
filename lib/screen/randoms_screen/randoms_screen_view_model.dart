import 'package:get/get.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../utils/app_res.dart';
import '../../../utils/asset_res.dart';
import '../../../utils/color_res.dart';
import '../../../utils/const_res.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked.dart';

import '../../common/widgets/common_fun.dart';
import '../../common/widgets/snack_bar_widget.dart';
import '../../model/user/registration_user.dart';
import '../../service/pref_service.dart';
import '../notification_screen/notification_screen.dart';
import '../randoms_search_screen/randoms_search_screen.dart';
import '../search_screen/search_screen.dart';

class RandomsScreenViewModel extends BaseViewModel {
  RegistrationUserData? data;
  List<String> genderList = [AppRes.boys, AppRes.both, AppRes.girls];
  String selectedGender = AppRes.both;
  bool isLoading = false;
  // BannerAd? bannerAd;

  void init() {
    getProfileApiCall();
    // getBannerAd();
  }

  void getProfileApiCall() async {
    isLoading = true;
    PrefService.getUserData().then((value) {
      data = value;
      isLoading = false;
      notifyListeners();
    });
  }

  void onNotificationTap() {
    data?.isBlock == 1
        ? SnackBarWidget().snackBarWidget(AppRes.userBlock)
        : Get.to(() => const NotificationScreen());
  }

  void onSearchBtnTap() {
    data?.isBlock == 1
        ? SnackBarWidget().snackBarWidget(AppRes.userBlock)
        : Get.to(() => const SearchScreen());
  }

  void onGenderChange(String value) {
    data?.isBlock == 1
        ? SnackBarWidget().snackBarWidget(AppRes.userBlock)
        : selectedGender = value;
    notifyListeners();
  }

  void onStartMatchingTap() {
    data?.isBlock == 1
        ? SnackBarWidget().snackBarWidget(AppRes.userBlock)
        : Get.to(() => const RandomsSearchScreen(), arguments: [
            {
              ConstRes.aGender: selectedGender,
              FirebaseConst.image: data?.images?[0].image ?? ''
            }
          ]);
  }

  void getBannerAd() {
    // CommonFun.bannerAd((ad) {
    //   // bannerAd = ad as BannerAd;
    //   notifyListeners();
    // });
  }
}
