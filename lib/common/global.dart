import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ski_app_re/models/user.dart';
import 'package:ski_app_re/models/profile.dart';

const _themes = <MaterialColor>[
  Colors.blue,
  Colors.cyan,
];

class Global{
  static late SharedPreferences _prefs;
  static Profile profile = Profile();
  // 是否为release版
  static bool get isRelease => const bool.fromEnvironment("dart.vm.product");
  // 可选的主题列表
  static List<MaterialColor> get themes => _themes;


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

class ProfileChangeNotifier extends ChangeNotifier {
  Profile get _profile => Global.profile;

  @override
  void notifyListeners() {
    Global.saveProfile(); //保存Profile变更
    super.notifyListeners(); //通知依赖的Widget更新
  }
}

class UserModel extends ProfileChangeNotifier {
  User? get user => _profile.user;

  // APP是否登录(如果有用户信息，则证明登录过)
  bool get isLogin => user != null;

  //用户信息发生变化，更新用户信息并通知依赖它的子孙Widgets更新
  set user(User? user) {
    if (user?.login != _profile.user?.login) {
      _profile.user = user;
      notifyListeners();
    }
  }
}

class ThemeModel extends ProfileChangeNotifier {
  MaterialColor get theme => Global.themes[_profile.theme];

  // 主题改变后，通知其依赖项，新主题会立即生效
  set theme(MaterialColor color) {
    if (color != theme) {
      _profile.theme = Global.themes.indexOf(color);
      notifyListeners();
    }
  }
}

class LocaleModel extends ProfileChangeNotifier {
  // 获取当前用户的APP语言配置Locale类，如果为null，则语言跟随系统语言
  Locale? getLocale() {
    if (_profile.locale == null) return null;
    var t = _profile.locale!.split("_");
    return Locale(t[0], t[1]);
  }

  // 获取当前Locale的字符串表示, 或者null
  String? get locale => _profile.locale;

  // 用户改变APP语言后，通知依赖项更新，新语言会立即生效
  set locale(String? locale) {
    if (locale != _profile.locale) {
      _profile.locale = locale;
      notifyListeners();
    }
  }
}