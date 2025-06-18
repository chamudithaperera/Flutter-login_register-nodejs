import 'dart:convert';

import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_register_nodejs/models/login_response_model.dart';

class SharedService {
  static Future<bool> isLoggedIn() async {
    var isKeyExists = await APICacheManager().isAPICacheKeyExist(
      "login_details",
    );
    return isKeyExists;
  }

  static Future<LoginResponseModel?> logindetails() async {
    var isKeyExists = await APICacheManager().isAPICacheKeyExist(
      "login_details",
    );

    if (isKeyExists) {
      var cacheData = await APICacheManager().getCacheData("login_details");
      return loginResponseJson(cacheData.syncData);
    }
  }

  static Future<void> setLoginDetails(LoginResponseModel model) async {
    APICacheDBModel cacheModel = APICacheDBModel(
      key: "login_details",
      syncData: jsonEncode(model.toJson()),
    );
    await APICacheManager().addCacheData(cacheModel);
  }

  static Future<void> logout(BuildContext context) async {
    await APICacheManager().deleteCache("login_details");
    Navigator.pushAndRemoveUntil(
      context,
      '/login' as Route<Object?>,
      (route) => false,
    );
  }
}
