import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grocery_app/data/repositories/authentication/authentication_repository.dart';

import 'my_app.dart';

Future<void> main() async{
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  /*Firebase.initializeApp().then((value){
    Get.put(AuthenticationRepository());
  });*/
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp();

  Get.put(AuthenticationRepository());

  await GetStorage.init();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}



