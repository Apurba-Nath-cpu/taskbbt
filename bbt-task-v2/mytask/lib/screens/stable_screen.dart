import 'dart:async';

import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class StableScreen extends StatefulWidget {
  const StableScreen({Key? key}) : super(key: key);

  @override
  StableScreenState createState() => StableScreenState();
}

class StableScreenState extends State<StableScreen> {
  bool updateRequired = false;
  String? appVersion;
  double progress = 0.0;
  int status = 0;

  @override
  void initState() {
    super.initState();
    getAppVersion();
  }

  void getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appVersion = packageInfo.version;
    print('pubspec appVersion: $appVersion');

    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              "MyTask - V2",
            ),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: Text(
                "App has the latest version",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Center(
              child: Text("Current App version... $appVersion"),
            ),
          ],
        ),
      ),
    );
  }
}
