// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomInputBar extends StatelessWidget {
  final TextEditingController msgController;
  final VoidCallback onShareBtnTap;
  final VoidCallback onAddBtnTap;
  final VoidCallback onCameraTap;
  final FocusNode msgFocusNode;

  const BottomInputBar({
    Key? key,
    required this.msgController,
    required this.onShareBtnTap,
    required this.onAddBtnTap,
    required this.onCameraTap,
    required this.msgFocusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 3),
      margin: const EdgeInsets.only(bottom: 7),
      width: Get.width,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).dialogBackgroundColor,
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: Get.width - 135,
                    child: TextField(
                      controller: msgController,
                      style: Theme.of(context).textTheme.bodyMedium,
                      focusNode: msgFocusNode,
                      textCapitalization: TextCapitalization.sentences,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.newline,
                      minLines: 1,
                      maxLines: 5,
                      decoration: const InputDecoration(
                        isDense: true,
                        contentPadding:
                            EdgeInsets.only(left: 15, bottom: 3, right: 5),
                        border: InputBorder.none,
                        hintText: 'Enter the message ................',
                        hintStyle: TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: onShareBtnTap,
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      height: 36,
                      width: 36,
                      alignment: const AlignmentDirectional(0.2, 0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Theme.of(context)
                                .buttonTheme
                                .colorScheme!
                                .inversePrimary,
                            Theme.of(context)
                                .buttonTheme
                                .colorScheme!
                                .onInverseSurface,
                          ],
                        ),
                      ),
                      child: Icon(
                        CupertinoIcons.paperplane_fill,
                        size: 17,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8.5),
            InkWell(
              onTap: onAddBtnTap,
              child: Icon(
                CupertinoIcons.add,
                size: 25,
                color:
                    Theme.of(context).buttonTheme.colorScheme!.inversePrimary,
              ),
            ),
            const SizedBox(width: 13.5),
            InkWell(
              onTap: onCameraTap,
              child: Icon(
                CupertinoIcons.camera,
                size: 25,
                color:
                    Theme.of(context).buttonTheme.colorScheme!.inversePrimary,
              ),
            ),
            const SizedBox(width: 12),
          ],
        ),
      ),
    );
  }
}
