import 'dart:async';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:package_info_plus/package_info_plus.dart';

Future<bool> checkForAppUpdates() async {
  final remoteConfig = FirebaseRemoteConfig.instance;
  await remoteConfig.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(seconds: 10),
    minimumFetchInterval: const Duration(seconds: 5),
  ));
  try {
    await remoteConfig.fetchAndActivate();
  } catch (e) {
    print("Error fetching remote config: $e");
    return false;
  }
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String appVersion = remoteConfig.getString("app_version");
  bool isUpdateNeeded = false;
  if (appVersion.isNotEmpty && packageInfo.version.isNotEmpty) {
    print('$appVersion remote version');
    print('${packageInfo.version} current version');
    final List<int> enforcedVersion =
        appVersion.split('.').map((String number) {
      return int.tryParse(number) ?? 0;
    }).toList();
    final List<int> currentVersion =
        packageInfo.version.split('.').map((String number) {
      return int.tryParse(number) ?? 1;
    }).toList();
    for (var i = 0; i <= 2; i++) {
      if (enforcedVersion[i] > currentVersion[i]) {
        isUpdateNeeded = true;
        break;
      } else if (enforcedVersion[i] < currentVersion[i]) {
        isUpdateNeeded = false;
        break;
      }
    }
  }

  return isUpdateNeeded;
}
