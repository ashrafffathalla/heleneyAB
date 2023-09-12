// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/controller/user_details_screen_controller/user_details_screen_controller.dart';
import 'package:project/view/widget/user_details_screen_widget/custom_scroll_view_widget.dart';
import 'package:sizer/sizer.dart';

class UserDetailsScreen extends StatelessWidget {
  const UserDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Sizer(
        builder: (context, orientation, devicetype) =>
            GetBuilder<UserDetailsScreenControllerIMP>(
                init: UserDetailsScreenControllerIMP(),
                builder: (controller) => CustomScreollViewWidget()),
      ),
    );
  }
}
