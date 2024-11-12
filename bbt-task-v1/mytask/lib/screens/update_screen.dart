import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:mytask/utils/data_manager.dart';
import 'package:open_file/open_file.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({Key? key}) : super(key: key);

  @override
  UpdateScreenState createState() => UpdateScreenState();
}

class UpdateScreenState extends State<UpdateScreen> {
  String? currAppVersion;
  String? remoteAppVersion;
  double progress = 0.0;
  int status = 0;

  @override
  void initState() {
    super.initState();
    getCurrAppVersion();
    getRemoteAppVersion();
  }

  void getCurrAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    currAppVersion = packageInfo.version;
    print('pubspec appVersion: $currAppVersion');

    setState(() {});
  }

  void getRemoteAppVersion() async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 10),
      minimumFetchInterval: const Duration(seconds: 5),
    ));
    try {
      await remoteConfig.fetchAndActivate();
    } catch (e) {
      print("Error fetching remote config: $e");
    }
    remoteAppVersion = remoteConfig.getString("app_version");
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> installApk(String filePath) async {
    // Check if the install packages permission is granted
    if (await Permission.requestInstallPackages.isGranted) {
      final result = await OpenFile.open(filePath);
      if (result.type == ResultType.done) {
        print("Installation prompt opened.");
      } else {
        print("Failed to open installation prompt: ${result.message}");
      }
    } else {
      // Request the install packages permission
      final status = await Permission.requestInstallPackages.request();
      if (status.isGranted) {
        final result = await OpenFile.open(filePath);
        if (result.type == ResultType.done) {
          print("Installation prompt opened.");
        } else {
          print("Failed to open installation prompt: ${result.message}");
        }
      } else {
        print("Permission denied. Cannot proceed with installation.");
      }
    }
  }

  Future<void> downloadAndPromptInstall(BuildContext context,
      {String apkUrl = ''}) async {
    apkUrl = DataManager.remoteUrl;
    try {
      Directory? tempDir = await getExternalStorageDirectory();
      String apkPath = path.join(tempDir!.path, "app_updated.apk");
      print('dowloading in: $apkPath');

      // Download the APK file
      Dio dio = Dio();
      Response<dynamic> response = await dio.download(apkUrl, apkPath,
          onReceiveProgress: (received, total) {
        if (total != -1) {
          setState(() {
            progress = received / total * 100;
            status = 2;
            if (progress.toStringAsFixed(0) == '100') {
              status = 3;
            }
          });
          // print("Download progress: $progress%");
        }
      });

      await installApk(apkPath);
    } catch (e) {
      print("Error during download or installation: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Failed to download or install the update")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              "Please update your app",
            ),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 33, 33, 33),
                  borderRadius: BorderRadius.circular(
                    12,
                  ),
                ),
                child: TextButton(
                  onPressed: () async {
                    setState(() {
                      status = 1;
                    });
                    downloadAndPromptInstall(context);
                  },
                  child: Text(
                    status == 1
                        ? 'Trying to connect...'
                        : status == 2
                            ? 'Downloading...'
                            : status == 3
                                ? 'Installing...'
                                : 'Click to update',
                    style: const TextStyle(
                      color: Color.fromARGB(255, 200, 200, 200),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Center(
                child: Text("Current App version... $currAppVersion"),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child:
                    Text("Latest available App version... $remoteAppVersion"),
              ),
              const SizedBox(
                height: 80,
              ),
              status > 0
                  ? Center(
                      child: Text(progress.toStringAsFixed(1) == '100.0'
                          ? "Completed :)"
                          : "Downloading: ${progress.toStringAsFixed(1)}%"),
                    )
                  : const SizedBox.shrink(),
              const SizedBox(
                height: 40,
              ),
              status > 0
                  ? Center(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: LinearProgressIndicator(
                          value: progress / 100,
                          backgroundColor:
                              Colors.grey.shade200, // Background color
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.grey.shade800), // Progress color
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
