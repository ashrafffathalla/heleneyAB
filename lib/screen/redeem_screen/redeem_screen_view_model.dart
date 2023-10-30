import 'package:get/get.dart';

import 'package:stacked/stacked.dart';
import 'package:stacked/stacked.dart';

import '../../api_provider/api_provider.dart';
import '../../model/fetch_redeem_request.dart';

class RedeemScreenViewModel extends BaseViewModel {
  List<RedeemRequestData>? redeemData;
  bool isLoading = false;

  void init() {
    fetchRedeemRequest();
  }

  void onBackBtnTap() {
    Get.back();
  }

  void fetchRedeemRequest() {
    isLoading = true;
    ApiProvider().fetchRedeemRequest().then((value) {
      redeemData = value.data;
      isLoading = false;
      notifyListeners();
    });
  }
}
