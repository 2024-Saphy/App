import 'package:flutter/material.dart';
import 'package:saphy/utils/colors.dart';
import 'package:saphy/utils/textstyles.dart';

class TopAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBar? appBar;
  final String? label;
  const TopAppBar({super.key, this.appBar, this.label});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 70,
      automaticallyImplyLeading: false,
      backgroundColor: altWhite,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 25,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          Text(
            label ?? "",
            style: titleText(),
          ),
          IconButton(
            icon: const Icon(
              Icons.search,
              size: 25,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(appBar?.preferredSize.height ?? kToolbarHeight);
}
