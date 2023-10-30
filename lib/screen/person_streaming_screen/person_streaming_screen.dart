import 'package:flutter/material.dart';
import 'package:project/screen/person_streaming_screen/widgets/bottom_text_field.dart';
import 'package:project/screen/person_streaming_screen/widgets/top_bar_area.dart';
import 'package:project/utils/const_res.dart';
import '../../../common/widgets/buttons.dart';
import '../../../model/get_diamond_pack.dart';
import '../../../utils/app_res.dart';
import '../../../utils/asset_res.dart';
import '../../../utils/color_res.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked.dart';

import '../random_streming_screen/widgets/comment_list_area.dart';
import 'person_streaming_screen_view_model.dart';

class PersonStreamingScreen extends StatelessWidget {
  const PersonStreamingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PersonStreamingScreenViewModel>.reactive(
      onModelReady: (model) {
        model.init();
      },
      viewModelBuilder: () => PersonStreamingScreenViewModel(),
      builder: (context, model, child) {
        return WillPopScope(
          onWillPop: () async {
            model.onExitTap();
            return false;
          },
          child: Scaffold(
              body: Stack(
            children: [
              model.broadcastView(),
              InkWell(
                onTap: () {
                  model.commentFocus.unfocus();
                },
                splashColor: ColorRes.transparent,
                highlightColor: ColorRes.transparent,
                child: Column(
                  children: [
                    TopBarArea(
                      onViewTap: model.onViewTap,
                      onMoreBtnTap: model.onMoreBtnTap,
                      onExitTap: model.onExitTap,
                      liveStreamUser: model.liveStreamUser,
                      onUserTap: model.onUserTap,
                    ),
                    const Spacer(),
                    CommentListArea(
                      commentList: model.commentList,
                      pageContext: context,
                    ),
                    BottomTextField(
                      commentController: model.commentController,
                      commentFocus: model.commentFocus,
                      onMsgSend: model.onCommentSend,
                      onGiftTap: model.onGiftBtnTap,
                      onGoProTap: model.onGoPremiumTap,
                      count: model.countDownValue,
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          )),
        );
      },
    );
  }
}
