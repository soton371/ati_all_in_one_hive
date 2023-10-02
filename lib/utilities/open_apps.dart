import 'dart:io';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:native_flutter_downloader/native_flutter_downloader.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

// add open apps
Future<bool> openApps(String id, String url) async {
  if (url.isEmpty) {
    //add for If there is a play store but not install then this app redirect play store or open apps
    await LaunchApp.openApp(
      androidPackageName: id,
    );
    return true;
  } else {
    // for download
    checkDownload(url);
    return false;
  }
}
// end open apps

Future<String> downloadFilePath() async {
  Directory? externalDir = await getExternalStorageDirectory();
  if (externalDir == null) {
    debugPrint("externalDir: null");
    return '';
  } else {
    return externalDir.path;
  }
}

Future<void> checkDownload(String url) async {
  const permission = Permission.storage;
  final status = await permission.status;
  debugPrint('>>>Status $status');
  downloadApk(url);
  if (status != PermissionStatus.granted) {
    await permission.request();
    if (await permission.status.isGranted) {
      downloadApk(url);
    } else if (await permission.status.isDenied) {
      //show dialog
    } else {
      await permission.request();
    }
    debugPrint('>>> ${await permission.status}');
  }
}

Future<void> downloadApk(String url) async {
  String savePath = (await downloadFilePath());
  final savedDir = Directory(savePath);
  if (!savedDir.existsSync()) {
    await savedDir.create();
  }
  // check apk already downloaded
  String fileName = url.split('/').last.trim();
  String fileDir = '$savePath/$fileName';
  List files = savedDir.listSync();
  bool fileHas = false;
  for (var element in files) {
    if (element.toString() == "File: '$fileDir'") {
      fileHas = true;
    }
  }

  if (fileHas) {
    //for install alert
    await OpenFilex.open(fileDir);
  } else {
    //download for app
    await NativeFlutterDownloader.download(
      url,
      fileName: fileName,
      savedFilePath: savePath,
    );

  }
}
//end download apk


