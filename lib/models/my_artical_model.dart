import 'package:flutter/material.dart';

class MyArticalModel {
  final String postId;
  final String postNo;
  final String title;
  final String views;
  final String date;
  final String state;
  MyArticalModel({
    @required this.postId,
    @required this.postNo,
    @required this.title,
    @required this.views,
    @required this.date,
    @required this.state,
  });
}
