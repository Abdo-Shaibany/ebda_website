import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy_localization/easy_localization.dart';

class Topper extends StatelessWidget {
  final Function() handleOpenDrawer;
  const Topper({
    Key key,
    @required this.handleOpenDrawer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 45,
      color: const Color(0xff20657d),
      child: Row(
        children: [
          start(),
          Expanded(child: Container()),
          end(context),
        ],
      ),
    );
  }

  Widget start() {
    return GestureDetector(
      onTap: handleOpenDrawer,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SvgPicture.asset(
          "assets/icons/three_lines.svg",
          width: 20,
          height: 20,
        ),
      ),
    );
  }

  Widget end(context) {
    String locale = EasyLocalization.of(context).currentLocale == Locale('ar')
        ? 'en'
        : 'ar';
    return Row(
      children: [
        GestureDetector(
          onTap: () => {
            if (EasyLocalization.of(context).currentLocale == Locale('ar'))
              EasyLocalization.of(context).setLocale(Locale('en'))
            else
              EasyLocalization.of(context).setLocale(Locale('ar'))
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset("assets/icons/$locale.svg"),
          ),
        ),
        Container(
          width: 2,
          height: 20,
          color: const Color(0xffffffff),
        ),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, "/sign_in"),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: text('log in'.tr()),
          ),
        ),
        Container(
          width: 2,
          height: 20,
          color: const Color(0xffffffff),
        ),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, "/search"),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: text('search'.tr()),
          ),
        ),
      ],
    );
  }

  Widget text(value) {
    return Text(
      value,
      style: TextStyle(
        fontFamily: 'din_next',
        fontSize: 15,
        color: const Color(0xffffffff),
        fontWeight: FontWeight.w700,
      ),
      textAlign: TextAlign.left,
    );
  }
}
