/// theme : 0
/// locale : null

class Profile {
  Profile({
    int? theme,
    dynamic locale,
  }) {
    _theme = theme;
    _locale = locale;
  }

  Profile.fromJson(dynamic json) {
    _theme = json['theme'];
    _locale = json['locale'];
  }
  int? _theme;
  dynamic _locale;
  Profile copyWith({
    int? theme,
    dynamic locale,
  }) =>
      Profile(
        theme: theme ?? _theme,
        locale: locale ?? _locale,
      );
  int? get theme => _theme;
  dynamic get locale => _locale;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['theme'] = _theme;
    map['locale'] = _locale;
    return map;
  }
}
