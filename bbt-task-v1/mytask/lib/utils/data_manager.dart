import 'package:flutter_dotenv/flutter_dotenv.dart';

class DataManager {
  static String remoteUrl = dotenv.env['REMOTE_URL']!;
}