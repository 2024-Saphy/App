import 'package:flutter/material.dart';
import 'package:saphy/utils/colors.dart';
import 'package:saphy/utils/textstyles.dart';

class TopAppBar extends StatelessWidget implements PreferredSizeWidget {
  final void Function()? backAction;
  final AppBar? appBar;
  final String? label;
  final bool? searchable;
  const TopAppBar({
    super.key,
    this.backAction,
    this.appBar,
    this.label,
    this.searchable,
  });

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
            onPressed: backAction ??
                () {
                  Navigator.pop(context);
                },
          ),
          Text(
            label ?? "",
            style: titleText(),
          ),
          Row(
            children: [
              searchable == true
                  ? IconButton(
                      icon: const Icon(
                        Icons.search,
                        size: 25,
                      ),
                      onPressed: () {},
                    )
                  : const SizedBox()
            ],
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(appBar?.preferredSize.height ?? kToolbarHeight);
}
