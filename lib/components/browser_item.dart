import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:website/models/categories_model.dart';

class BrowserComponent extends StatelessWidget {
  final Category model;
  const BrowserComponent({
    Key key,
    @required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _handleOpenBrowser(context),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 50.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: 338.0,
                height: 26.0,
                child: Row(
                  children: [
                    Padding(padding: EdgeInsets.all(8.0)),
                    Text(
                      model.categoryNameAr,
                      style: TextStyle(
                        fontFamily: 'din_next',
                        fontSize: 15,
                        color: const Color(0xff20657d),
                        fontWeight: FontWeight.w700,
                        shadows: [
                          Shadow(
                            color: const Color(0x29000000),
                            offset: Offset(0, 1),
                            blurRadius: 1,
                          )
                        ],
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(5.0),
                    bottomLeft: Radius.circular(5.0),
                  ),
                  color: const Color(0x80ffffff),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _handleOpenBrowser(context) {
    Navigator.pushNamed(context, '/da_category',
        arguments: [model.categoryNameAr]);
  }
}


// Positioned.fill(
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(5.0),
//                 child: CachedNetworkImage(
//                   imageUrl: model.,
//                   placeholder: (context, url) => Container(
//                     alignment: Alignment.center,
//                     child: Container(
//                       color: Colors.white,
//                       child: Image.asset("assets/icons/logo.png"),
//                     ),
//                     width: 20,
//                     height: 20,
//                   ),
//                   errorWidget: (context, url, error) => Icon(Icons.error),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),