import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ski_app_re/generated/l10n.dart';
import 'package:provider/provider.dart';
import 'package:ski_app_re/common/global.dart';
import 'package:ski_app_re/routes/tab_navigator.dart';
import 'package:ski_app_re/states/profile.dart';
import 'package:ski_app_re/routes/account_page.dart';
import 'package:ski_app_re/routes/history_page.dart';
import 'package:ski_app_re/routes/home_page.dart';
import 'package:ski_app_re/routes/monents_page.dart';
import 'package:ski_app_re/routes/shop_page.dart';


void main() => Global.init().then((e) => runApp(const SkiApp()));


class SkiApp extends StatelessWidget {
  const SkiApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeModel()),
        ChangeNotifierProvider(create: (_) => UserModel()),
        ChangeNotifierProvider(create: (_) => LocaleModel()),
      ],
      child: Consumer2<ThemeModel, LocaleModel>(
        builder: (BuildContext context, ThemeModel themeModel,LocaleModel localeModel, child){
          return MaterialApp(
            theme: ThemeData(
              primarySwatch: themeModel.theme
            ),
            onGenerateTitle: (context){
              return S.of(context).appTitle;
            },
            locale: localeModel.getLocale(),
            localizationsDelegates: const [
              // 本地化的代理类
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              S.delegate
            ],
            supportedLocales: const [
              Locale('zh', 'CN'), // 中文简
              Locale('en', 'US'), // 美国英语
              //其它Locales
            ],
            localeResolutionCallback: (localeLang, supportedLocales) {
              if (localeModel.getLocale() != null) {
                //如果已经选定语言，则不跟随系统
                return localeModel.getLocale();
              } else {
                //跟随系统
                Locale locale;
                if (supportedLocales.contains(localeLang)) {
                  locale= localeLang!;
                } else {
                  //如果系统语言不是中文简体或美国英语，则默认使用美国英语
                  locale= const Locale('en', 'US');
                }
                return locale;
              }
            },
            home: TabNavigator(),
            routes: {
              "home": (context) => const HomeRoute(),
              "history": (context) => const HistoryRoute(),
              "moments": (context) => const MomentsRoute(),
              "shop": (context) => const ShopRoute(),
              "user": (context) => const AccountRoute()
            },

            // initialRoute: "home",
            // onGenerateRoute: (RouteSettings settings){
            //   String? routeName = settings.name;
            //   print(routeName);
            // },

          );
        },
      ),
    );
  }
}

