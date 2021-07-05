import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as mat;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:website/bloc/bloc_bloc.dart';
import 'package:website/helpers/data.dart';
import 'package:website/helpers/pages_ids.dart';
import 'package:website/helpers/utils.dart';
import 'package:easy_localization/easy_localization.dart';

class HtmlContentPage extends StatefulWidget {
  final postId;
  HtmlContentPage({
    Key key,
    @required this.postId,
  }) : super(key: key);

  @override
  _HtmlContentPageState createState() => _HtmlContentPageState();
}

class _HtmlContentPageState extends State<HtmlContentPage> {
  DataCenter _data;
  PageId _pageId;
  String _content;
  BlocBloc _bloc;

  @override
  void initState() {
    super.initState();
    _pageId = PageId.Post;
    _bloc = BlocBloc();
    _handleGettingData();
    _data = DataCenter.instance;
    _content = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Utils.backgroundColor,
        body: SafeArea(
            child: Column(children: [
          _topper(),
          BlocListener<BlocBloc, BlocState>(
            bloc: _bloc,
            listener: (context, state) {
              if (state is Ok && state.pageId == _pageId)
                setState(() {
                  _content = _data.content;
                });
            },
            child: BlocBuilder<BlocBloc, BlocState>(
              bloc: _bloc,
              builder: (context, state) {
                if (state is Loading && state.pageId == _pageId)
                  return Expanded(child: _contentLoading());

                if (state is Error && state.pageId == _pageId)
                  return Expanded(child: _contentError());

                return Expanded(child: _contentUI());
              },
            ),
          ),
        ])));
  }

  Widget _contentLoading() {
    return Center(child: CircularProgressIndicator());
  }

  Widget _contentError() {
    return Align(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
            color: Colors.redAccent,
          ),
          height: 50,
          child: Row(children: [
            Padding(padding: EdgeInsets.only(right: 4.0, left: 4.0)),
            Text(
              'Internet is slow or unavaiable'.tr(),
              style: TextStyle(
                fontFamily: 'din_next',
                fontSize: 15,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
            Expanded(child: Container()),
            GestureDetector(
              onTap: _handleGettingData,
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                child: Text(
                  'press to refresh'.tr(),
                  style: TextStyle(
                    fontFamily: 'din_next',
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    decoration: TextDecoration.underline,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(right: 4.0, left: 4.0)),
          ]),
        ),
      ),
      alignment: Alignment.bottomCenter,
    );
  }

  Widget _contentUI() {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0, top: 16, bottom: 16),
          child: Text(
            'الهمداني: التعليم مفتاح نهضة البلدان',
            style: TextStyle(
              fontFamily: 'din_next',
              fontSize: 20,
              color: const Color(0xff20657d),
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.right,
          ),
        ),
        Container(
          constraints: BoxConstraints(minHeight: 700),
          child: Directionality(
            textDirection: mat.TextDirection.rtl,
            child: Html(
              data: _content,
            ),
          ),
        ),
      ],
    );
  }

  Widget _topper() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(
        color: Utils.fromHex("#20657D"),
      ),
      child: Row(
        children: [
          Expanded(child: Container()),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
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
        ],
      ),
    );
  }

  _handleGettingData() {
    _bloc.add(GetArticalContent(pageId: _pageId));
  }
}
