import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomSelectedItemBar extends StatelessWidget {
  final VoidCallback onCancelBtnClick;
  final int selectedItemCount;
  final VoidCallback onItemDelete;

  const BottomSelectedItemBar(
      {Key? key,
      required this.onCancelBtnClick,
      required this.selectedItemCount,
      required this.onItemDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(
          thickness: 0.5,
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 4),
          margin: const EdgeInsets.only(bottom: 7, right: 10, left: 10),
          width: Get.width,
          decoration:
              BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor),
          child: SafeArea(
            top: false,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: onCancelBtnClick,
                  child: Text('Cancel',
                      style: Theme.of(context).textTheme.bodyMedium),
                ),
                const Spacer(),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return ScaleTransition(scale: animation, child: child);
                  },
                  child: Text('$selectedItemCount ',
                      key: ValueKey<int>(selectedItemCount),
                      style: Theme.of(context).textTheme.displayMedium),
                ),
                Text('Selected', style: Theme.of(context).textTheme.bodyMedium),
                const Spacer(),
                InkWell(
                  onTap: onItemDelete,
                  child: Icon(
                    CupertinoIcons.delete_simple,
                    color: Theme.of(context)
                        .bottomNavigationBarTheme
                        .selectedItemColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
