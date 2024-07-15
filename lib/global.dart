import 'package:afalagi/repository/user_repository.dart';
import 'package:afalagi/services/api_services.dart';
import 'package:afalagi/services/storage_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Global {
  static late StorageService storageService;
  static ApiServices apiServices = ApiServices(storageService);
  static UserRepository userRepository = UserRepository(apiServices);
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //   statusBarColor: Colors.transparent, // Transparent status bar
    //   statusBarIconBrightness:
    //       Brightness.light, // For dark icons in the status bar
    // ));

    // await Future.delayed(const Duration(seconds: 2));
    storageService = await StorageService().init();
  }
}
