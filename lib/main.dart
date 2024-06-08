// ignore_for_file: must_be_immutable

import 'package:afalagi/bloc/theme_cubit/theme_cubit.dart';
import 'package:afalagi/routes/pages.dart';
import 'package:afalagi/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure binding is initialized
  await Global.init(); // Wait for initialization
  runApp(MyApp()); // Run the app after initialization
}

class MyApp extends StatelessWidget {
  AppPages appPages = AppPages(Global.userRepository);
  MyApp({super.key});

  // This widget is the root of this application.

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [...appPages.allBlocProvider(context)],
        child: ScreenUtilInit(
            // designSize: const Size(375, 812),
            builder: (context, child) => BlocBuilder<ThemeCubit, ThemeData>(
                  builder: (context, theme) {
                    return MaterialApp(
                      theme: theme,

                      // theme for both

                      // theme: ThemeData(
                      //   colorScheme: const ColorScheme.highContrastLight(),
                      //   textTheme:
                      //       GoogleFonts.soraTextTheme(Theme.of(context).textTheme),
                      // ),
                      debugShowCheckedModeBanner: false,
                      onGenerateRoute: appPages.generateRouteSettings,
                    );
                  },
                )));
  }
}
