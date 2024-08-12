import 'package:flutter/material.dart';

class SettingMenu extends StatefulWidget {
  const SettingMenu({super.key,required this.title,required this.icon,this.onTap});

  final String title;
  final IconData icon;
  final Function? onTap;

  @override
  State<SettingMenu> createState() => _SettingMenuState();
}

class _SettingMenuState extends State<SettingMenu> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onTap!();
      },
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      child: Container(
        padding: const EdgeInsets.only(bottom: 12,top: 12),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey,
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 15,
                fontFamily: "Pretendard",
                fontWeight: FontWeight.w500,
              ),
            ),
            Icon(widget.icon,size: 25,),
          ],
        ),
      ),
    );
  }
}