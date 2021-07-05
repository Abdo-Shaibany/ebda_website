import 'package:flutter/material.dart';
import 'package:website/helpers/utils.dart';
import 'package:easy_localization/easy_localization.dart';

class Spalsh extends StatefulWidget {
  Spalsh({Key key}) : super(key: key);

  @override
  _SpalshState createState() => _SpalshState();
}

class _SpalshState extends State<Spalsh> {
  String logo = "assets/icons/logo.png";

  @override
  void initState() {
    super.initState();
    handler();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Utils.backgroundColor,
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            roundLogo(),
            Padding(padding: EdgeInsets.all(8.0)),
            Text(
              'caption'.tr(),
              style: TextStyle(
                fontFamily: 'din_next',
                fontSize: 25,
                color: const Color(0xff20657d),
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }

  Widget roundLogo() {
    return Image.asset(
      logo,
      width: 178,
      height: 214,
    );
  }

  handler() async {
    await Future.delayed(Duration(seconds: 2));
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }
}
