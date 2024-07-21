// ignore_for_file: must_be_immutable

import 'package:afalagi/routes/pages.dart';
import 'package:afalagi/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  await Global.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  AppPages appPages = AppPages(Global.userRepository, Global.apiServices);
  MyApp({super.key});

  // This widget is the root of this application.

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [...appPages.allBlocProvider(context)],
      child: ScreenUtilInit(
        builder: (context, child) => MaterialApp(
          theme: ThemeData(
              textTheme:
                  GoogleFonts.soraTextTheme(Theme.of(context).textTheme)),
          debugShowCheckedModeBanner: false,
          onGenerateRoute: appPages.generateRouteSettings,
        ),
      ),
    );
  }
}
