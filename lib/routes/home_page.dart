import 'package:flutter/material.dart';
import 'package:ski_app_re/generated/l10n.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum Users {current, anonymous}


class HomeRoute extends StatefulWidget {
  const HomeRoute({Key? key}) : super(key: key);

  @override
  State<HomeRoute> createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/backgrounds/b1.png"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(.4), BlendMode.dstATop)
          )
        ),
        child: CustomScrollView(
          slivers: [
            _sliverAppBar
          ],
        ),
      )
    );
  }

  Widget get _sliverAppBar{
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      actions: <Widget>[
        IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              "assets/images/funcs/scan.svg",
              semanticsLabel: S.of(context).scan,
              color: null, // TODO 根据主题切换颜色
            ))
      ],
      expandedHeight: 300,
      flexibleSpace: Container(
        width: double.infinity,
        color: Colors.blue,
        child: SafeArea(
          child: Column(
            children: [
              _account
            ],
          ),
        ),
      ),
    );
  }


  Widget get _account{
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      width: double.infinity,
      height: 100,
      color: Colors.red,
      child: Column(
        children: [
          Row(
            children: [
              PopupMenuButton(
                onSelected: (value){

                },
                itemBuilder: (content) => [
                  _buildPopupMenuItem('列奥那多是勇者', Users.current.index),
                  _buildPopupMenuItem('Upload', Users.anonymous.index),
                ]
              )
            ],
          )
        ],
      ),
    );
  }

  PopupMenuItem _buildPopupMenuItem(String title, int position) {
    return PopupMenuItem(
      value: position,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(Icons.person),
          Text(title)
        ],
      )
    );
  }
}
