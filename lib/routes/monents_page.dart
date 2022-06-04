import 'package:flutter/material.dart';

class MomentsRoute extends StatefulWidget {
  const MomentsRoute({Key? key}) : super(key: key);

  @override
  State<MomentsRoute> createState() => _MomentsRouteState();
}

class _MomentsRouteState extends State<MomentsRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text("Moments"),
      ),
    );
  }
}
