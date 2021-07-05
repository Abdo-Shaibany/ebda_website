import 'package:website/components/browser_item.dart';
import 'package:website/components/job_item.dart';
import 'package:website/components/journal_item.dart';
import 'package:website/components/my_artical_item.dart';
import 'package:website/helpers/pages_ids.dart';
import 'package:website/models/homeless.dart';
import 'package:website/models/screen_model.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/material.dart';

class ScreensBuilder {
  static ScreenModel journalsScreen() {
    return ScreenModel(
      pageId: PageId.Journals,
      topper: Container(),
      itemUI: (model) => JournalItemComponent(
        model: model,
      ),
      title: 'journal'.tr(),
    );
  }

  static ScreenModel jobs(context) {
    return ScreenModel(
      pageId: PageId.Jobs,
      topper: _jobsTopper(context),
      itemUI: (model) => JobItemComponent(
        jobModel: model,
      ),
      title: 'jobs'.tr(),
    );
  }

  static Widget _jobsTopper(context) {
    return GestureDetector(
      onTap: () => _launchURL('https://ri-bu.com/jobs_account/index'),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          width: 228.0,
          height: 45.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: const Color(0xff20657d),
          ),
          child: Center(
            child: Text(
              'ADD NEW JOB'.tr(),
              style: TextStyle(
                fontFamily: 'din_next',
                fontSize: 13,
                color: const Color(0xffffffff),
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ),
      ),
    );
  }

  static Widget categories() {
    return Homeles(
      child: ScreenModel(
        pageId: PageId.Categories,
        topper: Container(),
        itemUI: (model) => BrowserComponent(model: model),
        title: "explorer categories".tr(),
      ),
    );
  }

  static Widget myArticals(context) {
    return Homeles(
      child: ScreenModel(
        pageId: PageId.MyArticals,
        topper: _myArticalsTopper(context),
        itemUI: (model) => MyArticalComponent(model: model),
        title: "my articals".tr(),
      ),
    );
  }

  static Widget _myArticalsTopper(context) {
    return GestureDetector(
      onTap: () => {
        Navigator.pushNamed(context, '/create_post'),
      },
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          width: 228.0,
          height: 45.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: const Color(0xff20657d),
          ),
          child: Center(
            child: Text(
              "ADD NEW POST".tr(),
              style: TextStyle(
                fontFamily: 'din_next',
                fontSize: 13,
                color: const Color(0xffffffff),
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ),
      ),
    );
  }

  static void _launchURL(url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
}
