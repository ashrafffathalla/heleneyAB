import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project/core/constant/component.dart';
import 'package:project/core/constant/link_api.dart';
import 'package:project/data/models/chat_and_live_model/chat.dart';

const yourSelectedPadding = EdgeInsets.symmetric(horizontal: 10, vertical: 2);
const yourPadding = EdgeInsets.symmetric(horizontal: 10);
const yourSelectedMargin = EdgeInsets.symmetric(vertical: 0);
const yourMargin = EdgeInsets.symmetric(vertical: 2);

class ChatArea extends StatelessWidget {
  final Map<String, List<ChatMessage>>? chatData;
  final Function(ChatMessage? imageData) onImageTap;
  final ScrollController scrollController;
  final Function(ChatMessage? item) onVideoItemClick;
  final Function(ChatMessage? chatMessage) onLongPress;
  final List<String> timeStamp;

  const ChatArea({
    Key? key,
    required this.chatData,
    required this.onImageTap,
    required this.scrollController,
    required this.onVideoItemClick,
    required this.onLongPress,
    required this.timeStamp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowIndicator();
          return true;
        },
        child: ListView.builder(
          controller: scrollController,
          reverse: true,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          itemCount: chatData != null ? chatData?.keys.length : 0,
          physics: Platform.isAndroid
              ? const ClampingScrollPhysics()
              : const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            String? date = chatData?.keys.elementAt(index) ?? '';
            List<ChatMessage>? messages = chatData?[date];
            return Column(
              children: [
                alertView(date, context),
                ListView.builder(
                  itemCount: messages?.length,
                  reverse: true,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      child: messages?[index].senderUser?.userid == user__ID
                          ? yourMsg(messages?[index], context)
                          : otherUserMsg(messages?[index], context),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget yourMsg(ChatMessage? data, context) {
    bool selected = timeStamp.contains('${data?.time?.round()}');
    return GestureDetector(
      onLongPress: () {
        onLongPress(data);
      },
      onTap: () {
        timeStamp.isNotEmpty ? onLongPress(data) : () {};
      },
      child: Container(
        padding: selected ? yourSelectedPadding : yourPadding,
        margin: selected ? yourSelectedMargin : yourMargin,
        decoration: BoxDecoration(
          color: selected
              ? Theme.of(context).scaffoldBackgroundColor
              : Theme.of(context).scaffoldBackgroundColor,
          borderRadius:
              selected ? BorderRadius.circular(0) : BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
                DateFormat("h:mm a").format(DateTime.fromMillisecondsSinceEpoch(
                  data!.time!.toInt(),
                )),
                style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(width: 10),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    selected
                        ? Theme.of(context).scaffoldBackgroundColor
                        : Theme.of(context)
                            .buttonTheme
                            .colorScheme!
                            .inversePrimary,
                    selected
                        ? Theme.of(context).dialogBackgroundColor
                        : Theme.of(context)
                            .buttonTheme
                            .colorScheme!
                            .onInverseSurface,
                  ],
                ),
              ),
              child: data.msgType == 'msg'
                  ? ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: Get.width / 1.4,
                        minWidth: 100,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(11, 13, 8, 11),
                        child: Text(
                          data.msg ?? '',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    )
                  : data.msgType == 'image'
                      ? imageView(data, context)
                      : videoView(data, context),
            ),
          ],
        ),
      ),
    );
  }

  Widget otherUserMsg(ChatMessage? data, context) {
    bool selected = timeStamp.contains('${data?.time?.round()}');
    return GestureDetector(
      onLongPress: () {
        onLongPress(data);
      },
      onTap: () {
        timeStamp.isNotEmpty ? onLongPress(data) : () {};
      },
      child: Container(
        padding: selected ? yourSelectedPadding : yourPadding,
        margin: selected ? yourSelectedMargin : yourMargin,
        decoration: BoxDecoration(
          color: selected
              ? Theme.of(context).scaffoldBackgroundColor
              : Theme.of(context).scaffoldBackgroundColor,
          borderRadius:
              selected ? BorderRadius.circular(0) : BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: selected
                    ? Theme.of(context)
                        .buttonTheme
                        .colorScheme!
                        .error
                        .withOpacity(0.7)
                    : Theme.of(context).buttonTheme.colorScheme!.error,
              ),
              child: data?.msgType == 'msg'
                  ? ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: Get.width / 1.4,
                        minWidth: 100,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 13, 12, 11),
                        child: Text('${data?.msg}',
                            style: Theme.of(context).textTheme.bodyMedium),
                      ),
                    )
                  : data?.msgType == 'image'
                      ? imageView(data, context)
                      : videoView(data, context),
            ),
            const SizedBox(width: 10),
            Text(
                DateFormat("h:mm a").format(
                  DateTime.fromMillisecondsSinceEpoch(
                    data!.time!.toInt(),
                  ),
                ),
                style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }

  Widget imageView(ChatMessage? data, context) {
    bool selected = timeStamp.contains('${data?.time?.round()}');
    return InkWell(
        borderRadius: BorderRadius.circular(5),
        onTap: () {
          onImageTap(data);
        },
        child: imageVideoContainer(
            child: Column(
              children: [
                Stack(
                  children: [
                    imageVideoPost(data: data),
                    imageVideoPostColor(selected: selected, context: context)
                  ],
                ),
                imageVideoPostMessage(data: data, context: context)
              ],
            ),
            context: context,
            selected: selected,
            data: data));
  }

  Widget videoView(ChatMessage? data, context) {
    bool selected = timeStamp.contains('${data?.time?.round()}');
    return InkWell(
        onTap: () {
          onVideoItemClick(data);
        },
        child: imageVideoContainer(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        imageVideoPost(data: data),
                        imageVideoPostColor(
                            selected: selected, context: context)
                      ],
                    ),
                    imageVideoPostMessage(data: data, context: context)
                  ],
                ),
                Container(
                  height: 31,
                  width: 31,
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .color!
                        .withOpacity(0.30),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      CupertinoIcons.arrowtriangle_left_circle,
                      size: 17,
                      color: Theme.of(context).textTheme.bodyMedium!.color,
                    ),
                  ),
                ),
              ],
            ),
            context: context,
            selected: selected,
            data: data));
  }

  Widget alertView(String? time, context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 38, vertical: 8),
        margin: const EdgeInsets.symmetric(vertical: 13),
        decoration: BoxDecoration(
          color: Theme.of(context).dialogBackgroundColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text('$time', style: Theme.of(context).textTheme.bodySmall),
      ),
    );
  }

  Widget imageVideoContainer(
      {required Widget child,
      required bool selected,
      required ChatMessage? data,
      required BuildContext context}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        color: data?.senderUser?.userid == user__ID
            ? null
            : selected
                ? Theme.of(context)
                    .buttonTheme
                    .colorScheme!
                    .error
                    .withOpacity(0.4)
                : Theme.of(context).buttonTheme.colorScheme!.error,
        gradient: data?.senderUser?.userid == user__ID
            ? LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  selected
                      ? Theme.of(context).dialogBackgroundColor
                      : Theme.of(context)
                          .buttonTheme
                          .colorScheme!
                          .onInverseSurface,
                  selected
                      ? Theme.of(context).scaffoldBackgroundColor
                      : Theme.of(context)
                          .buttonTheme
                          .colorScheme!
                          .inversePrimary,
                ],
              )
            : null,
        borderRadius: BorderRadius.circular(5),
      ),
      child: child,
    );
  }

  Widget imageVideoPostColor(
      {required bool selected, required BuildContext context}) {
    return Container(
      height: 171,
      width: 171,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            selected
                ? Theme.of(context).dialogBackgroundColor
                : Theme.of(context).buttonTheme.colorScheme!.onInverseSurface,
            selected
                ? Theme.of(context).scaffoldBackgroundColor
                : Theme.of(context).buttonTheme.colorScheme!.inversePrimary,
          ],
        ),
      ),
    );
  }

  Widget imageVideoPost({ChatMessage? data}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Image.network(
        '${AppLink.aImageBaseUrl}${data?.image}',
        height: 171,
        width: 171,
        fit: BoxFit.cover,
        //cacheKey: '${ConstRes.aImageBaseUrl}${data?.image}',
        repeat: ImageRepeat.noRepeat,
      ),
    );
  }

  Widget imageVideoPostMessage(
      {ChatMessage? data, required BuildContext context}) {
    return data == null || data.msg == null || data.msg!.isEmpty
        ? const SizedBox()
        : Container(
            width: 171,
            margin: const EdgeInsets.only(top: 5),
            child: Text(
              '${data.msg}',
              style: TextStyle(
                color: data.senderUser?.userid == user__ID
                    ? Theme.of(context).primaryColorDark
                    : Theme.of(context).buttonTheme.colorScheme!.error,
              ),
            ),
          );
  }
}
