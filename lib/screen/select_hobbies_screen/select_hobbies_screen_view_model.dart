import 'package:get/get.dart';
import '../../../utils/app_res.dart';
import '../../../utils/asset_res.dart';
import '../../../utils/color_res.dart';
import '../../../utils/const_res.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked.dart';

import '../../api_provider/api_provider.dart';
import '../../common/widgets/loader.dart';
import '../../model/user/registration_user.dart';
import '../dashboard/dashboard_screen.dart';

class SelectHobbiesScreenViewModel extends BaseViewModel {
  List<Interest>? hobbiesList = [];
  List<String> selectedList = [];
  String fullName = '';
  int age = 0;
  String address = '';
  String bioText = '';
  String latitude = '';
  String longitude = '';

  void init() {
    getInterestApiCall();
  }

  void onClipTap(String value) {
    bool selected = selectedList.contains(value);
    if (selected) {
      selectedList.remove(value);
    } else {
      selectedList.add(value);
    }
    notifyListeners();
  }

  void getInterestApiCall() async {
    ApiProvider().getInterest().then((value) {
      if (value != null && value.status!) {
        hobbiesList = value.data;
        notifyListeners();
      }
    });
  }

  void onNextTap() {
    if (selectedList.isEmpty) return;
    Loader().lottieLoader();
    ApiProvider().updateProfile(interest: selectedList).then((value) async {
      Get.back();
      Get.offAll(() => const DashboardScreen());
    });
  }

  void onSkipTap() {
    Get.offAll(() => const DashboardScreen());
  }
}
