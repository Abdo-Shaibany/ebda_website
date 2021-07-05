import 'package:flutter/material.dart';
import 'package:website/components/menu_widget.dart';
import 'package:website/components/setion_topper.dart';

import 'package:easy_localization/easy_localization.dart';

class JobDetails extends StatefulWidget {
  final String id;
  const JobDetails({Key key, @required this.id}) : super(key: key);

  @override
  _JobDetailsState createState() => _JobDetailsState();
}

class _JobDetailsState extends State<JobDetails> {
  // TODO: make parameters for it

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldkey =
        new GlobalKey<ScaffoldState>();

    return Scaffold(
      drawer: Drawer(child: MenuWidget()),
      key: _scaffoldkey,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: _topper(context),
            ),
            _container(context, '',
                'dfghjkmsdfsd sdfsdfsd ffsdfsdf sdfsdfsdf sdfsdfsdf sdfsdfsdf '),
          ],
        ),
      ),
    );
  }

  Widget _container(context, title, value) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Align(
            alignment:
                EasyLocalization.of(context).currentLocale == Locale('ar')
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'عن الشركة - ميجا سوفت',
                style: TextStyle(
                  fontFamily: 'din_next',
                  fontSize: 18,
                  color: const Color(0xff20657d),
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.95,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: const Color(0xffffffff),
              border: Border.all(width: 2.0, color: const Color(0xff20657d)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                value,
                style: TextStyle(
                  fontFamily: 'din_next',
                  fontSize: 16,
                  color: const Color(0xff20657d),
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _topper(context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(5.0),
          bottomLeft: Radius.circular(5.0),
        ),
        color: const Color(0xff20657d),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () => _handleBackClicked(context),
              child: Text(
                'back'.tr(),
                style: TextStyle(
                  fontFamily: 'din_next',
                  fontSize: 15,
                  color: const Color(0xffffffff),
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ),
          SetionTopper(title: 'Job details'),
        ],
      ),
    );
  }

  _handleBackClicked(context) {
    Navigator.pop(context);
  }
}
