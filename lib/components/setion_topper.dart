import 'package:flutter/material.dart';

class SetionTopper extends StatelessWidget {
  final String title;
  const SetionTopper({
    Key key,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(5.0),
          bottomLeft: Radius.circular(5.0),
        ),
        color: const Color(0xff20657d),
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 4.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(child: Container()),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: _titleText(),
              ),
              Expanded(
                  child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(child: Container()),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _titleText() {
    return Text(
      title,
      style: TextStyle(
        fontFamily: 'din_next',
        fontSize: 25,
        color: const Color(0xffffffff),
        fontWeight: FontWeight.w700,
      ),
      textAlign: TextAlign.left,
    );
  }
}
