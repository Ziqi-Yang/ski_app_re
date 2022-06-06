import 'package:flutter/material.dart';
import 'package:ski_app_re/generated/l10n.dart';
import 'package:ski_app_re/routes/account_page.dart';
import 'package:ski_app_re/routes/history_page.dart';
import 'package:ski_app_re/routes/home_page.dart';
import 'package:ski_app_re/routes/monents_page.dart';
import 'package:ski_app_re/routes/shop_page.dart';

class TabNavigator extends StatefulWidget {
  const TabNavigator({Key? key}) : super(key: key);

  @override
  State<TabNavigator> createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  int _currentIndex = 2;
  final pageController = PageController(initialPage: 2);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // 对于有透明的bottomNavigatorBar有用, 拓展到下方
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: const [
          HistoryRoute(),
          MomentsRoute(),
          HomeRoute(),
          ShopRoute(),
          AccountRoute()
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        // circle border in material 3
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(200)),
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 1,
        child: Image.asset("assets/images/logo.png", width: 50, height: 50,),
        onPressed: (){
          setState((){
            pageController.jumpToPage(2);
            _currentIndex = 2;
          });
        },
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 6,
        elevation: 3,
        // color: Colors.white,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            buildBotomItem(0, Icons.timeline_outlined, S.of(context).historyPageName),
            buildBotomItem(1, Icons.join_full_outlined, S.of(context).momentsPageName),
            buildBotomItem(-1, null, ""),
            buildBotomItem(3, Icons.shop_outlined, S.of(context).shopPageName),
            buildBotomItem(4, Icons.account_circle_outlined, S.of(context).accountPageName),
          ],
        ),
      ),
    );
  }

  // ignore: slash_for_doc_comments
  /**
   * @param selectIndex 当前选中的页面
   * @param index 每个条目对应的角标
   * @param iconData 每个条目对就的图标
   * @param title 每个条目对应的标题
   */
  buildBotomItem(int index, IconData? iconData, String title) {
    //未选中状态的样式
    TextStyle textStyle = const TextStyle(fontSize: 12.0,color: Colors.grey);
    MaterialColor iconColor = Colors.grey;
    double iconSize=20;
    EdgeInsetsGeometry padding =  const EdgeInsets.only(top: 8.0);

    if(_currentIndex == index){
      //选中状态的文字样式
      textStyle = const TextStyle(fontSize: 13.0,color: Colors.blue);
      //选中状态的按钮样式
      iconColor = Colors.blue;
      iconSize=25;
      padding =  const EdgeInsets.only(top: 6.0);
    }

    Widget padItem = SizedBox();
    if (iconData != null) {
      padItem = Padding(
        padding: padding,
        child: Container(
          // color: Colors.white,
          child: Center(
            child: Column(
              children: <Widget>[
                Icon(
                  iconData,
                  color: iconColor,
                  size: iconSize,
                ),
                Text(
                  title,
                  style: textStyle,
                )
              ],
            ),
          ),
        ),
      );
    }
    Widget item = Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          if (index != _currentIndex) {
            setState(() {
              pageController.jumpToPage(index);
              _currentIndex = index;
            });
          }
        },
        child: SizedBox(
          height: 52,
          child: padItem,
        ),
      ),
    );
    return item;
  }
}