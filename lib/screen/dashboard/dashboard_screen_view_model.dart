import 'package:flutter/services.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';
import 'package:get/get.dart';
import 'package:project/utils/const_res.dart';
import '../../../utils/app_res.dart';
import '../../../utils/asset_res.dart';
import '../../../utils/color_res.dart';
import 'package:stacked/stacked.dart';

import '../../api_provider/api_provider.dart';
import '../../common/widgets/snack_bar_widget.dart';
import '../../model/user/registration_user.dart';
import '../live_grid_screen/live_grid_screen.dart';
import '../user_detail_screen/user_detail_screen.dart';

class DashboardScreenViewModel extends BaseViewModel {
  int pageIndex = 0;
  RegistrationUserData? userData;

  void init() {
    FlutterBranchSdk.initSession().listen(
          (data) {
        if (data.containsKey("+clicked_branch_link") &&
            data["+clicked_branch_link"] == true) {
          if (data.containsKey('user_id')) {
            Get.to(() => const UserDetailScreen(), arguments: data['user_id']);
          }
        }
      },
      onError: (error) {
        PlatformException platformException = error as PlatformException;
        SnackBarWidget().snackBarWidget(
            'InitSession error: ${platformException.code} - ${platformException.message}');
      },
    );
    getProfileApiCall();
  }

  void getProfileApiCall() {
    ApiProvider().getProfile(userID: ConstRes.aUserId).then((value) {
      userData = value?.data;
      notifyListeners();
    });
  }

  void onBottomBarTap(int index) {
    if (userData?.isBlock == 1 && index == 4) {
      pageIndex = index;
      notifyListeners();
      return;
    }
    if (userData?.isBlock == 1) {
      return SnackBarWidget().snackBarWidget(AppRes.userBlock);
    }
    if (index != 2) {
      pageIndex = index;
      notifyListeners();
    } else {
      Get.to(() => const LiveGridScreen());
    }
  }

  Future<bool> onBack() async {
    if (pageIndex == 0) {
      return true;
    } else {
      pageIndex = 0;
      notifyListeners();
      return false;
    }
  }
}
