// To parse this JSON data, do
//
//     final tokenModel = tokenModelFromJson(jsonString);

import 'dart:convert';

TokenModel tokenModelFromJson(String str) => TokenModel.fromJson(json.decode(str));

String tokenModelToJson(TokenModel data) => json.encode(data.toJson());

class TokenModel {
  String? accessToken;
  int? expiresIn;
  int? refreshExpiresIn;
  String? refreshToken;
  String? tokenType;
  int? notBeforePolicy;
  String? sessionState;
  String? scope;
  String? error;
  String? errorDescription;

  TokenModel({
    this.accessToken,
    this.expiresIn,
    this.refreshExpiresIn,
    this.refreshToken,
    this.tokenType,
    this.notBeforePolicy,
    this.sessionState,
    this.scope,
    this.error,
    this.errorDescription,
  });

  factory TokenModel.fromJson(Map<String, dynamic> json) => TokenModel(
    accessToken: json["access_token"],
    expiresIn: json["expires_in"],
    refreshExpiresIn: json["refresh_expires_in"],
    refreshToken: json["refresh_token"],
    tokenType: json["token_type"],
    notBeforePolicy: json["not-before-policy"],
    sessionState: json["session_state"],
    scope: json["scope"],
    error: json["error"],
    errorDescription: json["error_description"],
  );

  Map<String, dynamic> toJson() => {
    "access_token": accessToken,
    "expires_in": expiresIn,
    "refresh_expires_in": refreshExpiresIn,
    "refresh_token": refreshToken,
    "token_type": tokenType,
    "not-before-policy": notBeforePolicy,
    "session_state": sessionState,
    "scope": scope,
    "error": error,
    "error_description": errorDescription,
  };
}
