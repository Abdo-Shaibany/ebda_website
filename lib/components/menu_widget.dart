import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:website/bloc/bloc_bloc.dart';
import 'package:website/components/add_email.dart';
import 'package:website/helpers/data.dart';
import 'package:website/helpers/pages_ids.dart';
import 'package:website/helpers/utils.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MenuWidget extends StatefulWidget {
  const MenuWidget({Key key}) : super(key: key);

  @override
  _MenuWidgetState createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  DataCenter _data;

  @override
  void initState() {
    super.initState();
    _data = DataCenter.instance;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Utils.backgroundColor,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width * 0.65,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight:
                  Radius.circular(MediaQuery.of(context).size.width * 0.50),
              bottomLeft: Radius.circular(5.0),
            ),
            color: const Color(0xff20657d),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: ListView(
              children: [
                _daText("app\nof ri-bu.com website".tr()),
                Padding(padding: EdgeInsets.all(16.0)),
                BlocBuilder<BlocBloc, BlocState>(
                  bloc: DataCenter.userAuthBloc,
                  builder: (context, state) {
                    if (state is Ok && state.pageId == PageId.SignIn && false) {
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () =>
                                Navigator.pushNamed(context, "/sign_in"),
                            child: _daItem("log out".tr(), "logout"),
                          ),
                          Padding(padding: EdgeInsets.all(8.0)),
                          GestureDetector(
                            onTap: () =>
                                Navigator.pushNamed(context, "/my_articals"),
                            child: _daItem("my articals".tr(), "writer"),
                          ),
                          Padding(padding: EdgeInsets.all(8.0)),
                          GestureDetector(
                            onTap: () =>
                                Navigator.pushNamed(context, "/search"),
                            child: _daItem('search'.tr(), "search"),
                          ),
                        ],
                      );
                    }
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pushNamed(context, "/sign_in"),
                          child: _daItem('log in'.tr(), "sign_in"),
                        ),
                        Padding(padding: EdgeInsets.all(8.0)),
                        GestureDetector(
                          onTap: () => Navigator.pushNamed(context, "/search"),
                          child: _daItem('search'.tr(), "search"),
                        ),
                      ],
                    );
                  },
                ),

                Padding(padding: EdgeInsets.all(4.0)),
                Container(
                  height: 2,
                  width: MediaQuery.of(context).size.width * 0.65,
                  color: Utils.backgroundColor,
                ),
                Padding(padding: EdgeInsets.all(4.0)),
                GestureDetector(
                    onTap: () => Navigator.pushNamed(context, "/"),
                    child: _daItem('home'.tr(), "home")),
                Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                    onTap: () =>
                        Navigator.pushNamed(context, "/", arguments: [1]),
                    child: _daItem('journal'.tr(), "journal")),
                Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                    onTap: () => Navigator.pushNamed(context, "/browser"),
                    child: _daItem('explorer categories'.tr(), "categories")),
                Padding(padding: EdgeInsets.all(4.0)),
                Container(
                  height: 2,
                  width: MediaQuery.of(context).size.width * 0.65,
                  color: Utils.backgroundColor,
                ),
                Padding(padding: EdgeInsets.all(4.0)),
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AddEmailMessage();
                        });
                  },
                  child: _daItem("SUBSCRIBE TO RSS FEEDS".tr(), "subscription"),
                ),
                Padding(padding: EdgeInsets.all(8.0)),
                // TODO: follow us
                _daItem("follow us at social media".tr(), "followers"),
                Padding(padding: EdgeInsets.all(8.0)),
                Row(
                  children: [
                    Expanded(child: Container()),
                    Image.asset("assets/icons/facebook.png"),
                    Padding(padding: EdgeInsets.all(4.0)),
                    Image.asset("assets/icons/twitter.png"),
                    Padding(padding: EdgeInsets.all(4.0)),
                    Image.asset("assets/icons/instagram.png"),
                    Padding(padding: EdgeInsets.all(4.0)),
                    Image.asset("assets/icons/youtube.png"),
                    Expanded(child: Container()),
                  ],
                ),
                Padding(padding: EdgeInsets.all(4.0)),
                Container(
                  height: 2,
                  width: MediaQuery.of(context).size.width * 0.65,
                  color: Utils.backgroundColor,
                ),
                Padding(padding: EdgeInsets.all(4.0)),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/da_html_content',
                      arguments: ['']),
                  child: _daItem('ABOUT THE BLOG'.tr(), "about_blog"),
                ),
                Padding(padding: EdgeInsets.all(8.0)),
                _daItem('Privacy policy'.tr(), "private"),
                Padding(padding: EdgeInsets.all(8.0)),
                _daItem('ABOUT US'.tr(), "about_us"),
                Padding(padding: EdgeInsets.all(8.0)),
                _daItem('contact us'.tr(), "contact_us"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _daItem(value, path) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
        ),
        SvgPicture.asset(
          "assets/icons/$path.svg",
          width: 20,
          height: 20,
          color: Colors.white,
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
        ),
        _daText(value)
      ],
    );
  }

  Widget _daText(value) {
    return Text(
      value,
      style: TextStyle(
        fontFamily: 'din_next',
        fontSize: 15,
        color: const Color(0xffffffff),
        fontWeight: FontWeight.w700,
      ),
      textAlign: TextAlign.center,
    );
  }

  bool _isSignIn() {
    // TODO: go to cache data
  }
}
