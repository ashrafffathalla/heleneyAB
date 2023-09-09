// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/controller/vedio_player_screen_controller/vedio_player_screen_controller.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatelessWidget {
  const VideoPlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<VedioPlayerScreenControllerIMP>(
        init: VedioPlayerScreenControllerIMP(),
        builder: (controller) => Column(
          children: [
            Container(
              alignment: Alignment.bottomLeft,
              height: 8.h,
              child: IconButton(
                onPressed: controller.onBackBtnTap,
                icon: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  size: 16.sp,
                  color: Colors.black,
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.sp),
                        topRight: Radius.circular(20.sp))),
                child: Column(
                  children: [
                    Expanded(
                      child: controller.isExceptionError
                          ? const Center(
                              child: Text('Failed to load video: Cannot Open'))
                          : Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                Center(
                                  child: Container(
                                    width: MediaQuery.of(context).size.height /
                                        1.3,
                                    height: MediaQuery.of(context).size.height /
                                        1.3,
                                    margin: const EdgeInsets.all(10),
                                    child: VideoPlayer(
                                        controller.videoPlayerController),
                                  ),
                                ),
                                InkWell(
                                  onTap: controller.onPlayPauseTap,
                                  child: Center(
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.5),
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: Icon(
                                        !controller.videoPlayerController.value
                                                .isPlaying
                                            ? Icons.play_arrow
                                            : Icons.pause,
                                        color: Colors.grey,
                                        size: 30,
                                      ),
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        '${_printDuration(controller.duration)} / ${_printDuration(controller.videoPlayerController.value.duration)}'),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: VideoProgressIndicator(
                                        controller.videoPlayerController,
                                        allowScrubbing: true,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}
