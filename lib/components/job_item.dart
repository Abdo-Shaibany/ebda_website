import 'package:flutter/material.dart';
import 'package:website/models/jobs_model.dart';
import 'package:easy_localization/easy_localization.dart';

class JobItemComponent extends StatelessWidget {
  final Job jobModel;
  const JobItemComponent({Key key, @required this.jobModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/job_details", arguments: [jobModel.id]);
      },
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: const Color(0xffffffff),
          border: Border.all(width: 1.0, color: const Color(0xff20657d)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: _descText(),
            ),
            _rowText('COMPANY:'.tr(), jobModel.nameCompany),
            _rowText('LOCATION:'.tr(), jobModel.jobCity),
            _rowText('DEADLINE'.tr(),
                DateFormat.yMMMd().format(jobModel.jobDeadlineDate).toString()),
          ],
        ),
      ),
    );
  }

  Widget _rowText(key, value) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0, left: 16.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              key,
              style: TextStyle(
                fontFamily: 'din_next',
                fontSize: 10,
                color: const Color(0xff20657d),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontFamily: 'din_next',
                fontSize: 14,
                color: const Color(0xff707070),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _descText() {
    return Text(
      jobModel.jobTitle,
      style: TextStyle(
        fontFamily: 'din_next',
        fontSize: 16,
        color: const Color(0xff20657d),
        fontWeight: FontWeight.w700,
      ),
      textAlign: TextAlign.center,
      overflow: TextOverflow.clip,
      maxLines: 2,
    );
  }
}
