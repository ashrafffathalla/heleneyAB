import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UnblockUserDialog extends StatelessWidget {
  final VoidCallback unblockUser;
  final VoidCallback onCancelBtnClick;
  final String? name;

  const UnblockUserDialog(
      {Key? key,
      required this.onCancelBtnClick,
      required this.unblockUser,
      this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: AspectRatio(
        aspectRatio: 2.7,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              const Spacer(),
              Text('Unblock $name to send a message.',
                  style: Theme.of(context).textTheme.bodyMedium),
              const Spacer(),
              Row(
                children: [
                  const Spacer(),
                  InkWell(
                    onTap: onCancelBtnClick,
                    //splashColor: ColorRes.transparent,
                    //highlightColor: ColorRes.transparent,
                    child: Text('CANCEL',
                        style: Theme.of(context).textTheme.bodyLarge),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      unblockUser();
                      Get.back();
                    },
                    child: Text('UNBLOCK',
                        style: Theme.of(context).textTheme.bodyLarge),
                  ),
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
