import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:website/bloc/bloc_bloc.dart';
import 'package:website/components/setion_topper.dart';
import 'package:website/helpers/data.dart';
import 'package:website/helpers/pages_ids.dart';

import 'package:easy_localization/easy_localization.dart';

class ScreenModel extends StatefulWidget {
  final Widget topper;
  final PageId pageId;
  final String title;
  final Function(dynamic) itemUI;

  ScreenModel({
    Key key,
    @required this.topper,
    @required this.pageId,
    @required this.itemUI,
    @required this.title,
  }) : super(key: key);

  @override
  _ScreenModelState createState() => _ScreenModelState();
}

class _ScreenModelState extends State<ScreenModel> {
  DataCenter _data;
  List<dynamic> _items;
  BlocBloc _bloc;

  int _totalPages;
  int _currentPage;

  @override
  void initState() {
    super.initState();
    _data = DataCenter.instance;
    _items = [];

    _totalPages = 0;
    _currentPage = 1;

    _bloc = BlocBloc();
    _bloc.add(GetNextItems(pageId: widget.pageId, pageNo: 1));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BlocBloc, BlocState>(
      bloc: _bloc,
      listener: (context, state) {
        if (state is Ok && state.pageId == widget.pageId)
          setState(() {
            _items = _data.getNext(widget.pageId);
            _totalPages = _data.getTotal(widget.pageId);
          });
      },
      child: BlocBuilder<BlocBloc, BlocState>(
        bloc: _bloc,
        builder: (context, state) {
          return Column(
            children: [
              _cover(),
              state is Loading && state.pageId == widget.pageId
                  ? _loading()
                  : Container(),
              Expanded(
                child: Column(
                  children: [
                    state is Ok && _items.length == 0 ? _noData() : _list(),
                    state is Error && state.pageId == widget.pageId
                        ? _error()
                        : Container(),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _cover() {
    if (widget.title == "") return Container();
    return SetionTopper(title: widget.title);
  }

  Widget _topper() {
    return widget.topper;
  }

  Widget _list() {
    return Expanded(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Center(
          child: ListView.builder(
            itemCount: _items.length,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: _topper(),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: widget.itemUI(
                        _items[index],
                      ),
                    ),
                  ],
                );
              }

              if (index == _items.length - 1)
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: widget.itemUI(
                        _items[index],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: _totalPages > 1 ? _pagnationBar() : Container(),
                    ),
                  ],
                );

              return Padding(
                padding: EdgeInsets.all(8.0),
                child: widget.itemUI(
                  _items[index],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _pagnationBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 40,
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (_currentPage == 1) return;
                      _handleDataRequest(_currentPage - 1);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                      child: Container(
                        child: EasyLocalization.of(context).currentLocale ==
                                Locale('ar')
                            ? SvgPicture.asset(
                                "assets/icons/right_pointer.svg",
                                width: 25,
                                height: 25,
                              )
                            : SvgPicture.asset(
                                "assets/icons/left_pointer.svg",
                                width: 25,
                                height: 25,
                              ),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(4.0)),
                  Expanded(
                      child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      for (int i = 0; i < _totalPages; i++)
                        GestureDetector(
                          onTap: () => {
                            _handleDataRequest(i + 1),
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.only(right: 8.0, left: 8.0),
                            child: Text(
                              (i + 1).toString(),
                              style: TextStyle(
                                fontFamily: 'din_next',
                                fontSize: 18,
                                color: _currentPage == (i + 1)
                                    ? const Color(0xff20657d)
                                    : Colors.grey,
                                fontWeight: FontWeight.w900,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ),
                    ],
                  )),
                  Padding(padding: EdgeInsets.all(4.0)),
                  GestureDetector(
                    onTap: () {
                      if (_currentPage == _totalPages) return;
                      _handleDataRequest(_currentPage + 1);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                      child: Container(
                        child: EasyLocalization.of(context).currentLocale ==
                                Locale('ar')
                            ? SvgPicture.asset(
                                "assets/icons/left_pointer.svg",
                                width: 50,
                                height: 50,
                              )
                            : SvgPicture.asset(
                                "assets/icons/right_pointer.svg",
                                width: 50,
                                height: 50,
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 2,
                width: MediaQuery.of(context).size.width,
                color: const Color(0xff20657d),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _loading() {
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5.0))),
      child: LinearProgressIndicator(),
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
    );
  }

  Widget _error() {
    return Padding(
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
            "Internet is slow or unavaiable".tr(),
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
            onTap: () => _handleDataRequest(_currentPage),
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0, left: 8.0),
              child: Text(
                "press to refresh".tr(),
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
    );
  }

  Widget _noData() {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "There ain't any data".tr(),
              style: TextStyle(
                fontFamily: 'din_next',
                fontSize: 25,
                color: const Color(0xff20657d),
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
            Padding(padding: EdgeInsets.all(12.0)),
            GestureDetector(
              onTap: () => _handleDataRequest(_currentPage),
              child: Text(
                "press to refresh".tr(),
                style: TextStyle(
                  fontFamily: 'din_next',
                  fontSize: 15,
                  color: const Color(0xff20657d),
                  fontWeight: FontWeight.w700,
                  decoration: TextDecoration.underline,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _handleDataRequest(pageNo) {
    _bloc.add(GetNextItems(
      pageId: widget.pageId,
      pageNo: pageNo,
    ));
    setState(() {
      _currentPage = pageNo;
      _items = [];
    });
  }
}
