import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:website/bloc/bloc_bloc.dart';
import 'package:website/components/artical_item.dart';
import 'package:website/helpers/data.dart';
import 'package:website/helpers/pages_ids.dart';
import 'package:website/helpers/utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:website/models/posts_model.dart';

class SearchSreen extends StatefulWidget {
  SearchSreen({Key key}) : super(key: key);

  @override
  _SearchSreenState createState() => _SearchSreenState();
}

class _SearchSreenState extends State<SearchSreen> {
  PageId _pageId;
  TextEditingController _controller;
  ScrollController _scroll;
  List<Post> _posts;
  DataCenter _data;
  BlocBloc _bloc;

  @override
  void initState() {
    super.initState();
    _pageId = PageId.Search;
    _data = DataCenter.instance;
    _bloc = BlocBloc();
    _posts = [];
    _controller = TextEditingController();
    _scroll = ScrollController();
    _scroll.addListener(() {
      if (_scroll.offset >= _scroll.position.maxScrollExtent &&
          !_scroll.position.outOfRange) _handleDataRequest();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Utils.backgroundColor,
        body: SafeArea(
          child: Column(
            children: [
              Padding(padding: EdgeInsets.all(4.0)),
              Center(child: _topperBar()),
              BlocListener(
                bloc: _bloc,
                listener: (context, state) {
                  if (state is Ok && state.pageId == _pageId)
                    setState(() {
                      _posts = _data.posts.posts.data;
                    });
                },
                child: BlocBuilder(
                  bloc: _bloc,
                  builder: (context, state) {
                    return Expanded(
                      child: Column(
                        children: [
                          _posts.length > 0 ? _list() : Container(),
                          state is Ok &&
                                  state.pageId == _pageId &&
                                  _posts.length == 0
                              ? _noData()
                              : Container(),
                          state is Error && state.pageId == _pageId
                              ? _error()
                              : Container(),
                          state is Loading &&
                                  state.pageId == _pageId &&
                                  _posts.length == 0
                              ? Expanded(child: _loading())
                              : Container(),
                          state is Loading &&
                                  state.pageId == _pageId &&
                                  _posts.length > 0
                              ? Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: _loading(),
                                )
                              : Container(),
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ));
  }

  Widget _topperBar() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 35.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.0),
        color: const Color(0xffffffff),
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _controller,
                onChanged: (value) {
                  // TODO: add it to hive box
                },
                decoration: InputDecoration.collapsed(
                  hintText: "Write the query here".tr(),
                  hintStyle: TextStyle(
                    fontFamily: 'din_next',
                    fontSize: 15,
                    color: const Color(0xff707070),
                    fontWeight: FontWeight.w700,
                  ),
                  border: InputBorder.none,
                ),
                style: TextStyle(
                  fontFamily: 'din_next',
                  fontSize: 15,
                  color: const Color(0xff707070),
                  fontWeight: FontWeight.w700,
                ),
                maxLines: 1,
              ),
            ),
          ),
          GestureDetector(
            onTap: _handleCancel,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: _daText('cancel'.tr()),
            ),
          ),
          Container(
            width: 2,
            height: 25,
            alignment: Alignment.center,
            color: const Color(0xff707070),
          ),
          GestureDetector(
            onTap: _handleSearch,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: _daText('search'.tr()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _daText(value) {
    return Text(
      value,
      style: TextStyle(
        fontFamily: 'din_next',
        fontSize: 15,
        color: const Color(0xff707070),
        fontWeight: FontWeight.w700,
      ),
      textAlign: TextAlign.left,
    );
  }

  Widget _list() {
    return Expanded(
      child: ListView.builder(
        controller: _scroll,
        itemCount: _posts.length,
        itemBuilder: (context, index) {
          if (index == 0)
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 16.0, bottom: 8.0, left: 16.0, right: 16.0),
                  child: Text(
                    "Query results".tr(),
                    style: TextStyle(
                      fontFamily: 'din_next',
                      fontSize: 13,
                      color: const Color(0xffe0ae4b),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                ArticalItemComponent(
                  input: _posts[index],
                ),
              ],
            );
          return ArticalItemComponent(
            input: _posts[index],
          );
        },
      ),
    );
  }

  Widget _loading() {
    return Center(
      child: CircularProgressIndicator(),
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
            onTap: _handleDataRequest,
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
              onTap: _handleDataRequest,
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

  _handleSearch() {
    setState(() {
      _posts = [];
      _bloc.add(Query());
    });
  }

  _handleDataRequest() {
    // _bloc.add(GetNextItems(pageId: _pageId, offset: posts.posts.currentPage));
  }

  _handleCancel() {
    _controller.clear();
  }
}
