import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:website/helpers/utils.dart';
import 'package:website/models/posts_model.dart';

class ArticalItemComponent extends StatelessWidget {
  final Post input;
  const ArticalItemComponent({
    Key key,
    @required this.input,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16, left: 16),
      child: GestureDetector(
        onTap: () => {
          Navigator.pushNamed(context, '/post', arguments: [input.id])
        },
        child: Container(
          height: 85,
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              _thumbnail(),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: _content(context),
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _content(context) {
    return Column(
      children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: _title(),
          ),
        )),
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            children: [
              Padding(padding: EdgeInsets.all(4.0)),
              SvgPicture.asset(
                "assets/icons/eye.svg",
                width: 12,
                height: 12,
              ),
              Padding(padding: EdgeInsets.all(4.0)),
              _text(input.viewCountAr.toString()),
              Padding(padding: EdgeInsets.all(4.0)),
              Padding(padding: EdgeInsets.only(right: 4.0, left: 4.0)),
              SvgPicture.asset(
                "assets/icons/clock.svg",
                width: 14,
                height: 14,
              ),
              Padding(padding: EdgeInsets.all(4.0)),
              _text(input.postDateAr.toIso8601String()),
            ],
          ),
        )
      ],
    );
  }

  Widget _title() {
    return Text(
      input.postTitleAr,
      style: TextStyle(
        fontFamily: 'din_next',
        fontSize: 12,
        color: const Color(0xff20657d),
        fontWeight: FontWeight.w700,
      ),
      textAlign: TextAlign.left,
      maxLines: 2,
    );
  }

  Widget _text(value) {
    return Text(
      value,
      style: TextStyle(
        fontFamily: 'din_next',
        fontSize: 10,
        color: const Color(0xff707070),
        fontWeight: FontWeight.w700,
      ),
      textAlign: TextAlign.left,
    );
  }

  Widget _thumbnail() {
    return Container(
      width: 96.0,
      height: 64.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Utils.fromHex("#20657D"),
        // border: Border.all(width: 2.0, color: Utils.fromHex('#20657D')),
      ),
      child: Center(
        child: Container(
          width: 94.0,
          height: 62.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: CachedNetworkImage(
              imageUrl:
                  "http://ri-bu.com/upload/posts_image/${input.featuredImageAr}",
              placeholder: (context, url) => Container(
                alignment: Alignment.center,
                child: Container(
                  color: Colors.white,
                  // child: Image.asset("assets/icons/logo.png"),
                ),
                width: 20,
                height: 20,
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  _handleClick() {}
}
