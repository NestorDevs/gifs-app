import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'app.dart';
import 'core/di/injection_container.dart' as di;

void main() async {
  await dotenv.load(fileName: ".env");
  di.init();
  runApp(const App());
}