import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:website/bloc/bloc_bloc.dart';
import 'package:website/components/setion_topper.dart';
import 'package:website/helpers/data.dart';
import 'package:website/helpers/pages_ids.dart';
import 'package:website/helpers/utils.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:string_validator/string_validator.dart';
import 'package:easy_localization/easy_localization.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  PageId _pageId;
  BlocBloc _bloc;
  DataCenter _data;

  int _currentSection;
  PageController _controller;
  final _signInKey = GlobalKey<FormState>();
  final _createAccountKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _pageId = PageId.SignIn;
    _data = DataCenter.instance;
    _bloc = DataCenter.userAuthBloc;
    _currentSection = 0; // SignIn = 0 , Create Account = 1;
    _controller = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Utils.backgroundColor,
      body: SafeArea(
        child: BlocBuilder<BlocBloc, BlocState>(
            bloc: _bloc,
            builder: (context, state) {
              return BlocListener<BlocBloc, BlocState>(
                bloc: _bloc,
                listener: (context, state) {
                  if (state is Ok && state.pageId == _pageId) {
                    Navigator.pushNamed(context, '/');
                  }
                },
                child: Column(
                  children: [
                    _topper(),
                    Padding(padding: EdgeInsets.all(16.0)),
                    state is Loading && state.pageId == _pageId
                        ? Expanded(child: _loading())
                        : Expanded(
                            child: PageView(
                              controller: _controller,
                              children: [
                                _logInSection(),
                                _createAccountSection(),
                              ],
                              onPageChanged: (index) {
                                setState(() {
                                  _currentSection = index;
                                });
                              },
                            ),
                          ),
                    state is Error && state.pageId == _pageId
                        ? _error()
                        : Container()
                  ],
                ),
              );
            }),
      ),
    );
  }

  Widget _topper() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(5.0),
          bottomLeft: Radius.circular(5.0),
        ),
        color: const Color(0xff20657d),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: _handleBackClicked,
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
          SetionTopper(
              title:
                  _currentSection == 0 ? "log in".tr() : "create account".tr()),
        ],
      ),
    );
  }

  Widget _logInSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
          key: _signInKey,
          child: ListView(
            children: [
              _daFieldContainer('email'.tr(), TextInputType.emailAddress,
                  (value) {
                if (isEmail(value))
                  return null;
                else
                  return "ENTER a valid email address".tr();
              }),
              Padding(padding: EdgeInsets.all(16.0)),
              _daFieldContainer(
                'password'.tr(),
                TextInputType.visiblePassword,
                (value) {
                  if (isLength(value, 6))
                    return null;
                  else
                    return "Enter at least 6 Characters".tr();
                },
                hide: true,
              ),
              Padding(padding: EdgeInsets.all(16.0)),
              Container(
                child: _btn("log in".tr(), () {
                  if (_signInKey.currentState.validate()) {
                    _handleSubmit();
                  }
                }),
              ),
              Center(child: _forgetPassword()),
              Padding(padding: EdgeInsets.all(16.0)),
              _googleBtn(),
              Padding(padding: EdgeInsets.all(16.0)),
              Center(
                child: GestureDetector(
                  onTap: _handleSwitchSections,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'create account'.tr(),
                      style: TextStyle(
                        fontFamily: 'din_next',
                        fontSize: 16,
                        color: const Color(0xff20657d),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  Widget _googleBtn() {
    return GestureDetector(
      onTap: _handleSignWithGoogle,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          width: 228.0,
          height: 45.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2.0),
            color: const Color(0xffffffff),
          ),
          child: Row(
            children: [
              Padding(padding: EdgeInsets.all(4.0)),
              Text(
                "Sign In WITH GOOGLE".tr(),
                style: TextStyle(
                  fontFamily: 'din_next',
                  fontSize: 15,
                  color: const Color(0xff707070),
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.left,
              ),
              Expanded(child: Container()),
              SvgPicture.asset(
                "assets/icons/google.svg",
                width: 20,
                height: 20,
              ),
              Padding(padding: EdgeInsets.all(4.0)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _forgetPassword() {
    return GestureDetector(
      onTap: _handleForgetPassword,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "DID YOU FORGET PASSWORD".tr(),
          style: TextStyle(
            fontFamily: 'din_next',
            fontSize: 13,
            color: const Color(0xff707070),
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }

  Widget _btn(value, Function() submit) {
    return Align(
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: submit,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            width: 228.0,
            height: 45.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: const Color(0xff20657d),
            ),
            child: Center(
              child: Text(
                value,
                style: TextStyle(
                  fontFamily: 'din_next',
                  fontSize: 13,
                  color: const Color(0xffffffff),
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _createAccountSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
          key: _createAccountKey,
          child: ListView(
            children: [
              _daFieldContainer('name'.tr(), TextInputType.name, (value) {
                if (!isLength(value, 6))
                  return "Enter at least 6 Characters".tr();
                return null;
              }),
              Padding(padding: EdgeInsets.all(16.0)),
              _daFieldContainer('email'.tr(), TextInputType.emailAddress,
                  (value) {
                if (!isEmail(value)) return "Enter a valid email address".tr();
                return null;
              }),
              Padding(padding: EdgeInsets.all(16.0)),
              _daFieldContainer(
                'password'.tr(),
                TextInputType.visiblePassword,
                (value) {
                  if (!isLength(value, 6))
                    return "Enter at least 6 Characters".tr();
                  return null;
                },
                hide: true,
              ),
              Padding(padding: EdgeInsets.all(16.0)),
              _daFieldContainer(
                "conform password".tr(),
                TextInputType.visiblePassword,
                (value) {
                  if (!isLength(value, 6))
                    return "Enter at least 6 Characters".tr();

                  return null;
                },
                hide: true,
              ),
              Padding(padding: EdgeInsets.all(16.0)),
              Container(
                child: _btn('create account'.tr(), () {
                  if (_createAccountKey.currentState.validate()) {
                    _handleSubmit();
                  }
                }),
              ),
              Padding(padding: EdgeInsets.all(4.0)),
              _googleBtn(),
              Padding(padding: EdgeInsets.all(8.0)),
              Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'if you got an account'.tr(),
                    style: TextStyle(
                      fontFamily: 'din_next',
                      fontSize: 16,
                      color: const Color(0xff707070),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  GestureDetector(
                    onTap: _handleSwitchSections,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'log in'.tr(),
                        style: TextStyle(
                          fontFamily: 'din_next',
                          fontSize: 16,
                          color: const Color(0xff20657d),
                          fontWeight: FontWeight.w700,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
              )),
            ],
          )),
    );
  }

  Widget _daFieldContainer(hintText, inputType, Function(String) validator,
      {hide = false}) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 40.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: const Color(0xffffffff),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 8, left: 8.0, bottom: 1.0),
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
                  fontSize: 15,
                  color: const Color(0xff20657d),
                  fontWeight: FontWeight.w700,
                ),
              ),
              obscureText: hide,
              keyboardType: inputType,
              style: TextStyle(
                fontFamily: 'din_next',
                fontSize: 15,
                color: const Color(0xff20657d),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
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
            // TODO: error message?
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
            onTap: _handleSubmit,
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

  _handleForgetPassword() {
    // TODO: go to the website
  }

  _handleSubmit() {
    if (_currentSection == 0)
      _bloc.add(LogIn());
    else
      _bloc.add(CreateAccount());
  }

  _handleSignWithGoogle() {
    // TODO: sign in with google
  }

  _handleBackClicked() {
    Navigator.pop(context);
  }

  _handleSwitchSections() {
    _controller.jumpToPage(_currentSection == 0 ? 1 : 0);
  }
}
