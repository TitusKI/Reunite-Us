// The UNIFICATION Of BlocProvider and routes and pages

import 'package:afalagi/data/services/local/storage_services.dart';
import 'package:afalagi/injection_container.dart';
import 'package:afalagi/presentation/bloc/common/comment_cubit.dart';
import 'package:afalagi/presentation/bloc/success_story/success_story_cubit.dart';
import 'package:afalagi/presentation/views/post/home_screen/widgets/comment_section.dart';
import 'package:afalagi/presentation/views/post/report_screen/screens/close_post.dart';
import '../../core/constants/presentation_export.dart';

class AppPages {
  // final UserRepositoryImpl _userRepository;
  // AppPages(this._userRepository);
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
          create: (_) => CreateProfileBloc(),
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
          bloc: BlocProvider(
        create: (_) => SignOutCubit(),
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
          bloc: BlocProvider(
            create: (_) => PostsCubit(),
          )),
      // bloc: BlocProvider(create: (_) => HomeBloc()))
      PageEntity(page: const CommentSection()),
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
          bloc: BlocProvider(
            create: (_) => PostsCubit(),
          )
          // bloc: BlocProvider(create: (_) => HomeBloc()))
          ),
      PageEntity(
          route: AppRoutes.MISSING_DETAIL,
          page: const MissingPersonDetail(),
          bloc: BlocProvider(
            create: (_) => PostsCubit(),
          )
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
          create: (_) => ReportFormBloc(),
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
          bloc: BlocProvider(
            create: (_) => SuccessStoryCubit(),
          )),
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
        create: (_) => ProfileCubit(),
      )),
      PageEntity(
          bloc: BlocProvider(
        create: (_) => MissingPersonUploadCubit(),
      )),
      PageEntity(
          // page: CommentSection(postId: postId),
          bloc: BlocProvider(
        create: (_) => CommentCubit(),
      )),
      PageEntity(
          route: AppRoutes.CLOSE_REPORT,
          page: const ClosePostScreen(),
          bloc: BlocProvider(
            create: (_) => SuccessStoryCubit(),
          )),
      PageEntity(bloc: BlocProvider(create: (_) => PostsCubit()))
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
        bool deviceFirstOpen = sl<StorageService>().getDeviceFirstOpen();
        if (result.first.route == AppRoutes.WELCOME && deviceFirstOpen) {
          print("Second Log");
          bool getIsLoggedIn = sl<StorageService>().getIsLoggedIn();
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
