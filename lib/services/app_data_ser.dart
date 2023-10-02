import 'package:ati_all_in_one_hive/configs/my_urls.dart';
import 'package:ati_all_in_one_hive/models/app_data_mod.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<ObjResponse?> callAppData() async {
  debugPrint("callAppData api");
  final Uri url = Uri.parse(MyUrls.appData);
  try {
    final response = await http.post(url);
    if (response.statusCode == 200) {
      final appDataModel = appDataModelFromJson(response.body);
      final appData = appDataModel.objResponse;
      if (appDataModel.statusCode == 200) {
        return appData;
      } else {
        debugPrint("callAppData appDataModel.statusCode: ${appDataModel.statusCode}");
        return null;
      }
    } else {
      debugPrint("callAppData response.statusCode: ${response.statusCode}");
      return null;
    }
  } catch (e) {
    debugPrint("callAppData e: $e");
    return null;
  }
}
