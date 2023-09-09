// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomSelectionList extends StatelessWidget {
  final List<File>? imageList;
  final int selectedIndex;
  final Function(int index) onImgRemove;
  final VoidCallback onPlayBtnTap;
  final VoidCallback onAddBtnTap;

  const BottomSelectionList({
    Key? key,
    required this.imageList,
    required this.onImgRemove,
    required this.onPlayBtnTap,
    required this.onAddBtnTap,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: Text('photos'.toUpperCase(),
              style: Theme.of(context).textTheme.bodyLarge),
        ),
        const SizedBox(height: 7),
        Container(
          margin: EdgeInsets.only(bottom: Get.height / 30),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              SizedBox(
                width: Get.width - 170,
                height: 58,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: imageList?.length,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        onImgRemove(index);
                      },
                      child: Container(
                        height: 58,
                        width: 58,
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(File(imageList![index].path)),
                          ),
                        ),
                        child: Center(
                          child: Container(
                            height: 31,
                            width: 31,
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .primaryColorLight
                                  .withOpacity(0.30),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Icon(
                                CupertinoIcons.delete,
                                size: 16,
                                color: Theme.of(context)
                                    .bottomNavigationBarTheme
                                    .unselectedItemColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                width: 130,
                height: 58,
                child: Row(
                  children: [
                    SizedBox(width: 7),
                    InkWell(
                      onTap: onAddBtnTap,
                      child: Container(
                        height: 58,
                        width: 58,
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).buttonTheme.colorScheme!.error,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Icon(CupertinoIcons.plus,
                              size: 17,
                              color: Theme.of(context)
                                  .bottomNavigationBarTheme
                                  .unselectedItemColor),
                        ),
                      ),
                    ),
                    SizedBox(width: 7),
                    InkWell(
                      onTap: onPlayBtnTap,
                      child: Container(
                        height: 58,
                        width: 58,
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).buttonTheme.colorScheme!.error,
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Theme.of(context).primaryColor,
                              Theme.of(context).primaryColor.withOpacity(0.4),
                            ],
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            CupertinoIcons.arrowshape_turn_up_right_fill,
                            color: Theme.of(context).primaryColor,
                            size: 17,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
