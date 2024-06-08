// The UNIFICATION Of BlocProvider and routes and pages

import 'package:afalagi/bloc/animation/animation_bloc.dart';
import 'package:afalagi/bloc/profile/create_profile/create_profile_bloc.dart';
import 'package:afalagi/bloc/language/language_bloc.dart';
import 'package:afalagi/bloc/profile/profile_cubit.dart';
import 'package:afalagi/bloc/search/search_bloc.dart';
import 'package:afalagi/bloc/sign_in/sign_in_bloc.dart';
import 'package:afalagi/bloc/sign_out/sign_out_cubit.dart';
import 'package:afalagi/bloc/sign_up/sign_up_bloc.dart';
import 'package:afalagi/bloc/theme_cubit/theme_cubit.dart';
import 'package:afalagi/bloc/upload_cubit/upload_cubit.dart';
import 'package:afalagi/bloc/upload_cubit/upload_missing.dart';
import 'package:afalagi/repository/user_repository.dart';
import 'package:afalagi/views/chat_screen/screens/chat_page.dart';
import 'package:afalagi/views/drawer_screen/screens/about_us/about_us.dart';
import 'package:afalagi/views/drawer_screen/screens/feedback/feedback.dart';
import 'package:afalagi/views/drawer_screen/screens/profile/edit_profile.dart';
import 'package:afalagi/views/drawer_screen/screens/profile/profile_screen.dart';
import 'package:afalagi/views/drawer_screen/screens/settings/notification_and_sound_screen/notification_and_sound.dart';
import 'package:afalagi/views/drawer_screen/screens/settings/setting.dart';
import 'package:afalagi/views/drawer_screen/screens/support_and_donation/support_donation.dart';
import 'package:afalagi/views/missing_person_detail/missing_person_detail.dart';
import 'package:afalagi/views/user_details/screens/profile_detail.dart';

import 'export.dart';

class AppPages {
  final UserRepository _userRepository;
  AppPages(this._userRepository);
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
          page: MyHomePage(),
          bloc: BlocProvider(
            create: (_) => BottomNavigationBloc(),
          )),
      PageEntity(
        route: AppRoutes.SIGN_IN,
        page: const SignIn(),
        bloc: BlocProvider(
          create: (_) => SignInBloc(_userRepository),
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
            create: (_) => VerificationBloc(_userRepository),
          )),
      PageEntity(
        route: AppRoutes.CREATE_PROFILE,
        page: CreateProfile(
          userRepository: _userRepository,
        ),
        bloc: BlocProvider(
          create: (_) => CreateProfileBloc(_userRepository),
        ),
      ),
      PageEntity(
        route: AppRoutes.RESET_PASSWORD,
        page: const ResetScreen(),
        bloc: BlocProvider(
          create: (_) => ResetPasswordBloc(_userRepository),
        ),
      ),
      PageEntity(
          bloc: BlocProvider(
        create: (_) => SignOutCubit(_userRepository),
      )),
      // PageEntity(
      //     route: AppRoutes.RESET_SUCCESSFUL,
      //     page: const ResetSuccessful(),
      //     bloc: BlocProvider(
      //       create: (_) => SignUpBloc(_userRepository),
      //     )),
      PageEntity(
        route: AppRoutes.HOME,
        page: const Home(),
        // bloc: BlocProvider(create: (_) => HomeBloc()))
      ),
      PageEntity(
        route: AppRoutes.PROFILE,
        page: const ProfileScreen(),
        // bloc: BlocProvider(create: (_) => HomeBloc()))
      ),
      PageEntity(
        route: AppRoutes.EDIT_PROFILE,
        page: const EditProfileScreen(),
        // bloc: BlocProvider(create: (_) => HomeBloc()))
      ),
      PageEntity(
        route: AppRoutes.PROFILE_DETAIL,
        page: const ProfileDetail(),
        // bloc: BlocProvider(create: (_) => HomeBloc()))
      ),
      PageEntity(
        route: AppRoutes.MISSING_DETAIL,
        page: const MissingPersonDetail(),
        // bloc: BlocProvider(create: (_) => HomeBloc()))
      ),
      PageEntity(
        route: AppRoutes.SETTING,
        page: const Setting(),
        // bloc: BlocProvider(create: (_) => HomeBloc()))
      ),
      PageEntity(
        route: AppRoutes.NOTIFICATION_SOUND,
        page: const NotificationAndSound(),
        // bloc: BlocProvider(create: (_) => HomeBloc()))
      ),
      PageEntity(
        route: AppRoutes.NOTIFICATION_SOUND,
        page: const NotificationAndSound(),
        // bloc: BlocProvider(create: (_) => HomeBloc()))
      ),
      PageEntity(
        route: AppRoutes.FEEDBACK,
        page: FeedbackPage(),
        // bloc: BlocProvider(create: (_) => HomeBloc()))
      ),
      PageEntity(
        route: AppRoutes.ABOUT_US,
        page: const AboutUsPage(),
        // bloc: BlocProvider(create: (_) => HomeBloc()))
      ),
      PageEntity(
        route: AppRoutes.SUPPORT_DONATION,
        page: const SupportDonationPage(),
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
          create: (_) => ReportFormBloc(_userRepository),
        ),
      ),
      PageEntity(
        route: AppRoutes.CHAT,
        page: const ChatScreen(),
      ),
      PageEntity(
        route: AppRoutes.CHAT_PAGE,
        page: const ChatPage(),
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
      )),
      PageEntity(
          bloc: BlocProvider(
        create: (_) => LanguageBloc(),
      )),
      PageEntity(
          bloc: BlocProvider(
        create: (_) => SearchBloc(),
      )),
      PageEntity(
          bloc: BlocProvider(
        create: (_) => ThemeCubit(),
      )),
      PageEntity(
          bloc: BlocProvider(
        create: (_) => UploadCubit(),
      )),
      PageEntity(
          bloc: BlocProvider(
        create: (_) => ProfileCubit(_userRepository),
      )),
      PageEntity(
          bloc: BlocProvider(
        create: (_) => MissingPersonUploadCubit(),
      )),
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
                builder: (_) => MyHomePage(), settings: settings);
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
