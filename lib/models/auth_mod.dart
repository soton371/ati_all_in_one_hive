// To parse this JSON data, do
//
//     final authModel = authModelFromJson(jsonString);

import 'dart:convert';

AuthModel authModelFromJson(String str) => AuthModel.fromJson(json.decode(str));

String authModelToJson(AuthModel data) => json.encode(data.toJson());

class AuthModel {
  String? message;
  int? statusCode;
  ObjResponse? objResponse;

  AuthModel({
    this.message,
    this.statusCode,
    this.objResponse,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
    message: json["message"],
    statusCode: json["statusCode"],
    objResponse: json["objResponse"] == null ? null : ObjResponse.fromJson(json["objResponse"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "statusCode": statusCode,
    "objResponse": objResponse?.toJson(),
  };
}

class ObjResponse {
  int? sausersId;
  String? usersName;
  String? desgtonNm;
  String? deprtmnNm;
  String? usermobNo;
  String? userEmail;
  String? userTypNo;
  String? sessionId;
  String? parentId;
  String? areaCode;
  String? userCode;
  int? versionCode;

  ObjResponse({
    this.sausersId,
    this.usersName,
    this.desgtonNm,
    this.deprtmnNm,
    this.usermobNo,
    this.userEmail,
    this.userTypNo,
    this.sessionId,
    this.parentId,
    this.areaCode,
    this.userCode,
    this.versionCode,
  });

  factory ObjResponse.fromJson(Map<String, dynamic> json) => ObjResponse(
    sausersId: json["sausersId"],
    usersName: json["usersName"],
    desgtonNm: json["desgtonNm"],
    deprtmnNm: json["deprtmnNm"],
    usermobNo: json["usermobNo"],
    userEmail: json["userEmail"],
    userTypNo: json["userTypNo"],
    sessionId: json["sessionId"],
    parentId: json["parentId"],
    areaCode: json["areaCode"],
    userCode: json["userCode"],
    versionCode: json["versionCode"],
  );

  Map<String, dynamic> toJson() => {
    "sausersId": sausersId,
    "usersName": usersName,
    "desgtonNm": desgtonNm,
    "deprtmnNm": deprtmnNm,
    "usermobNo": usermobNo,
    "userEmail": userEmail,
    "userTypNo": userTypNo,
    "sessionId": sessionId,
    "parentId": parentId,
    "areaCode": areaCode,
    "userCode": userCode,
    "versionCode": versionCode,
  };
}
