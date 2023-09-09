// ignore_for_file: prefer_const_constructors

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/core/constant/app_photo.dart';
import 'package:project/core/constant/link_api.dart';

import 'report_reason_drop_down_box.dart';

class ReportBottomSheet extends StatelessWidget {
  final VoidCallback onBackBtnTap;
  final bool showDropdown;
  final bool? checkBoxValue;
  final VoidCallback onReasonTap;
  final TextEditingController explainMore;
  final String reason;
  final String? profileImage;
  final String fullName;
  final String address;
  final List<String> reasonList;
  final Function(String reason) onReasonChange;
  final Function(bool? isCheck) onCheckBoxChange;
  final VoidCallback onSubmitBtnTap;
  final String explainMoreError;
  final FocusNode explainMoreFocus;

  const ReportBottomSheet(
      {Key? key,
      required this.onBackBtnTap,
      required this.showDropdown,
      required this.onReasonTap,
      required this.reason,
      required this.checkBoxValue,
      required this.explainMore,
      required this.reasonList,
      required this.onCheckBoxChange,
      required this.onReasonChange,
      required this.onSubmitBtnTap,
      required this.fullName,
      required this.profileImage,
      required this.address,
      required this.explainMoreError,
      required this.explainMoreFocus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 15),
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaY: 40, sigmaX: 40),
          child: Container(
            width: Get.width,
            height: Get.height - 100,
            padding: EdgeInsets.fromLTRB(21, 20, 21, 0),
            decoration: BoxDecoration(
              color:
                  Theme.of(context).scaffoldBackgroundColor.withOpacity(0.33),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(30),
              ),
            ),
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Your Are Reporting this user',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 70,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      children: [
                        profileImage == null || profileImage!.isEmpty
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  child: Image.asset(
                                    AppPhotoLink.logoHelnay,
                                    height: 50,
                                    width: 50,
                                  ),
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Image.network(
                                  '${AppLink.aImageBaseUrl}$profileImage',
                                  errorBuilder: (context, url, error) {
                                    return Image.asset(
                                      AppPhotoLink.logoHelnay,
                                      width: 50,
                                      height: 50,
                                    );
                                  },
                                  fit: BoxFit.cover,
                                  height: 50,
                                  width: 50,
                                ),
                              ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              fullName,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              address,
                              style: Theme.of(context).textTheme.bodyMedium,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Select Reason',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Stack(
                    children: [
                      Column(
                        children: [
                          InkWell(
                            onTap: onReasonTap,
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            child: Container(
                              height: 40,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.15),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      reason,
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .buttonTheme
                                            .colorScheme!
                                            .error,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Transform.rotate(
                                      angle: showDropdown ? 3.1 : 0,
                                      child: Icon(
                                        CupertinoIcons.chevron_down,
                                        size: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: showDropdown ? 110 : 0,
                          )
                        ],
                      ),
                      showDropdown
                          ? Positioned(
                              top: 45,
                              left: 0,
                              child: ReportReasonDropDownBox(
                                reason: reason,
                                onChange: onReasonChange,
                                reasonList: reasonList,
                                backGroundColor: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.15),
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Explain More',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Container(
                    height: 70,
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(10),
                        border: explainMoreError != ""
                            ? Border.all(
                                color: Theme.of(context).colorScheme.secondary)
                            : Border.all(
                                color:
                                    Theme.of(context).colorScheme.onSurface)),
                    child: TextField(
                      controller: explainMore,
                      focusNode: explainMoreFocus,
                      // onTap: onTextFieldTap,
                      maxLines: null,
                      minLines: null,
                      expands: true,
                      cursorColor: Theme.of(context).colorScheme.onBackground,
                      cursorHeight: 15,
                      textInputAction: TextInputAction.next,
                      // onChanged: controller.onBioChange,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                      decoration: InputDecoration(
                        hintText: explainMoreError == ''
                            ? 'Enter Full Reason'
                            : explainMoreError,
                        hintStyle: TextStyle(
                          color: explainMoreError == ""
                              ? Theme.of(context).colorScheme.onBackground
                              : Theme.of(context).colorScheme.secondary,
                        ),
                        border: InputBorder.none,
                        contentPadding:
                            const EdgeInsets.only(bottom: 10, left: 10, top: 9),
                        counterText: "",
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: checkBoxValue,
                        onChanged: onCheckBoxChange,
                        activeColor: Theme.of(context).colorScheme.secondary,
                        side: MaterialStateBorderSide.resolveWith(
                          (states) => BorderSide(
                              width: 1.5,
                              color: Theme.of(context).colorScheme.secondary),
                        ),
                      ),
                      Expanded(
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text: 'I agree to',
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                              TextSpan(
                                  text: ' Terms & Conditions,',
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                              TextSpan(
                                  text: ' continue please',
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  InkWell(
                    onTap: onSubmitBtnTap,
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            offset: Offset(0.0, 1.0), //(x,y)
                            blurRadius: 1.0,
                          ),
                        ],
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
                      child: Center(
                        child: Text('Submit',
                            style: Theme.of(context).textTheme.bodyLarge),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
