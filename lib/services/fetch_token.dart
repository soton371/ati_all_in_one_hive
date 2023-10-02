import 'package:ati_all_in_one_hive/configs/my_urls.dart';
import 'package:ati_all_in_one_hive/models/token_mod.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<TokenModel> fetchToken() async {
  debugPrint("fetchToken api");
  final url = Uri.parse(MyUrls.token);
  final headers = {
    'Content-Type': 'application/x-www-form-urlencoded',
  };
  final payload = {"username": "ati-user", "password": "ati123", "grant_type": "password", "client_id": "ati-client-id"};
  try {
    final response = await http.post(url, headers: headers, body: payload);
    if (response.statusCode == 200) {
      final tokenModel = tokenModelFromJson(response.body);
      debugPrint("fetchToken response.statusCode: ${response.statusCode}");
      return tokenModel;
    } else {
      final tokenModel = tokenModelFromJson(response.body);
      debugPrint("fetchToken response.statusCode: ${response.statusCode}");
      return tokenModel;
    }
  } catch (e) {
    final tokenModel = TokenModel();
    tokenModel.errorDescription = "Something went wrong";
    debugPrint("fetchToken e: $e");
    return tokenModel;
  }
}
