import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_app/routes/app_routes.dart';
import 'package:grocery_app/utils/constants/colors.dart';
import 'package:grocery_app/utils/theme/theme.dart';

import 'bindings/general_bindings.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system ,
      theme: UAppTheme.lightTheme,
      darkTheme: UAppTheme.darkTheme,
      getPages: UAppRoutes.screens,
      initialBinding: GeneralBindings(),
      home: Scaffold(
        backgroundColor: UColors.primary,
        body: Center(
          child: CircularProgressIndicator(color: UColors.white),
        ),
      ),
    );
  }
}