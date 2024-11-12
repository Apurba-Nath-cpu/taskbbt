import 'package:flutter/material.dart';
import 'package:mytask/screens/stable_screen.dart';
import 'package:mytask/screens/update_screen.dart';
import 'package:mytask/utils/check_for_updates.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  bool updateRequired = false;
  String? appVersion;
  double progress = 0.0;
  int status = 0;

  @override
  void initState() {
    super.initState();
    checkUpdate();
  }

  void checkUpdate() async {
    updateRequired = await checkForAppUpdates();
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return updateRequired ? const UpdateScreen() : const StableScreen();
  }
}
