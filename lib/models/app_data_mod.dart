// To parse this JSON data, do
//
//     final appDataModel = appDataModelFromJson(jsonString);

import 'dart:convert';

AppDataModel appDataModelFromJson(String str) => AppDataModel.fromJson(json.decode(str));

String appDataModelToJson(AppDataModel data) => json.encode(data.toJson());

class AppDataModel {
  DateTime? timestamp;
  int? status;
  String? error;
  String? message;
  String? path;
  int? statusCode;
  ObjResponse? objResponse;

  AppDataModel({
    this.timestamp,
    this.status,
    this.error,
    this.message,
    this.path,
    this.statusCode,
    this.objResponse,
  });

  factory AppDataModel.fromJson(Map<String, dynamic> json) => AppDataModel(
    timestamp: json["timestamp"] == null ? null : DateTime.parse(json["timestamp"]),
    status: json["status"],
    error: json["error"],
    message: json["message"],
    path: json["path"],
    statusCode: json["statusCode"],
    objResponse: json["objResponse"] == null ? null : ObjResponse.fromJson(json["objResponse"]),
  );

  Map<String, dynamic> toJson() => {
    "timestamp": timestamp?.toIso8601String(),
    "status": status,
    "error": error,
    "message": message,
    "path": path,
    "statusCode": statusCode,
    "objResponse": objResponse?.toJson(),
  };
}

class ObjResponse {
  int? appServerVersion;
  int? userActiveFlag;

  ObjResponse({
    this.appServerVersion,
    this.userActiveFlag,
  });

  factory ObjResponse.fromJson(Map<String, dynamic> json) => ObjResponse(
    appServerVersion: json["appServerVersion"],
    userActiveFlag: json["userActiveFlag"],
  );

  Map<String, dynamic> toJson() => {
    "appServerVersion": appServerVersion,
    "userActiveFlag": userActiveFlag,
  };
}
