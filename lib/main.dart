import 'package:afalagi/core/routes/pages.dart';
import 'package:afalagi/main/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> main() async {
  await Global.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [...AppPages.allBlocProvider(context)],
      child: ScreenUtilInit(
        builder: (context, child) => const MaterialApp(
          debugShowCheckedModeBanner: false,
          // theme: ThemeData(
          //   primaryColor: Colors.red,
          //   brightness: Brightness.light,
          // ),
          // initialRoute: ,
          onGenerateRoute: AppPages.generateRouteSettings,

          // home: const Welcome(),
          // routes: {
          //   // "myHomePage": (context) => const MyHomePage(),
          //   "signIn": (context) => const SignIn(),
          //   "register": (context) => const Register(),
          // },
        ),
      ),
    );
  }
}
