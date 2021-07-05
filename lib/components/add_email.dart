import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class AddEmailMessage extends StatelessWidget {
  const AddEmailMessage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: 200.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: const Color(0xfaf5f3f6),
          boxShadow: [
            BoxShadow(
              color: const Color(0x26000000),
              offset: Offset(0, 3),
              blurRadius: 6,
            ),
          ],
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  "SUBSCRIBE TO RSS FEEDS".tr(),
                  style: TextStyle(
                    fontFamily: 'din_next',
                    fontSize: 25,
                    color: const Color(0xffd7536c),
                  ),
                  textAlign: TextAlign.center,
                ),
                _daFieldContainer(
                    context, '', TextInputType.text, (value) => null),
                _btn(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _daFieldContainer(
      context, hintText, inputType, Function(String) validator,
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

  Widget _btn(context) {
    return GestureDetector(
      onTap: () => {
        Navigator.pop(context, true),
      },
      child: Container(
        width: 93.0,
        height: 30.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: const Color(0xff3b5a9a),
          border: Border.all(width: 1.5, color: const Color(0xff3b5a9a)),
          boxShadow: [
            BoxShadow(
              color: const Color(0x26000000),
              offset: Offset(0, 3),
              blurRadius: 6,
            ),
          ],
        ),
        child: Center(
          child: Text(
            'Subscribe'.tr(),
            style: TextStyle(
              fontFamily: 'Ara-Hamah-Kilania',
              fontSize: 15,
              color: const Color(0xfff5f3f6),
            ),
            textAlign: TextAlign.left,
          ),
        ),
      ),
    );
  }
}
