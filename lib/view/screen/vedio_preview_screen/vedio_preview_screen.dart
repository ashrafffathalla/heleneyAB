// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/controller/vedio_preview_screen_controller/vedio_preview_screen_controller.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';

class VedioPerivewScreen extends StatelessWidget {
  const VedioPerivewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      body: Column(
        children: [
          SizedBox(height: 8.h, width: Get.width),
          Expanded(
            child: GetBuilder<VedioPrevireScreenControllerIMP>(
              init: VedioPrevireScreenControllerIMP(),
              builder: (controller) => Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.sp),
                        topRight: Radius.circular(20.sp))),
                child: Stack(
                  children: [
                    controller.isExceptionError
                        ? Text('Failed To Load Video',
                            style: Theme.of(context).textTheme.bodyMedium)
                        : Center(
                            child: AspectRatio(
                              aspectRatio: controller
                                  .videoPlayerController.value.aspectRatio,
                              child:
                                  VideoPlayer(controller.videoPlayerController),
                            ),
                          ),
                    Container(
                      margin: EdgeInsets.only(left: 20, top: 10),
                      child: InkWell(
                        onTap: controller.onBackBtnTap,
                        child: Icon(Icons.arrow_back_ios_new_outlined,
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        height: Get.height / 1.2,
                        width: double.infinity,
                        child: InkWell(
                          onTap: controller.onPlayPauseTap,
                          //splashColor: ColorRes.transparent,
                          //highlightColor: ColorRes.transparent,
                          child: AnimatedOpacity(
                            opacity: controller.isUIVisible == true ? 0.0 : 1.0,
                            duration: Duration(milliseconds: 500),
                            child: Icon(
                              controller.videoPlayerController.value.isPlaying
                                  ? Icons.pause
                                  : Icons.play_arrow,
                              color: Theme.of(context).primaryColor,
                              size: 35,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              '${_printDuration(controller.duration)} / ${_printDuration(controller.videoPlayerController.value.duration)}',
                              style: Theme.of(context).textTheme.bodyMedium),
                          VideoProgressIndicator(
                            controller.videoPlayerController,
                            allowScrubbing: true,
                            padding: const EdgeInsets.only(bottom: 15, top: 3),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    if (twoDigits(duration.inHours) == '00') {
      return '$twoDigitMinutes:$twoDigitSeconds';
    }
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}
