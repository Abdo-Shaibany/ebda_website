import 'package:flutter/material.dart';
import 'package:website/screens/edit_post.dart';
import 'package:website/screens/select_categories.dart';
import 'package:easy_localization/easy_localization.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({Key key}) : super(key: key);

  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          _topper(context),
          _pageview(context),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _bottom(),
          ),
        ],
      )),
    );
  }

  Widget _topper(context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0xff20657d),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () => {
              Navigator.pop(context),
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'back'.tr(),
                style: TextStyle(
                  fontFamily: 'din_next',
                  fontSize: 13,
                  color: const Color(0xffffffff),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _pageview(context) {
    return _currentIndex == 0
        ? Expanded(child: SelectCategories())
        : Expanded(child: EditPost());
  }

  Widget _bottom() {
    if (_currentIndex == 0)
      return _daBtn(
          'next'.tr(),
          () => {
                setState(() {
                  _currentIndex = _currentIndex + 1;
                })
              });

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _daBtn(
            'previces'.tr(),
            () => {
                  setState(() {
                    _currentIndex = _currentIndex - 1;
                  })
                }),
        _daBtn(
            'save'.tr(),
            () => {
                  // TODO: handle submit
                }),
      ],
    );
  }

  Widget _daBtn(value, handler) {
    return GestureDetector(
      onTap: handler,
      child: Container(
        width: 100.0,
        height: 35.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2.0),
          color: const Color(0xff20657d),
        ),
        child: Center(
          child: Text(
            value,
            style: TextStyle(
              fontFamily: 'din_next',
              fontSize: 16,
              color: const Color(0xffffffff),
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.left,
          ),
        ),
      ),
    );
  }
}
