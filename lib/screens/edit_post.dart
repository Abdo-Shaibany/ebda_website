import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:website/bloc/bloc_bloc.dart';
import 'package:website/helpers/data.dart';
import 'package:website/helpers/pages_ids.dart';
import 'package:website/models/select_model.dart';
import 'package:easy_localization/easy_localization.dart';

class EditPost extends StatefulWidget {
  EditPost({Key key}) : super(key: key);

  @override
  _EditPostState createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
  PageId _pageId;
  List<String> _languages;
  int _currentLanguage;
  String _imagePath;
  DataCenter _data;
  String _postContent;
  BlocBloc _bloc;
  List<SelectModel> _selectedCategories;

  HtmlEditorController controller = HtmlEditorController();
  // GlobalKey<HtmlEditorState> keyEditor = GlobalKey();

  @override
  void initState() {
    super.initState();
    _pageId = PageId.CreatePost;
    _data = DataCenter.instance;
    _languages = ['ARABIC', 'ENGLISH'];
    _currentLanguage = 0;
    _imagePath = '';
    _postContent = '';
    _selectedCategories = [];
    _bloc = BlocBloc();

    _bloc.add(GetEditPostContent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BlocBloc, BlocState>(
      bloc: _bloc,
      listener: (context, state) {
        if (state is Ok && state.pageId == _pageId)
          setState(() {
            // _imagePath = _data.getEditPostImagePath();
            // _postContent = _data.getEditPostContent();
          });
      },
      child: BlocBuilder<BlocBloc, BlocState>(
        bloc: _bloc,
        builder: (context, state) {
          if (state is Loading && state.pageId == _pageId) return _loading();
          return Column(
            children: [
              Expanded(child: _content()),
            ],
          );
        },
      ),
    );
  }

  Widget _loading() {
    return Center(child: CircularProgressIndicator());
  }

  Widget _topperBtns() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _daBtn(_languages[0], _currentLanguage == 0, 0),
        _daBtn(_languages[1], _currentLanguage == 1, 1),
      ],
    );
  }

  Widget _daBtn(value, isSelected, index) {
    return GestureDetector(
      onTap: () => _handleSwitchLanguage(index),
      child: Container(
        width: 120.0,
        height: 35.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: isSelected ? Color(0xff20657d) : Color(0xffd8d7d7),
        ),
        child: Center(
          child: Text(
            value.tr(),
            style: TextStyle(
              fontFamily: 'din_next',
              fontSize: 13,
              color: isSelected ? Color(0xffd8d7d7) : Color(0xff707070),
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }

  Widget _content() {
    return ListView(
      children: [
        Padding(padding: EdgeInsets.all(12.0)),
        _topperBtns(),
        Padding(padding: EdgeInsets.all(12.0)),
        _daFieldContainer(
            'عنوان المنشور (عربي)', TextInputType.text, (value) => null),
        Padding(padding: EdgeInsets.all(8.0)),
        _daImagePicker(),
        Padding(padding: EdgeInsets.all(8.0)),
        _daCards(),
        Padding(padding: EdgeInsets.all(8.0)),
        _daEditor(),
      ],
    );
  }

  Widget _daEditor() {
    return HtmlEditor(
      controller: controller,
      htmlEditorOptions: HtmlEditorOptions(
        hint: "EDITOR HINT".tr(),
      ),
      otherOptions: OtherOptions(
        height: 600,
      ),
      htmlToolbarOptions: HtmlToolbarOptions(defaultToolbarButtons: [
        //add constructors here and set buttons to false, e.g.
        ParagraphButtons(
          increaseIndent: false,
          decreaseIndent: false,
          lineHeight: false,
          caseConverter: false,
        ),
        // StyleButtons(style: false),
        FontSettingButtons(
          fontName: false,
          fontSizeUnit: false,
        ),
        FontButtons(),
        ColorButtons(),
        ListButtons(listStyles: false),
        InsertButtons(
          audio: false,
          video: false,
          otherFile: false,
          table: false,
        ),
        OtherButtons(
          fullscreen: false,
          codeview: false,
          undo: false,
          redo: false,
          help: false,
        ),
      ]),
    );
  }

  Widget _daCards() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.0),
        color: const Color(0xffffffff),
        boxShadow: [
          BoxShadow(
            color: const Color(0x29000000),
            offset: Offset(0, 3),
            blurRadius: 6,
          ),
        ],
      ),
      alignment: Alignment.center,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: _selectedCategories
            .map((e) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2.0),
                      color: const Color(0xff20657d),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 5.0, left: 5.0),
                        child: Text(
                          e.value.categoryNameAr,
                          style: TextStyle(
                            fontFamily: 'din_next',
                            fontSize: 13,
                            color: const Color(0xffffffff),
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget _daImagePicker() {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Row(
          children: [
            GestureDetector(
              onTap: _handleImagePicker,
              child: Container(
                width: 150.0,
                height: 40.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: const Color(0xff20657d),
                ),
                child: Center(
                  child: Text(
                    'add picture'.tr(),
                    style: TextStyle(
                      fontFamily: 'Ara Hamah 1964 B',
                      fontSize: 13,
                      color: const Color(0xffffffff),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.all(8.0)),
            Text(
              'no file chosen'.tr(),
              style: TextStyle(
                fontFamily: 'din_next',
                fontSize: 13,
                color: const Color(0xff707070),
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }

  Widget _daFieldContainer(hintText, inputType, Function(String) validator,
      {hide = false}) {
    return Stack(
      children: [
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 40.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: const Color(0xffffffff),
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 32, left: 32, bottom: 1.0),
            child: TextFormField(
              onChanged: (value) {
                // TODO: enter values to hive box
              },
              validator: validator,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: TextStyle(
                  fontFamily: 'din_next',
                  fontSize: 17,
                  color: const Color(0xff20657d),
                  fontWeight: FontWeight.w700,
                ),
              ),
              obscureText: hide,
              keyboardType: inputType,
              style: TextStyle(
                fontFamily: 'din_next',
                fontSize: 17,
                color: const Color(0xff20657d),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }

  _handleSwitchLanguage(index) {
    setState(() {
      _currentLanguage = index;
    });
  }

  _handleImagePicker() {}
}
