// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class WebViewTermsAndPrivcey extends StatelessWidget {
  final String title;
  final VoidCallback ontap;
  const WebViewTermsAndPrivcey(
      {super.key, required this.title, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.7),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.sp),
                topRight: Radius.circular(20.sp))),
        padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 10.sp),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: Theme.of(context).textTheme.bodyMedium),
            Icon(CupertinoIcons.chevron_forward,
                size: 10.sp, color: Theme.of(context).primaryColor),
          ],
        ),
      ),
    );
  }
}
