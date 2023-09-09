// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerScreen extends StatelessWidget {
  final double width;
  final double height;
  final ShapeBorder shapeBorder;

  const ShimmerScreen.rectangular(
      {this.width = double.infinity,
      required this.height,
      required this.shapeBorder});

  const ShimmerScreen.circular(
      {this.width = double.infinity,
      required this.height,
      this.shapeBorder = const CircleBorder()});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      gradient: LinearGradient(
        colors: [
          Theme.of(context).colorScheme.primary,
          Theme.of(context).colorScheme.background,
          Theme.of(context).colorScheme.primary,
        ],
        stops: [
          0.1,
          0.2,
          0.3,
        ],
        begin: Alignment(-1.0, -0.3),
        end: Alignment(1.0, 0.3),
        tileMode: TileMode.mirror,
      ),
      direction: ShimmerDirection.ltr,
      child: Container(
        width: width,
        height: height,
        decoration: ShapeDecoration(
          color: Theme.of(context).colorScheme.primary,
          shape: shapeBorder,
        ),
      ),
    );
  }
}
