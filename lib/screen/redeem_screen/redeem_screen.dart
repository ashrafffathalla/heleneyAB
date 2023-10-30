import 'package:flutter/material.dart';
import 'package:project/screen/redeem_screen/redeem_screen_view_model.dart';
import 'package:project/screen/redeem_screen/widgets/center_area_redeem_screen.dart';
import 'package:project/screen/redeem_screen/widgets/top_bar_redeem_screen.dart';
import '../../../utils/app_res.dart';
import '../../../utils/asset_res.dart';
import '../../../utils/color_res.dart';
import '../../../utils/const_res.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked.dart';

import '../../common/widgets/loader.dart';

class RedeemScreen extends StatelessWidget {
  const RedeemScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RedeemScreenViewModel>.reactive(
      onModelReady: (model) {
        model.init();
      },
      viewModelBuilder: () => RedeemScreenViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          body: Column(
            children: [
              TopBarRedeemScreen(onBackBtnTap: model.onBackBtnTap),
              Container(
                height: 1,
                margin: const EdgeInsets.symmetric(horizontal: 7),
                width: MediaQuery.of(context).size.width,
                color: ColorRes.grey5,
              ),
              !model.isLoading
                  ? CenterAreaRedeemScreen(redeemData: model.redeemData)
                  : Expanded(
                      child: Loader().lottieWidget(),
                    ),
            ],
          ),
        );
      },
    );
  }
}
