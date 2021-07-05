import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:website/bloc/bloc_bloc.dart';
import 'package:website/components/select_item.dart';
import 'package:website/helpers/data.dart';
import 'package:website/helpers/pages_ids.dart';
import 'package:website/models/select_model.dart';
import 'package:easy_localization/easy_localization.dart';

class SelectCategories extends StatefulWidget {
  SelectCategories({
    Key key,
  }) : super(key: key);

  @override
  _SelectCategoriesState createState() => _SelectCategoriesState();
}

class _SelectCategoriesState extends State<SelectCategories> {
  PageId _pageId;
  DataCenter _data;
  List<SelectModel> _items;
  BlocBloc _bloc;

  @override
  void initState() {
    super.initState();
    _pageId = PageId.CreatePost;
    _data = DataCenter.instance;
    _items = [];
    _bloc = BlocBloc();

    _handleRequestCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocListener<BlocBloc, BlocState>(
        bloc: _bloc,
        listener: (context, state) {
          if (state is Ok && state.pageId == _pageId) {
            setState(() {
              _items = _data.categories.categories
                  .map((e) => SelectModel(value: e, isSelected: false))
                  .toList();
            });
          }
        },
        child: BlocBuilder<BlocBloc, BlocState>(
          bloc: _bloc,
          builder: (context, state) {
            if (state is Loading && state.pageId == _pageId) return _loading();

            if (state is Error && state.pageId == _pageId) return _error();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(padding: EdgeInsets.all(24.0)),
                Text(
                  "choose categories for the post".tr(),
                  style: TextStyle(
                    fontFamily: 'din_next',
                    fontSize: 38,
                    color: const Color(0xff20657d),
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.left,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: GridView.builder(
                        itemCount: _items.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              _handleSelected(index);
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 8.0),
                              child: SelectItem(selectModel: _items[index]),
                            ),
                          );
                        },
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 0,
                          crossAxisSpacing: 2,
                          childAspectRatio: 2,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _loading() {
    return Center(child: CircularProgressIndicator());
  }

  Widget _error() {
    return Column(
      children: [
        Expanded(child: Container()),
        Padding(
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
                onTap: _handleRequestCategories,
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
      ],
    );
  }

  _handleSelected(index) {
    setState(() {
      _items[index].isSelected = !_items[index].isSelected;
    });
  }

  _handleRequestCategories() {
    _bloc.add(GetCategories(pageId: _pageId));
  }
}
