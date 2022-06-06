/// 全局变量: Global

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ski_app_re/models/profile.dart';

List<ThemeData> _themes = <ThemeData>[
  // light theme
  ThemeData(
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        onPrimary: Colors.black,
      ),
      useMaterial3: true
  ),
  // dark theme
  ThemeData(
      brightness: Brightness.dark,
      bottomAppBarColor: Colors.black,
      useMaterial3: true
  ),
];

class Global{
  static late SharedPreferences _prefs;
  static Profile profile = Profile();
  // 是否为release版
  static bool get isRelease => const bool.fromEnvironment("dart.vm.product");
  // 可选的主题列表
  static List<ThemeData> get themes => _themes;


  //初始化全局信息，会在APP启动时执行
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    _prefs = await SharedPreferences.getInstance();
    var _profile = _prefs.getString("profile");
    if (_profile != null) {
      try {
        profile = Profile.fromJson(jsonDecode(_profile));
      } catch (e) {
        print(e);
      }
    } else {
      profile = Profile()..theme = 0;
    }
  }


  // 持久化Profile信息
  static saveProfile() =>
      _prefs.setString("profile", jsonEncode(profile.toJson()));
}
