import 'package:hive/hive.dart';

class AuthDb {
  static const String authBoxName = "authBox";

  static const String accessTokenKey = "accessTokenKey";
  static const String expireKey = "expireKey";
  static const String putDatetimeKey = "putDatetimeKey";
  static const String rememberKey = "rememberKey";
  static const String userNameKey = "userNameKey";

  static Future<void> putAuthData({required String? token, required int? expireInSec, required bool? isRemember, required String? user}) async {
    final authBox = await Hive.openBox(authBoxName);
    authBox.put(accessTokenKey, token);
    authBox.put(expireKey, expireInSec);
    authBox.put(putDatetimeKey, DateTime.now());
    authBox.put(rememberKey, isRemember);
    authBox.put(userNameKey, user);
  }

  static Future<String?> fetchUserInfo()async{
    final authBox = await Hive.openBox(authBoxName);
    final String? user = authBox.get(userNameKey);
    return user;
  }

  static Future<bool?> fetchRemember()async{
    final authBox = await Hive.openBox(authBoxName);
    final bool? isRemember = authBox.get(rememberKey);
    return isRemember;
  }

  static Future<String?> fetchAccessToken() async {
    final authBox = await Hive.openBox(authBoxName);
    final String? accessToken = authBox.get(accessTokenKey);
    final int? expireInSec = authBox.get(expireKey);
    final DateTime? putDatetime = authBox.get(putDatetimeKey);
    if(expireInSec == null || putDatetime == null){
      return null;
    }
    final DateTime expireDatetime = putDatetime.add(Duration(seconds: expireInSec));
    final DateTime currentDatetime = DateTime.now();
    if (expireDatetime.isAfter(currentDatetime)) {
      return accessToken;
    } else {
      await authBox.delete(accessTokenKey);
      return null;
    }
  }

  static Future<void> deleteAuthData()async{
    final authBox = await Hive.openBox(authBoxName);
    await authBox.clear();
  }

}
