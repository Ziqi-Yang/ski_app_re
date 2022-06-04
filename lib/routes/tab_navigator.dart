import 'package:flutter/material.dart';
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
  int _currentIndex = 3;
  final pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // 对于有透明的bottomNavigatorBar有用, 拓展到下方
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: (index){
          setState(() {
            _currentIndex = index;
          });
        },
        children: const [
          HistoryRoute(),
          MomentsRoute(),
          // HomeRoute(),
          // ShopRoute(),
          // AccountRoute()
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/images/bottom_nav.png"),
            fit: BoxFit.cover
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.add), label: 'title'),
            BottomNavigationBarItem(icon: Icon(Icons.remove), label: 'title'),
          ],
        ),
      ),
    );
  }
}
