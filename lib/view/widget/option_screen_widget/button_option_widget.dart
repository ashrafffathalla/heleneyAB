// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:project/core/constant/component.dart';

class OptionButtonWidget extends StatelessWidget {
  final String titleButton;
  final VoidCallback onButtonClick;
  const OptionButtonWidget(
      {super.key, required this.titleButton, required this.onButtonClick});

  @override
  Widget build(BuildContext context) {
    return UnicornOutlineButton(
      strokeWidth: 3,
      radius: 30,
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Theme.of(context).primaryColor,
          Theme.of(context).primaryColor.withOpacity(0.5),
        ],
      ),
      onPressed: onButtonClick,
      child: Center(
        child: Text(
          titleButton,
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyMedium!.color,
            fontSize: 17,
          ),
        ),
      ),
    );
  }
}
