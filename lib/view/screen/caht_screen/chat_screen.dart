// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/controller/chat_screen_controller/chat_screen_controller.dart';
import 'package:project/view/widget/chat_screen_widget/bottom_input_bar.dart';
import 'package:project/view/widget/chat_screen_widget/bottom_selected_item_bar.dart';
import 'package:project/view/widget/chat_screen_widget/chat_area.dart';
import 'package:project/view/widget/chat_screen_widget/top_bar_area.dart';
import 'package:sizer/sizer.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      body: GetBuilder<ChatScreenControlleIMP>(
        init: ChatScreenControlleIMP(),
        builder: (controller) => Sizer(
          builder: (context, orientation, deviceType) => Column(
            children: [
              Container(
                alignment: Alignment.bottomLeft,
                height: 8.h,
                child: IconButton(
                  onPressed: controller.goBack,
                  icon: Icon(
                    Icons.arrow_back_ios_new_outlined,
                    size: 10.sp,
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
                      TopBarArea(
                        conversation: controller.conversation,
                        onBack: controller.goBack,
                        onMoreBtnTap: controller.onMoreBtnTap,
                        blockUnblock: controller.blockUnblock,
                        onUserTap: controller.onUserTap,
                        msgFocusNode: controller.messageFoucs,
                      ),
                      ChatArea(
                        chatData: controller.grouped,
                        onImageTap: controller.onImageTap,
                        scrollController: controller.scrollController,
                        onVideoItemClick: controller.onVideoItemClick,
                        onLongPress: controller.onLongPress,
                        timeStamp: controller.timeStamp,
                      ),
                      if (controller.timeStamp.isNotEmpty)
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 500),
                          transitionBuilder:
                              (Widget child, Animation<double> animation) {
                            return SlideTransition(
                                position: Tween<Offset>(
                                  begin: const Offset(0, 1),
                                  end: const Offset(0, 0.0),
                                ).animate(
                                  CurvedAnimation(
                                    parent: animation,
                                    curve: Curves.fastOutSlowIn,
                                  ),
                                ),
                                child: child);
                          },
                          child: BottomSelectedItemBar(
                              onCancelBtnClick: controller.onCancelBtnClick,
                              selectedItemCount: controller.timeStamp.length,
                              onItemDelete: controller.chatDeleteDialog),
                        )
                      else
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 500),
                          transitionBuilder:
                              (Widget child, Animation<double> animation) {
                            return SlideTransition(
                                position: Tween<Offset>(
                                  begin: const Offset(0, 1),
                                  end: const Offset(0, 0.0),
                                ).animate(
                                  CurvedAnimation(
                                    parent: animation,
                                    curve: Curves.fastOutSlowIn,
                                  ),
                                ),
                                child: child);
                          },
                          child: controller.isBlock == true
                              ? Center(
                                  child: InkWell(
                                    onTap: controller.unblockDialog,
                                    // splashColor: ColorRes.transparent,
                                    //highlightColor: ColorRes.transparent,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 38, vertical: 8),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .buttonTheme
                                            .colorScheme!
                                            .error,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 13),
                                      child: Text("You block this user",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium),
                                    ),
                                  ),
                                )
                              : BottomInputBar(
                                  msgController:
                                      controller.messageTextEditingController,
                                  onShareBtnTap: controller.onMessageSent,
                                  msgFocusNode: controller.messageFoucs,
                                  onAddBtnTap: controller.onPlusTap,
                                  onCameraTap: controller.onCameraTap,
                                ),
                        )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
