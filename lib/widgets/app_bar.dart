import 'package:flutter/material.dart';

class TopAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBar? appBar;
  const TopAppBar({super.key, this.appBar});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Image.asset(
          "assets/images/SaphyLogoSmall.png",
          height: 24,
        ),
      ),
      centerTitle: false,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(appBar?.preferredSize.height ?? kToolbarHeight);
}
