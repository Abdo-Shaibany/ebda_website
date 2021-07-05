import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as mat;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:website/bloc/bloc_bloc.dart';
import 'package:website/helpers/data.dart';
import 'package:website/helpers/pages_ids.dart';
import 'package:website/helpers/utils.dart';
import 'package:website/models/comment_model.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:easy_localization/easy_localization.dart';

class DaPost extends StatefulWidget {
  final postId;
  DaPost({
    Key key,
    @required this.postId,
  }) : super(key: key);

  @override
  _DaPostState createState() => _DaPostState();
}

class _DaPostState extends State<DaPost> {
  DataCenter _data;

  PageId _pageId;
  PageId _addCommentId;
  PageId _getCommentsId;

  String _content;
  List<CommentModel> _comments;

  TextEditingController _controller;
  ScrollController _scrollController;

  List<String> languages;
  int currentLanguage;

  BlocBloc _bloc;

  bool _isFav;

  @override
  void initState() {
    super.initState();
    _pageId = PageId.Post;
    _addCommentId = PageId.AddComment;
    _getCommentsId = PageId.Comments;

    _bloc = BlocBloc();
    _handleGettingData();
    _data = DataCenter.instance;

    _controller = TextEditingController();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.offset >=
              _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) _handleRequestComments();
    });

    languages = _data.getPostLanguages(widget.postId);
    currentLanguage = 0;

    _content = '';

    // _isFav = _data.isFav(widget.postId);

    _comments = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Utils.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
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
          ],
        ),
      ),
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
          GestureDetector(
            onTap: _handleBookmarking,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SvgPicture.asset(
                "assets/icons/heart.svg",
                width: 20,
                height: 20,
                color: _isFav ? Colors.redAccent : Utils.backgroundColor,
              ),
            ),
          ),
          GestureDetector(
            onTap: _handleSwitchLanguage,
            child: Padding(
              padding: const EdgeInsets.only(
                  right: 12.0, left: 12.0, top: 16.0, bottom: 16.0),
              child: Text(
                currentLanguage == 0
                    ? "read the english copy".tr()
                    : "read the arabic copy".tr(),
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

  Widget _contentUI() {
    return ListView(
      controller: _scrollController,
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
        // Container(
        //   color: Utils.fromHex('#20657D'),
        //   child: Column(
        //     children: [_addComment(), _commentsSection()],
        //   ),
        // ),
      ],
    );
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
              onTap: _handleGettingData,
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
      ),
      alignment: Alignment.bottomCenter,
    );
  }

  Widget _addComment() {
    return BlocListener<BlocBloc, BlocState>(
      bloc: _bloc,
      listener: (context, state) {
        if (state is Ok && state.pageId == PageId.AddComment)
          setState(() {
            _comments.insert(
                0,
                CommentModel(
                    commentId: '',
                    user: 'صاحب الهاتف',
                    comment: 'هذا التعليق انا قمت بالتعليق به قبل عده ثواني'));
          });
      },
      child: BlocBuilder<BlocBloc, BlocState>(
        bloc: _bloc,
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 40.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2.0),
                color: const Color(0xfffcfbfc),
              ),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: _controller,
                    cursorColor: const Color(0xff707070),
                    style: TextStyle(
                      fontFamily: 'din_next',
                      fontSize: 15,
                      color: const Color(0xff707070),
                      fontWeight: FontWeight.w700,
                    ),
                    showCursor: true,
                    decoration: InputDecoration(
                      hintText: "your comment goes here".tr(),
                      contentPadding:
                          EdgeInsets.only(right: 8.0, left: 8.0, bottom: 10.0),
                      border: InputBorder.none,
                    ),
                  )),
                  state is Loading && state.pageId == _addCommentId
                      ? _addCommentLoading()
                      : state is Error && state.pageId == _addCommentId
                          ? GestureDetector(
                              onTap: _handleAddComment,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'try again'.tr(),
                                  style: TextStyle(
                                    fontFamily: 'din_next',
                                    fontSize: 15,
                                    color: Colors.redAccent,
                                    fontWeight: FontWeight.w700,
                                    decoration: TextDecoration.underline,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            )
                          : GestureDetector(
                              onTap: _handleAddComment,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'add comment'.tr(),
                                  style: TextStyle(
                                    fontFamily: 'din_next',
                                    fontSize: 15,
                                    color: Utils.fromHex('#20657D'),
                                    fontWeight: FontWeight.w700,
                                    decoration: TextDecoration.underline,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _addCommentLoading() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Center(
        child: Container(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2.0,
          ),
        ),
      ),
    );
  }

  // Widget _commentsSection() {
  //   return BlocListener<BlocBloc, BlocState>(
  //     bloc: _bloc,
  //     listener: (context, state) {
  //       if (state is Ok && state.pageId == _getCommentsId)
  //         setState(() {
  //           _comments.addAll(_data.getComments(_comments.length));
  //         });
  //     },
  //     child: BlocBuilder<BlocBloc, BlocState>(
  //       bloc: _bloc,
  //       builder: (context, state) {
  //         return Column(
  //           children: [
  //             Column(
  //               children: _comments
  //                   .map((e) => Padding(
  //                         padding: const EdgeInsets.only(
  //                           top: 8.0,
  //                           bottom: 8.0,
  //                         ),
  //                         child: CommentItem(model: e),
  //                       ))
  //                   .toList(),
  //             ),
  //             if (state is Loading && state.pageId == _getCommentsId)
  //               _commentsLoading(),
  //             if (state is Error && state.pageId == _getCommentsId)
  //               _commentsError(),
  //           ],
  //         );
  //       },
  //     ),
  //   );
  // }

  // Widget _commentsLoading() {
  //   return Padding(
  //     padding: const EdgeInsets.all(8.0),
  //     child: Center(
  //       child: CircularProgressIndicator(),
  //     ),
  //   );
  // }

  // Widget _commentsError() {
  //   return GestureDetector(
  //     onTap: _handleRequestComments,
  //     child: Padding(
  //       padding: const EdgeInsets.all(12.0),
  //       child: Text(
  //         "press to retry".tr(),
  //         style: TextStyle(
  //           fontFamily: 'din_next',
  //           fontSize: 15,
  //           color: Colors.redAccent,
  //           fontWeight: FontWeight.w700,
  //           decoration: TextDecoration.underline,
  //         ),
  //         textAlign: TextAlign.left,
  //       ),
  //     ),
  //   );
  // }

  _handleSwitchLanguage() {
    setState(() {
      currentLanguage = currentLanguage == 0 ? 1 : 0;
    });
  }

  _handleBookmarking() {
    // _data.updateFav(widget.postId, !_isFav);
    setState(() {
      _isFav = !_isFav;
    });
  }

  _handleGettingData() {
    _bloc.add(GetArticalContent(pageId: _pageId));
  }

  _handleRequestComments() {
    // _bloc.add(GetNextItems(pageId: _getCommentsId, pageNo: _comments.length));
  }

  _handleAddComment() {
    if (_controller.value.toString() == "") return;
    // _data.updateMyComment(CommentModel(
    //     commentId: '', user: '', comment: _controller.value.toString()));
    _bloc.add(AddComment());
  }
}
