import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:website/helpers/utils.dart';
import 'package:website/models/journals_model.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

class JournalItemComponent extends StatelessWidget {
  final Journal model;
  const JournalItemComponent({
    Key key,
    @required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 338.0,
          height: 151.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: CachedNetworkImage(
                    imageUrl: model.fullImageUrl,
                    placeholder: (context, url) => Container(
                      alignment: Alignment.center,
                      child: Container(
                        color: Colors.white,
                        child: Image.asset("assets/icons/logo.png"),
                      ),
                      width: 20,
                      height: 20,
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: 338.0,
                  height: 26.0,
                  child: Row(
                    children: [
                      Padding(padding: EdgeInsets.all(8.0)),
                      Text(
                        model.verNumber,
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
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () => _handleClick(context),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(5.0),
                          bottomLeft: Radius.circular(5.0),
                        ),
                        color: const Color(0x80ffffff),
                      ),
                      child: Text(
                        'download'.tr(),
                        style: TextStyle(
                          fontFamily: 'din_next',
                          fontSize: 15,
                          color: const Color(0xff20657d),
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(padding: EdgeInsets.all(4.0)),
        Row(
          children: [
            Padding(padding: EdgeInsets.all(2.0)),
            SvgPicture.asset("assets/icons/eye.svg", width: 12, height: 12),
            Padding(padding: EdgeInsets.all(2.0)),
            daText(model.viewCount),
            Padding(padding: EdgeInsets.all(4.0)),
            SvgPicture.asset(
              "assets/icons/download.svg",
              width: 12,
              height: 12,
            ),
            Padding(padding: EdgeInsets.all(2.0)),
            daText(model.downloadCount),
            Padding(padding: EdgeInsets.all(4.0)),
            SvgPicture.asset(
              "assets/icons/clock.svg",
              width: 13,
              height: 13,
            ),
            Padding(padding: EdgeInsets.all(2.0)),
            daText(DateFormat.yMMMd().format(model.createdAt).toString()),
          ],
        )
      ],
    );
  }

  Widget daText(value) {
    return Text(
      value,
      style: TextStyle(
        fontFamily: 'din_next',
        fontSize: 12,
        color: const Color(0xff707070),
        fontWeight: FontWeight.w700,
      ),
      textAlign: TextAlign.left,
    );
  }

  _handleClick(context) async {
    bool canDownload = await Utils.checkPermission(context);
    if (!canDownload) return;
    String path = await Utils.getDirectory();

    await FlutterDownloader.enqueue(
      url: model.fullPdfUrl,
      savedDir: path,
      fileName: model.pdfFile,
      showNotification: true,
      openFileFromNotification: true,
    );
  }
}
