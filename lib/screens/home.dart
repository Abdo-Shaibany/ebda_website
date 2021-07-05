import 'package:flutter/material.dart';
import 'package:website/components/bottombar.dart';
import 'package:website/components/menu_widget.dart';
import 'package:website/components/topper.dart';
import 'package:website/helpers/utils.dart';
import 'package:website/models/screen_model.dart';
import 'package:website/screens/blog.dart';
import 'package:website/screens/prices.dart';
import 'package:website/screens/screens_builder.dart';

class Home extends StatefulWidget {
  final int initPageIndex;
  Home({Key key, this.initPageIndex = 0}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController _controller;
  int _currentIndex;
  BlogScreen _blog;
  ScreenModel _journals;
  PricesScreen _prices;
  ScreenModel _jobs;

  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: widget.initPageIndex);
    _currentIndex = widget.initPageIndex;
    _blog = BlogScreen();
    _journals = ScreensBuilder.journalsScreen();
    _prices = PricesScreen();
    _jobs = ScreensBuilder.jobs(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Utils.backgroundColor,
      drawer: Drawer(child: MenuWidget()),
      key: _scaffoldkey,
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Topper(
                    handleOpenDrawer: () =>
                        _scaffoldkey.currentState.openDrawer(),
                  ),
                ),
                Expanded(child: pageview()),
              ],
            ),
          ),
          bottombar(),
        ],
      )),
    );
  }

  Widget bottombar() {
    return Bottombar(
      handleClicked: handler,
      currentIndex: _currentIndex,
    );
  }

  PageView pageview() {
    return PageView(
      physics: new NeverScrollableScrollPhysics(),
      controller: _controller,
      children: [
        _blog,
        _journals,
        _prices,
        _jobs,
      ],
      onPageChanged: (index) => setState(() => {_currentIndex = index}),
    );
  }

  handler(int index) {
    setState(() {
      _controller.jumpToPage(index);
      _currentIndex = index;
    });
  }
}
