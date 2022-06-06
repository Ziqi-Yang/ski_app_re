/// 用户状态: UserModel
/// App主题状态: ThemeModel
/// APP语言状态: LocaleModel

import 'package:flutter/material.dart';
import 'package:ski_app_re/common/global.dart';
import 'package:ski_app_re/models/user.dart';
import 'package:ski_app_re/models/profile.dart';


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
  int get theme => _profile.theme;

  // 主题改变后，通知其依赖项，新主题会立即生效
  set theme(int themeIndex) {
    if (themeIndex >= Global.themes.length){
      throw "themeIndex > total themes list length";
    }
    if (themeIndex != theme) {
      _profile.theme = themeIndex;
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
