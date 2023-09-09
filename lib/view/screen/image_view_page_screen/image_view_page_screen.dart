// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project/core/constant/component.dart';
import 'package:project/core/constant/link_api.dart';
import 'package:project/data/models/chat_and_live_model/chat.dart';

class ImageViewPage extends StatelessWidget {
  final ChatMessage? userData;
  final VoidCallback onBack;
  final TransformationController transformationController;
  final VoidCallback handleDoubleTap;
  final Function(TapDownDetails details) handleDoubleTapDown;

  const ImageViewPage(
      {Key? key,
      this.userData,
      required this.onBack,
      required this.transformationController,
      required this.handleDoubleTap,
      required this.handleDoubleTapDown})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Theme.of(context)
            .bottomNavigationBarTheme
            .unselectedIconTheme!
            .color,
        // Status bar brightness (optional)
        statusBarIconBrightness: Brightness.light, // For Android (dark icons)
        statusBarBrightness: Brightness.dark, // For iOS (dark icons)
      ),
    );
    return Scaffold(
      backgroundColor:
          Theme.of(context).bottomNavigationBarTheme.unselectedIconTheme!.color,
      body: SafeArea(
        child: Stack(
          children: [
            GestureDetector(
              onDoubleTapDown: handleDoubleTapDown,
              onDoubleTap: handleDoubleTap,
              child: InteractiveViewer(
                transformationController: transformationController,
                child: Image.network(
                  '${AppLink.aImageBaseUrl}${userData?.image}',
                  height: Get.height,
                  width: double.infinity,
                ),
              ),
            ),
            topBarArea(context)
          ],
        ),
      ),
    );
  }

  Widget topBarArea(context) {
    return Container(
      color: Theme.of(context)
          .bottomNavigationBarTheme
          .unselectedIconTheme!
          .color!
          .withOpacity(0.3),
      padding: const EdgeInsets.fromLTRB(21, 18, 23, 18),
      child: Row(
        children: [
          InkWell(
            onTap: onBack,
            //splashColor: ColorRes.transparent,
            //highlightColor: ColorRes.transparent,
            child: SizedBox(
                width: 20,
                height: 20,
                child: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  size: 20,
                )),
          ),
          const SizedBox(width: 20),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                      userData?.senderUser?.userid == user__ID
                          ? 'you'
                          : '${userData?.senderUser?.username} ',
                      style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
              Text(
                  DateFormat('"dd MMM yyyy", "hh:mm a"').format(
                      DateTime.fromMillisecondsSinceEpoch(
                          userData!.time!.toInt())),
                  style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ],
      ),
    );
  }
}
