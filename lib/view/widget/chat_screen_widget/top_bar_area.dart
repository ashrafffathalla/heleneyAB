// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/core/constant/app_photo.dart';
import 'package:project/core/constant/link_api.dart';
import 'package:project/data/models/chat_and_live_model/chat.dart';

class TopBarArea extends StatelessWidget {
  final Conversation? conversation;
  final VoidCallback onBack;
  final Function(String value) onMoreBtnTap;
  final String blockUnblock;
  final VoidCallback onUserTap;
  final FocusNode msgFocusNode;

  const TopBarArea({
    Key? key,
    required this.conversation,
    required this.onBack,
    required this.onMoreBtnTap,
    required this.msgFocusNode,
    required this.blockUnblock,
    required this.onUserTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(21, 18, 23, 18),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: conversation?.user?.image == null ||
                          conversation!.user!.image!.isEmpty
                      ? Image.asset(
                          AppPhotoLink.logoHelnay,
                          height: 37,
                          width: 37,
                        )
                      : Image.network(
                          '${AppLink.aImageBaseUrl}${conversation?.user?.image}',
                          height: 37,
                          width: 37,
                          fit: BoxFit.cover,
                          errorBuilder: (context, url, error) {
                            return Image.asset(
                              AppPhotoLink.logoHelnay,
                              height: 37,
                              width: 37,
                            );
                          },
                        ),
                ),
                const SizedBox(width: 10),
                InkWell(
                  onTap: onUserTap,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                              conversation?.user?.username != null
                                  ? '${conversation?.user?.username} '
                                  : ' ',
                              style: Theme.of(context).textTheme.bodyMedium),
                          Text(
                              conversation?.user?.age != null
                                  ? "${conversation?.user?.age}"
                                  : '',
                              style: Theme.of(context).textTheme.bodyMedium),
                          const SizedBox(width: 5),
                          Visibility(
                            visible: conversation != null &&
                                conversation?.user != null &&
                                conversation?.user?.isHost != null &&
                                conversation!.user!.isHost!,
                            child:
                                Icon(CupertinoIcons.placemark_fill, size: 15),
                          ),
                        ],
                      ),
                      Text(
                          conversation?.user?.city != null
                              ? "${conversation?.user?.city}"
                              : '',
                          style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                ),
                const Spacer(),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    onMoreBtnTap(value);
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 3,
                  itemBuilder: (BuildContext context) {
                    msgFocusNode.unfocus();
                    return {blockUnblock, 'Report'}.map(
                      (String choice) {
                        return PopupMenuItem<String>(
                          value: choice,
                          child: Text(choice),
                        );
                      },
                    ).toList();
                  },
                  child: Icon(
                    CupertinoIcons.gear_alt,
                    size: 26,
                    color: Theme.of(context)
                        .buttonTheme
                        .colorScheme!
                        .inversePrimary,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 0.5,
            width: Get.width,
            margin: EdgeInsets.only(right: 10, left: 10, bottom: 5.5),
            color: Theme.of(context).buttonTheme.colorScheme!.error,
          ),
        ],
      ),
    );
  }
}
