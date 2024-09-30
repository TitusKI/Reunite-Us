// ignore_for_file: must_be_immutable

import 'package:afalagi/features/auth/presentation/bloc/theme_cubit/theme_cubit.dart';
import 'package:afalagi/config/routes/pages.dart';
import 'package:afalagi/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> main() async {
  await initializeDependencies(); // Wait for initialization
  runApp(MyApp()); // Run the app after initialization
}

class MyApp extends StatelessWidget {
  final AppPages appPages = AppPages();
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        ...appPages.allBlocProvider(context),
        BlocProvider(create: (context) => ThemeCubit()),
      ],
      child: ScreenUtilInit(
        builder: (context, child) => BlocBuilder<ThemeCubit, ThemeData>(
          builder: (context, theme) {
            return MaterialApp(
              theme: theme, // Directly use the theme provided by ThemeCubit
              debugShowCheckedModeBanner: false,
              onGenerateRoute: appPages.generateRouteSettings,
            );
          },
        ),
      ),
    );
  }
}
