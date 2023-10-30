import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:stacked/stacked.dart';
import '../../api_provider/api_provider.dart';
import '../../common/widgets/common_fun.dart';
import '../../model/search/search_user.dart';
import '../../model/search/search_user_by_id.dart';
import '../../model/user/registration_user.dart';
import '../map_screen/map_screen.dart';
import '../user_detail_screen/user_detail_screen.dart';

class SearchScreenViewModel extends BaseViewModel {
  String selectedTab = '';
  int? selectedTabId = 0;
  TextEditingController searchController = TextEditingController();
  List<Interest>? tabList = [];
  List<RegistrationUserData>? searchUsers = [];
  int currentPage = 0;
  RefreshController refreshController = RefreshController();
  bool isLoading = false;

  void init() {
    getSearchUserData();
    // getBannerAd();
  }

  Future<bool> getSearchUserData(
      {bool isRefresh = false, int? selectedId}) async {
    isLoading = true;
    if (isRefresh) {
      currentPage = 0;
    }
    if (selectedTab.isNotEmpty) {
      SearchUserById? searchUserById = await ApiProvider()
          .searchUserById(searchController.text, selectedId, currentPage);
      if (searchUserById.data != null || searchUserById.data!.isNotEmpty) {
        if (isRefresh) {
          searchUsers = [];
          searchUsers = searchUserById.data!.cast<RegistrationUserData>();
        } else {
          searchUsers?.addAll(searchUserById.data! as Iterable<RegistrationUserData>);
        }
        currentPage += searchUserById.data!.length;
        notifyListeners();
        isLoading = false;
        return true;
      } else {
        return false;
      }
    } else {
      SearchUser? searchUserData =
          await ApiProvider().searchUser(searchController.text, currentPage);
      if (searchUserData.data != null || searchUserData.data!.isNotEmpty) {
        if (isRefresh) {
          searchUsers = [];
          searchUsers = searchUserData.data;
        } else {
          searchUsers?.addAll(searchUserData.data!);
        }
        currentPage += searchUserData.data!.length;
        notifyListeners();
        isLoading = false;
        return true;
      } else {
        searchUsers = [];
        return false;
      }
    }
  }

  void onRefresh() async {
    final result = selectedTab.isNotEmpty
        ? await getSearchUserData(isRefresh: true, selectedId: selectedTabId)
        : await getSearchUserData(isRefresh: true);
    if (result) {
      refreshController.refreshCompleted();
    } else {
      refreshController.refreshFailed();
    }
  }

  void onLoading() async {
    final result = selectedTab.isNotEmpty
        ? await getSearchUserData(selectedId: selectedTabId)
        : await getSearchUserData();
    if (result) {
      refreshController.loadComplete();
    } else {
      refreshController.loadFailed();
    }
  }

  void onBackBtnTap() {
    if (selectedTab == '') {
      Get.back();
    } else {
      selectedTab = '';
      getSearchUserData(isRefresh: true);
      notifyListeners();
    }
  }

  void onSearchBtnTap() {
    selectedTab.isNotEmpty
        ? getSearchUserData(isRefresh: true, selectedId: selectedTabId)
        : getSearchUserData(isRefresh: true);
  }

  void onLocationTap() {
    Get.to(
      () => const MapScreen(),
    );
  }

  void onTabSelect(String value) {
    selectedTab = value;
    notifyListeners();
  }

  void onTabSelectId(int? value) {
    selectedTabId = value;
    getSearchUserData(selectedId: selectedTabId, isRefresh: true);
    notifyListeners();
  }

  void onUserTap(RegistrationUserData? data) {
    Get.to(() => const UserDetailScreen(), arguments: data);
  }

  // void getBannerAd() {
  //   CommonFun.bannerAd((ad) {
  //     //bannerAd = ad as BannerAd;
  //     notifyListeners();
  //   });
  // }

// void searchApiWithInterestId(int? interestId) {
//   ApiProvider()
//       .searchUserById(searchController.text, interestId)
//       .then((value) {
//     searchUserDataList = value.data;
//     notifyListeners();
//   });
// }
}
