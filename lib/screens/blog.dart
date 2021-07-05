import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:website/bloc/bloc_bloc.dart';
import 'package:website/components/artical_item.dart';
import 'package:website/components/setion_topper.dart';
import 'package:website/helpers/data.dart';
import 'package:website/helpers/pages_ids.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:website/models/categories_model.dart';
import 'package:website/models/posts_model.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({Key key}) : super(key: key);

  @override
  _BlogScreenState createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  PageId _pageId;
  List<Category> _categories;
  int _currentCategory;
  List<String> _filters;
  int _currentFilter;
  List<Post> _posts;
  int _totalPages;
  int _currentPage;
  DataCenter _data;
  BlocBloc _bloc;

  @override
  void initState() {
    super.initState();
    _pageId = PageId.Blog;
    _data = DataCenter.instance;

    _categories = [];
    _currentCategory = 0;

    _filters = _data.blogFilters;
    _currentFilter = _data.currentBlogFilter;

    _posts = [];
    _totalPages = 0;
    _currentPage = 1;

    _bloc = BlocBloc();
    _handleDataRequest(_currentPage);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BlocBloc, BlocState>(
      bloc: _bloc,
      listener: (context, state) {
        if (state is Ok && state.pageId == _pageId) {
          setState(() {
            _posts = _data.posts.posts.data;
            _categories = _data.categories.categories;
            _totalPages = _data.posts.posts.lastPage;
          });
        }
      },
      child: BlocBuilder<BlocBloc, BlocState>(
        bloc: _bloc,
        builder: (context, state) {
          return Column(
            children: [
              _cover(),
              state is Loading && state.pageId == _pageId
                  ? Container()
                  : state is Error && state.pageId == _pageId
                      ? Container()
                      : state is Ok && _categories.length == 0
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: _topper(),
                            ),
              Expanded(
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
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _topper() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: _filters
              .asMap()
              .entries
              .map((e) => GestureDetector(
                    onTap: () => setState(() {
                      _currentFilter = e.key;
                      _data.currentBlogFilter = e.key;
                      _bloc.add(GetNextItems(
                        pageId: _pageId,
                        pageNo: 1,
                      ));
                      _posts = [];
                    }),
                    child: Text(
                      e.value,
                      style: TextStyle(
                        fontFamily: 'din_next',
                        fontSize: 20,
                        color: e.key == _currentFilter
                            ? const Color(0xff20657d)
                            : Colors.grey,
                        fontWeight: FontWeight.w700,
                        decoration: e.key == _currentFilter
                            ? TextDecoration.underline
                            : TextDecoration.none,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ))
              .toList(),
        ),
        Padding(
          padding: const EdgeInsets.only(
            right: 8.0,
            left: 8.0,
            top: 2.0,
          ),
          child: Container(
            height: 2,
            width: MediaQuery.of(context).size.width * 0.9,
            color: const Color(0xff20657d),
          ),
        ),
        _categories.length == 0
            ? Container()
            : Container(
                width: MediaQuery.of(context).size.width,
                height: 40,
                child: Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: ListView.builder(
                        itemCount: _categories.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return _topperText(_categories[index], index);
                        })),
              ),
      ],
    );
  }

  Widget _topperText(Category value, index) {
    return GestureDetector(
      onTap: () => _handleCategoriesTopperClicked(index),
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0, left: 8.0),
        child: Text(
          value.categoryNameAr,
          style: TextStyle(
            fontFamily: 'din_next',
            fontSize: 15,
            color: _currentCategory == index
                ? const Color(0xff20657d)
                : const Color(0xff828283),
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }

  Widget _cover() {
    return SetionTopper(title: 'home'.tr());
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
            'الإنترنت ضعيف او غير موجود',
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
                'اضغط للتحديث',
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
              'لا يوجد بيانات لعرضها',
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
                'اضغط هنا للتحديث',
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

  _handleCategoriesTopperClicked(index) {
    setState(() {
      _data.currentCategoryIndex = index;
      _currentCategory = index;
      _bloc.add(GetNextItems(
        pageId: _pageId,
        pageNo: 0,
      ));
    });
  }

  _handleDataRequest(pageNo) {
    setState(() {
      _bloc.add(GetNextItems(
        pageId: _pageId,
        pageNo: pageNo,
      ));
      _posts = [];
      _currentPage = pageNo;
    });
  }
}
