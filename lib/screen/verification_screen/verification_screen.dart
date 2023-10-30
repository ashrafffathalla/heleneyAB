import 'package:flutter/material.dart';
import 'package:project/screen/verification_screen/verification_screen_view_model.dart';
import 'package:project/screen/verification_screen/widget/verification_center_area.dart';
import 'package:project/screen/verification_screen/widget/verification_top_bar.dart';
import 'package:stacked/stacked.dart';
import '../../../utils/app_res.dart';
import '../../../utils/asset_res.dart';
import '../../../utils/color_res.dart';
import '../../../utils/const_res.dart';
class VerificationScreen extends StatelessWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<VerificationScreenViewModel>.reactive(
      onModelReady: (model) {
        model.init();
      },
      viewModelBuilder: () => VerificationScreenViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: ColorRes.white,
          body: SafeArea(
            top: false,
            child: Column(
              children: [
                VerificationTopBar(
                  onBackBtnTap: model.onBackBtnTap,
                ),
                Container(
                  height: 1,
                  margin: const EdgeInsets.symmetric(horizontal: 7),
                  width: MediaQuery.of(context).size.width,
                  color: ColorRes.grey5,
                ),
                VerificationCenterArea(
                  fullNameError: model.fullNameError,
                  fullNameController: model.fullNameController,
                  fullNameFocus: model.fullNameFocus,
                  showDropdown: model.showDropdown,
                  docType: model.docType,
                  onDocChange: model.onDocChange,
                  onDocTypeTap: model.onDocTypeTap,
                  onTakePhotoTap: model.onTakePhotoTap,
                  onDocumentTap: model.onDocumentTap,
                  onSubmitBtnClick: model.onSubmitBtnClick,
                  selfieImage: model.selfieImage,
                  imagesName: model.documentName,
                  isDocFile: model.isDocumentType,
                  isSelfie: model.isSelfie,
                  userIdentity: model.userData,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
