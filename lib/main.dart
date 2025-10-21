import 'package:flutter/material.dart';
import 'package:money_care/core/navigation/app_router.dart';
import 'package:intl/date_symbol_data_local.dart'; // 

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Bắt buộc cho async
  await initializeDateFormatting('vi', null); 
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      themeMode: ThemeMode.system,
    );
  }
}
