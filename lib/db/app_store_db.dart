import 'package:ati_all_in_one_hive/models/app_store_mod.dart';
import 'package:hive/hive.dart';

class AppStoreDb {
  static const appStoreBox = "app_store_box";

  static Future<void> createAppStoreModel(AppStoreModel appStoreModel) async {
    final box = Hive.box<AppStoreModel>(appStoreBox);
    await box.put(appStoreModel.appId, appStoreModel);
  }

  static List<AppStoreModel> getAllAppStoreModels() {
    final box = Hive.box<AppStoreModel>(appStoreBox);
    return box.values.toList();
  }

  static Future<void> updateAppStoreModel(AppStoreModel appStoreModel) async {
    final box = Hive.box<AppStoreModel>(appStoreBox);
    await box.put(appStoreModel.appId, appStoreModel);
  }
}
