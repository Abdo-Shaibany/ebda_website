import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:website/bloc/bloc_bloc.dart';
import 'package:website/components/artical_item.dart';
import 'package:website/components/menu_widget.dart';
import 'package:website/components/topper.dart';
import 'package:website/helpers/data.dart';
import 'package:website/helpers/pages_ids.dart';
import 'package:website/helpers/utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:website/models/posts_model.dart';

class DaCategory extends StatefulWidget {
  final String category;
  const DaCategory({
    Key key,
    @required this.category,
  }) : super(key: key);

  @override
  _DaCategoryState createState() => _DaCategoryState();
}

class _DaCategoryState extends State<DaCategory> {
  PageId _pageId;
  List<Post> _posts;
  DataCenter _data;
  BlocBloc _bloc;

  int _totalPages;
  int _currentPage;

  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _pageId = PageId.Blog;
    _data = DataCenter.instance;

    _posts = [];

    _totalPages = 0;
    _currentPage = 0;

    _bloc = BlocBloc();
    _handleDataRequest(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Utils.backgroundColor,
        drawer: MenuWidget(),
        key: _scaffoldkey,
        body: SafeArea(
            child: Column(
          children: [
            Topper(
              handleOpenDrawer: () => _scaffoldkey.currentState.openDrawer(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.category,
                style: TextStyle(
                  fontFamily: 'din_next',
                  fontSize: 15,
                  color: const Color(0xff20657d),
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            BlocListener<BlocBloc, BlocState>(
              bloc: _bloc,
              listener: (context, state) {
                if (state is Ok && state.pageId == _pageId)
                  setState(() {
                    _posts = _data.posts.posts.data;
                    _totalPages = _data.posts.posts.total;
                  });
              },
              child: BlocBuilder<BlocBloc, BlocState>(
                bloc: _bloc,
                builder: (context, state) {
                  return Expanded(
                    child: Column(
                      children: [
                        state is Loading && state.pageId == _pageId
                            ? _loading()
                            : Container(),
                        state is Ok && _posts.length == 0 ? _noData() : _list(),
                        state is Error && state.pageId == _pageId
                            ? _error()
                            : Container(),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        )));
  }

  Widget _list() {
    return Expanded(
      child: ListView.builder(
        itemCount: _posts.length,
        itemBuilder: (context, index) {
          if (index == _posts.length - 1) {
            return Column(
              children: [
                ArticalItemComponent(
                  input: _posts[index],
                ),
                if (_totalPages > 1) _pagnationBar(),
              ],
            );
          }
          return ArticalItemComponent(
            input: _posts[index],
          );
        },
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
                            _handleDataRequest(i),
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.only(right: 8.0, left: 8.0),
                            child: Text(
                              (i + 1).toString(),
                              style: TextStyle(
                                fontFamily: 'din_next',
                                fontSize: 18,
                                color: const Color(0xff20657d),
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
            onTap: () => _handleDataRequest(0),
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
              onTap: () => _handleDataRequest(0),
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
      pageId: _pageId,
      pageNo: pageNo,
    ));
  }
}
