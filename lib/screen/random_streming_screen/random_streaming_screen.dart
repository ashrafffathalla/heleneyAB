import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/screen/random_streming_screen/random_streaming_screen_view_model.dart';
import 'package:stacked/stacked.dart';
import '../../../utils/color_res.dart';
import '../person_streaming_screen/widgets/comment_list_area.dart';
import 'widgets/bottom_text_field.dart';
import 'package:project/screen/random_streming_screen/widgets/top_bar_area.dart';
class RandomStreamingScreen extends StatelessWidget {
  const RandomStreamingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      // Status bar color
      statusBarColor: ColorRes.transparent,

      // Status bar brightness (optional)
      statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
      statusBarBrightness: Brightness.light, // For iOS (dark icons)
    ));
    return ViewModelBuilder<RandomStreamingScreenViewModel>.reactive(
      onViewModelReady: (model) {
        print("HH1");
        model.init();
        print("HH2");
      },
      viewModelBuilder: () => RandomStreamingScreenViewModel(),
      builder: (context, model, child) {
        return WillPopScope(
          onWillPop: () async {
            model.onEndBtnTap();
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
                        onEndBtnTap: model.onEndBtnTap,
                        onDiamondTap: model.onDiamondTap,
                        onSpeakerTap: model.onSpeakerTap,
                        onCameraTap: model.onCameraTap,
                        mute: model.muted,
                        user: model.liveStreamUser,
                      ),
                      const Spacer(),
                      CommentListArea(
                        commentList: model.commentList,
                        pageContext: context,
                      ),
                      BottomTextField(
                        commentController: model.commentController,
                        onMsgSend: model.onCommentSend,
                        commentFocus: model.commentFocus,
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
