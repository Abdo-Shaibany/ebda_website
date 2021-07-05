import 'dart:io';

import "package:flutter/material.dart";
import 'package:permission_handler/permission_handler.dart';

class Utils {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  static Color backgroundColor = fromHex('#F3F3F3');

  static Future<bool> checkPermission(context) async {
    if (TargetPlatform.android == TargetPlatform.android) {
      final status = await Permission.storage.status;
      bool canPass = status == PermissionStatus.granted;
      while (!canPass) {
        final result = await Permission.storage.request();
        if (result == PermissionStatus.granted) {
          return true;
        }
      }

      return true;
    } else {
      // TODO: iOS implemention
      return true;
    }
  }

  static Future<String> getDirectory() async {
    String localPath = "/storage/emulated/0/Downloader";

    final savedDir = Directory(localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }

    return localPath;
  }
}
