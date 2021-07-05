import 'package:flutter/material.dart';
import 'package:website/components/menu_widget.dart';
import 'package:website/components/topper.dart';
import 'package:website/helpers/utils.dart';

class Homeles extends StatelessWidget {
  final Widget child;
  const Homeles({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldkey =
        new GlobalKey<ScaffoldState>();

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
          Expanded(
            child: child,
          ),
        ],
      )),
    );
  }
}
