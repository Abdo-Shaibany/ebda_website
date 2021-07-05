import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:website/models/select_model.dart';

class SelectItem extends StatelessWidget {
  final SelectModel selectModel;
  const SelectItem({
    Key key,
    @required this.selectModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 25,
      height: 25,
      child: Row(
        children: [
          selectModel.isSelected ? _selectedContainer() : _daContainer(),
          Padding(padding: EdgeInsets.all(8.0)),
          _text(),
        ],
      ),
    );
  }

  Widget _daContainer() {
    return Container(
      width: 25.0,
      height: 25.0,
      decoration: BoxDecoration(
        color: const Color(0xffffffff),
        border: Border.all(width: 1.0, color: const Color(0xff20657d)),
      ),
    );
  }

  Widget _selectedContainer() {
    return Container(
      width: 25,
      height: 25,
      child: Stack(
        children: [
          Positioned.fill(child: _daContainer()),
          Center(
            child: SvgPicture.asset('assets/icons/check.svg'),
          )
        ],
      ),
    );
  }

  Widget _text() {
    return Text(
      selectModel.value.categoryNameAr,
      style: TextStyle(
        fontFamily: 'din_next',
        fontSize: 15,
        color: const Color(0xff707070),
      ),
    );
  }
}
