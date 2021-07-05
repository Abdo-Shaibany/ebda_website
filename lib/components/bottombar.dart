import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class Bottombar extends StatelessWidget {
  final Function(int) handleClicked;
  final int currentIndex;
  const Bottombar({
    Key key,
    @required this.handleClicked,
    @required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.07,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
        color: const Color(0xff20657d),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          tab('blog'.tr(), 0),
          tab('journal'.tr(), 1),
          tab('prices'.tr(), 2),
          tab('jobs'.tr(), 3),
        ],
      ),
    );
  }

  Widget tab(value, index) {
    return GestureDetector(
      onTap: () => handleClicked(index),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 8.0,
          bottom: 8.0,
        ),
        child: Text(
          value,
          style: TextStyle(
            fontFamily: 'din_next',
            fontSize: 16,
            color: index == currentIndex
                ? const Color(0xffe0ae4b)
                : const Color(0xffd8d7d7),
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.right,
        ),
      ),
    );
  }
}
