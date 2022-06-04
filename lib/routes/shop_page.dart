import 'package:flutter/material.dart';

class ShopRoute extends StatefulWidget {
  const ShopRoute({Key? key}) : super(key: key);

  @override
  State<ShopRoute> createState() => _ShopRouteState();
}

class _ShopRouteState extends State<ShopRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text("Shop"),
      ),
    );
  }
}
