import 'package:flutter/material.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:project/screen/search_screen/search_screen_view_model.dart';
import 'package:project/screen/search_screen/widgets/search_bar_area.dart';
import 'package:project/screen/search_screen/widgets/user_list.dart';
import '../../../utils/app_res.dart';
import '../../../utils/asset_res.dart';
import '../../../utils/color_res.dart';
import '../../../utils/const_res.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked.dart';

import '../../common/widgets/loader.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SearchScreenViewModel>.reactive(
      onModelReady: (model) {
        model.init();
      },
      viewModelBuilder: () => SearchScreenViewModel(),
      builder: (context, model, child) {
        return WillPopScope(
          onWillPop: () async {
            model.onBackBtnTap();
            return false;
          },
          child: Scaffold(
            backgroundColor: ColorRes.white,
            body: Column(
              children: [
                SearchBarArea(
                  searchController: model.searchController,
                  selectedTab: model.selectedTab,
                  tabList: model.tabList,
                  onBackBtnTap: model.onBackBtnTap,
                  onSearchBtnTap: model.onSearchBtnTap,
                  onLocationTap: model.onLocationTap,
                  onTabSelect: model.onTabSelect,
                  onTapSelectId: model.onTabSelectId,
                ),
                const SizedBox(height: 11),
                model.isLoading
                    ? Expanded(child: Loader().lottieWidget())
                    : UserList(
                        userList: model.searchUsers,
                        onUserTap: model.onUserTap,
                        refreshController: model.refreshController,
                        onRefresh: model.onRefresh,
                        onLoading: model.onLoading,
                      ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
