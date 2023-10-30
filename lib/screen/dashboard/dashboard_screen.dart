import 'package:flutter/material.dart';
import 'package:project/screen/dashboard/widgets/bottom_bar.dart';
import 'package:project/screen/live_stream_history_screen/live_stream_history_screen.dart';
import 'package:project/utils/const_res.dart';
import '../../../utils/app_res.dart';
import '../../../utils/asset_res.dart';
import '../../../utils/color_res.dart';
import 'package:stacked/stacked.dart';

import '../explore_screen/explore_screen.dart';
import '../message_screen/message_screen.dart';
import '../profile_screen/profile_screen.dart';
import '../randoms_screen/randoms_screen.dart';
import 'dashboard_screen_view_model.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DashboardScreenViewModel>.reactive(
      onModelReady: (model) {
        model.init();
      },
      viewModelBuilder: () => DashboardScreenViewModel(),
      builder: (context, model, child) {
        return WillPopScope(
          onWillPop: model.onBack,
          child: Scaffold(
            backgroundColor: ColorRes.white,
            bottomNavigationBar: BottomBar(
              pageIndex: model.pageIndex,
              onBottomBarTap: model.onBottomBarTap,
            ),
            body: SafeArea(
              bottom: false,
              child: model.pageIndex == 0
                  ? const ExploreScreen()
                  : model.pageIndex == 1
                  ? const RandomsScreen()
                  : model.pageIndex == 2
                  ? const LiveStreamHistory()
                  : model.pageIndex == 3
                  ? const MessageScreen()
                  : const ProfileScreen(),
            ),
          ),
        );
      },
    );
  }
}
