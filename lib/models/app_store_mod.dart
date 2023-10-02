import 'package:hive/hive.dart';
import 'dart:convert';
part 'app_store_mod.g.dart';

List<AppStoreModel> appStoreModelFromJson(String str) => List<AppStoreModel>.from(json.decode(str).map((x) => AppStoreModel.fromJson(x)));
String appStoreModelToJson(List<AppStoreModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@HiveType(typeId: 0)
class AppStoreModel extends HiveObject{
  AppStoreModel({this.appOrder, this.name, this.appId, this.img, this.url, this.appInstalled, this.progress, this.isChecked});

  @HiveField(0)
  int? appOrder;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? appId;
  @HiveField(3)
  String? img;
  @HiveField(4)
  String? url;
  @HiveField(5)
  String? appInstalled;
  @HiveField(6)
  int? progress;
  @HiveField(7)
  bool? isChecked;

  factory AppStoreModel.fromJson(Map<String, dynamic> json) => AppStoreModel(
    appOrder: json["appOrder"],
    name: json["name"],
    appId: json["appId"],
    img: json["img"],
    url: json["url"],
    appInstalled: json["appInstalled"],
    progress: json["progress"],
    isChecked: json["isChecked"],
  );

  Map<String, dynamic> toJson() => {
    "appOrder": appOrder,
    "name": name,
    "appId": appId,
    "img": img,
    "url": url,
    "appInstalled": appInstalled,
    "progress": progress,
    "isChecked": isChecked,
  };
}
