import 'package:flutter/material.dart';
import 'package:website/models/my_artical_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy_localization/easy_localization.dart';

class MyArticalComponent extends StatelessWidget {
  final MyArticalModel model;
  const MyArticalComponent({Key key, @required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        children: [
          Container(
            // height: 70.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: const Color(0xffffffff),
              border: Border.all(width: 1.0, color: const Color(0xff20657d)),
            ),
            child: Column(
              children: [
                Padding(padding: EdgeInsets.all(4.0)),
                Row(
                  children: [
                    Padding(padding: EdgeInsets.all(4.0)),
                    _textOne(model.postNo),
                    Padding(padding: EdgeInsets.all(4.0)),
                    Expanded(child: _textOne(model.title)),
                  ],
                ),
                Padding(padding: EdgeInsets.all(8.0)),
                Row(
                  children: [
                    Padding(padding: EdgeInsets.all(4.0)),
                    SvgPicture.asset("assets/icons/eye.svg",
                        width: 12, height: 12),
                    Padding(padding: EdgeInsets.all(2.0)),
                    daText(model.views),
                    Padding(padding: EdgeInsets.all(4.0)),
                    SvgPicture.asset(
                      "assets/icons/clock.svg",
                      width: 13,
                      height: 13,
                    ),
                    Padding(padding: EdgeInsets.all(2.0)),
                    daText(model.date),
                    Expanded(child: Container()),
                    daText('status'.tr() + ':'),
                    Padding(padding: EdgeInsets.all(4.0)),
                    daText(model.state),
                    Padding(padding: EdgeInsets.all(4.0)),
                  ],
                ),
                Padding(padding: EdgeInsets.all(4.0)),
              ],
            ),
          ),
          Padding(padding: EdgeInsets.all(4.0)),
          Row(
            children: [
              Expanded(
                child: Container(),
              ),
              GestureDetector(
                onTap: () => _handleView(context),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: SvgPicture.asset(
                    "assets/icons/eye_two.svg",
                    width: 30,
                    height: 30,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => _handleEdit(context),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: SvgPicture.asset(
                    "assets/icons/edit.svg",
                    width: 30,
                    height: 30,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: SvgPicture.asset(
                  "assets/icons/trash.svg",
                  width: 30,
                  height: 30,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget daText(value) {
    return Text(
      value,
      style: TextStyle(
        fontFamily: 'din_next',
        fontSize: 14,
        color: const Color(0xff707070),
        fontWeight: FontWeight.w700,
      ),
      textAlign: TextAlign.left,
    );
  }

  Widget _textOne(value) {
    return Text(
      value,
      style: TextStyle(
        fontFamily: 'din_next',
        fontSize: 14,
        color: const Color(0xff20657d),
        fontWeight: FontWeight.w700,
      ),
      maxLines: 2,
      overflow: TextOverflow.fade,
    );
  }

  _handleDelete() {
    // TODO:
  }

  _handleEdit(context) {
    Navigator.pushNamed(context, '/create_post');
  }

  _handleView(context) {
    Navigator.pushNamed(context, "/post", arguments: [model.postId]);
  }
}
