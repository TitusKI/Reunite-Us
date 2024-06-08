import 'package:afalagi/repository/user_repository.dart';
import 'package:afalagi/services/api_services.dart';
import 'package:afalagi/services/storage_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Global {
  static late StorageService storageService;
  static late ApiServices apiServices;
  static late UserRepository userRepository;

  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    storageService = await StorageService().init();
    apiServices = ApiServices(storageService);
    userRepository = UserRepository(apiServices);
  }
}
