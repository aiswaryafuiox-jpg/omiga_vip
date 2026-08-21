import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/const/app_color.dart';
import 'core/utils/navigation/app_routes.dart';
import 'core/di/service_locator.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'OMIGA VIP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.primaryDark,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.accentGold,
          surface: AppColors.secondaryDark,
        ),
        fontFamily: 'Poppins',
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primaryDark,
          elevation: 0,
        ),
      ),
      initialRoute: AppRoutes.initial,
      getPages: AppRoutes.pages,
    );
  }
}
