// The UNIFICATION Of BlocProvider and routes and pages

import 'package:afalagi/bloc/animation/animation_bloc.dart';
import 'package:afalagi/bloc/sign_in/sign_in_bloc.dart';
import 'package:afalagi/bloc/sign_up/sign_up_bloc.dart';
import 'package:afalagi/repository/user_repository.dart';
import 'package:afalagi/services/api_services.dart';

import 'export.dart';

class AppPages {
  final UserRepository _userRepository;
  final ApiServices _apiServices;
  AppPages(this._userRepository, this._apiServices);
  List<PageEntity> routes() {
    return [
      PageEntity(
        route: AppRoutes.WELCOME,
        page: const Welcome(),
        bloc: BlocProvider(
          create: (_) => WelcomeBloc(),
        ),
      ),
      PageEntity(
          route: AppRoutes.MAIN,
          page: const MyHomePage(),
          bloc: BlocProvider(
            create: (_) => BottomNavigationBloc(),
          )),
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
          create: (_) => SignUpBloc(_userRepository),
        ),
      ),
      PageEntity(
          route: AppRoutes.SIGN_UP_VERIFICATION,
          page: const SignUpVerification(),
          bloc: BlocProvider(
            create: (_) => VerificationBloc(_apiServices),
          )),
      PageEntity(
        route: AppRoutes.CREATE_PROFILE,
        page: CreateProfile(
          userRepository: _userRepository,
        ),
        bloc: BlocProvider(
          create: (_) => SignUpBloc(_userRepository),
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
            create: (_) => VerificationBloc(_apiServices),
          )),
      PageEntity(
          route: AppRoutes.RESET_SUCCESSFUL,
          page: const ResetSuccessful(),
          bloc: BlocProvider(
            create: (_) => SignUpBloc(_userRepository),
          )),
      PageEntity(
        route: AppRoutes.HOME,
        page: const Home(),
        // bloc: BlocProvider(create: (_) => HomeBloc()))
      ),
      PageEntity(
        route: AppRoutes.SEARCH,
        page: const SearchMissing(),
      ),
      PageEntity(
        route: AppRoutes.REPORT,
        page: const ReportMissing(),
      ),
      PageEntity(
        route: AppRoutes.ADD_REPORT,
        page: const AddReport(),
        bloc: BlocProvider(
          create: (_) => ReportFormBloc(),
        ),
      ),
      PageEntity(
        route: AppRoutes.CHAT,
        page: const ChatScreen(),
      ),
      PageEntity(
        route: AppRoutes.FOUND,
        page: const FoundPersons(),
      ),
      PageEntity(
          bloc: BlocProvider(
        create: (_) => TogglePasswordBloc(),
      )),
      PageEntity(
          bloc: BlocProvider(
        create: (_) => AnimationBloc(),
      ))
    ];
  }

  List<dynamic> allBlocProvider(BuildContext context) {
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
  MaterialPageRoute generateRouteSettings(RouteSettings settings) {
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
            print("is logged in");
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
