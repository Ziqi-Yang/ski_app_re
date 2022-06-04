import 'package:flutter/material.dart';

class AccountRoute extends StatefulWidget {
  const AccountRoute({Key? key}) : super(key: key);

  @override
  State<AccountRoute> createState() => _AccountRouteState();
}

class _AccountRouteState extends State<AccountRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text("Account"),
      ),
    );
  }
}
