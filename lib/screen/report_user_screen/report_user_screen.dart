import 'package:flutter/material.dart';
import 'package:project/screen/report_user_screen/report_user_screen_view_model.dart';
import 'package:project/screen/report_user_screen/widget/report_bottomsheet.dart';
import '../../../utils/app_res.dart';
import '../../../utils/asset_res.dart';
import '../../../utils/color_res.dart';
import '../../../utils/const_res.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked.dart';

import '../../model/user/registration_user.dart';

class ReportUserScreen extends StatelessWidget {
  const ReportUserScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ReportUserScreenViewModel>.reactive(
      onModelReady: (model) {
        model.init();
      },
      viewModelBuilder: () => ReportUserScreenViewModel(),
      builder: (context, model, child) {
        List<Images>? image = model.registrationUserData?.images;
        return ReportBottomSheet(
          onBackBtnTap: model.onBackBtnTap,
          showDropdown: model.showDropdown,
          onReasonChange: model.onReasonChange,
          reason: model.reason,
          reasonList: model.reasonList,
          checkBoxValue: model.isCheckBox,
          onCheckBoxChange: model.onCheckBoxChange,
          explainMore: model.explainMoreController,
          onReasonTap: model.onReasonTap,
          onSubmitBtnTap: model.onSubmitBtnTap,
          address: model.registrationUserData?.live ?? '',
          fullName: model.registrationUserData?.fullname ?? '',
          profileImage: image != null && image.isNotEmpty ? image[0].image : '',
          explainMoreError: model.explainMoreError,
          explainMoreFocus: model.explainFocusNode,
        );
      },
    );
  }
}
