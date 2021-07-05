import 'package:flutter/material.dart';
import 'package:website/models/comment_model.dart';

class CommentItem extends StatelessWidget {
  final CommentModel model;
  const CommentItem({
    Key key,
    @required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      // height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2.0),
        color: const Color(0xfffcfbfc),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                model.user,
                style: TextStyle(
                  fontFamily: 'din_next',
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Padding(padding: EdgeInsets.all(4.0)),
            Text(
              model.comment,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                fontFamily: 'din_next',
                fontSize: 12,
                color: const Color(0xff707070),
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
