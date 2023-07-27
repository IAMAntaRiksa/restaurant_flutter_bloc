import 'dart:convert';
import 'package:flutter_caffe_ku/core/models/auth/login_model.dart';
import 'package:flutter_caffe_ku/core/utils/global/shared_manager.dart';
import 'package:flutter_caffe_ku/injector.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenUtils {
  final String _token = "token";

  Future<void> saveTokenUser(AuthRespponseModel model) async {
    final shared = SharedManager<String>();
    final res = await shared.store(_token, jsonEncode(model.toJson()));
    return res;
  }

  Future<String> getTokenUser() async {
    final shared = SharedManager<String>();
    final tokens = await shared.read(_token) ?? "";
    final authData = AuthRespponseModel.fromJson(jsonDecode(tokens));
    return authData.jwt ?? '';
  }

  Future<int> getUserId() async {
    final shared = SharedManager<String>();
    final authJson = await shared.read(_token) ?? "";
    final authData = AuthRespponseModel.fromJson(jsonDecode(authJson));
    return authData.user!.id;
  }

  Future<bool> isLogin() async {
    final shared = SharedManager<String>();
    final tokens = await shared.read(_token) ?? "";
    return tokens.isNotEmpty;
  }

  Future<bool> removeToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.remove(_token);
  }
}

final checkTokken = locator<TokenUtils>();
