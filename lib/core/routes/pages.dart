// The UNIFICATION Of BlocProvider and routes and pages
import 'package:afalagi/bloc/reset_password/reset_password_bloc.dart';
import 'package:afalagi/bloc/sign_in/sign_in_bloc.dart';
import 'package:afalagi/bloc/sign_up/sign_up_bloc.dart';
import 'package:afalagi/bloc/verification/verification_bloc.dart';
import 'package:afalagi/bloc/welcome/welcome_bloc.dart';
import 'package:afalagi/core/routes/names.dart';
import 'package:afalagi/main/global.dart';
import 'package:afalagi/views/home_screen/screens/home.dart';
import 'package:afalagi/views/reset_password/screens/reset_screen.dart';
import 'package:afalagi/views/reset_password/screens/reset_successful.dart';
import 'package:afalagi/views/reset_password/screens/reset_verification.dart';
import 'package:afalagi/views/sign_in_screen/screens/sign_in.dart';
import 'package:afalagi/views/sign_up_screen/screens/create_profile.dart';
import 'package:afalagi/views/sign_up_screen/screens/sign_up.dart';
import 'package:afalagi/views/sign_up_screen/screens/verification_code.dart';
import 'package:afalagi/views/welcome_screen/screens/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppPages {
  static List<PageEntity> routes() {
    return [
      PageEntity(
        route: AppRoutes.WELCOME,
        page: const Welcome(),
        bloc: BlocProvider(
          create: (_) => WelcomeBloc(),
        ),
      ),
      PageEntity(
        route: AppRoutes.SIGN_IN,
        page: const SignIn(),
        bloc: BlocProvider(
          create: (_) => SignInBloc(),
        ),
      ),
      PageEntity(
        route: AppRoutes.SIGN_UP,
        page: const SignUp(),
        bloc: BlocProvider(
          create: (_) => SignUpBloc(),
        ),
      ),
      PageEntity(
          route: AppRoutes.SIGN_UP_VERIFICATION,
          page: const SignUpVerification(),
          bloc: BlocProvider(
            create: (_) => VerificationBloc(),
          )),
      PageEntity(
        route: AppRoutes.CREATE_PROFILE,
        page: const CreateProfile(),
        bloc: BlocProvider(
          create: (_) => SignUpBloc(),
        ),
      ),
      PageEntity(
        route: AppRoutes.RESET_PASSWORD,
        page: const ResetScreen(),
        bloc: BlocProvider(
          create: (_) => ResetPasswordBloc(),
        ),
      ),
      PageEntity(
          route: AppRoutes.RESET_VERIFICATION,
          page: const ResetVerification(),
          bloc: BlocProvider(
            create: (_) => VerificationBloc(),
          )),
      PageEntity(
          route: AppRoutes.RESET_SUCCESSFUL,
          page: const ResetSuccessful(),
          bloc: BlocProvider(
            create: (_) => SignUpBloc(),
          )),
      PageEntity(
        route: AppRoutes.HOME,
        page: const MyHomePage(),
        // bloc: BlocProvider(create: (_) => HomeBloc()))
      )
    ];
  }

  static List<dynamic> allBlocProvider(BuildContext context) {
    List<dynamic> blocProviders = <dynamic>[];
    for (var bloc in routes()) {
      if (bloc.bloc != null) {
        // Check if bloc is not null before adding
        blocProviders.add(bloc.bloc);
      }
    }
    return blocProviders;
  }

  // models that covers entire screen as we click on navigator object
  static MaterialPageRoute generateRouteSettings(RouteSettings settings) {
    print('GenerateRouteSettings');
    if (settings.name != null) {
      // check for route name matching when navigator gets triggered
      var result = routes().where((element) => element.route == settings.name);
      if (result.isNotEmpty) {
        print("first log");
        print(result.first.route);
        print(result.indexed);
        bool deviceFirstOpen = Global.storageService.getDeviceFirstOpen();
        if (result.first.route == AppRoutes.WELCOME && deviceFirstOpen) {
          print("Second Log");
          bool getIsLoggedIn = Global.storageService.getIsLoggedIn();
          if (getIsLoggedIn) {
            return MaterialPageRoute(
                builder: (_) => const MyHomePage(), settings: settings);
          }
          return MaterialPageRoute(
              builder: (_) => const SignIn(), settings: settings);
        }
        return MaterialPageRoute(
            builder: (_) => result.first.page!, settings: settings);
      }
    }
    print("Invalid route name: ${settings.name}");
    return MaterialPageRoute(
        builder: (_) => const Welcome(), settings: settings);
  }
}

class HomeBloc {}

class PageEntity {
  String? route;
  Widget? page;
  dynamic bloc;

  PageEntity({this.route, this.page, this.bloc});
}
