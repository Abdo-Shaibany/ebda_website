import 'package:flutter/material.dart';

class CommentModel {
  final String commentId;
  final String user;
  final String comment;

  CommentModel({
    @required this.commentId,
    @required this.user,
    @required this.comment,
  });
}
