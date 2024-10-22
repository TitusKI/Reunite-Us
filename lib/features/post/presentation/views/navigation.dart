import 'package:afalagi/features/post/presentation/bloc/bottom_navigation/bottom_navigation_bloc.dart';
import 'package:afalagi/config/routes/names.dart';
import 'package:afalagi/features/user/presentation/views/chat/screens/chat.dart';
import 'package:afalagi/config/theme/colors.dart';
import 'package:afalagi/features/auth/presentation/views/widgets/common_widgets.dart';
import 'package:afalagi/features/success_stories/presentation/views/screens/found.dart';
import 'package:afalagi/features/post/presentation/views/home_screen/screens/home.dart';
import 'package:afalagi/features/user/presentation/views/drawer_screen/screens/drawer.dart';
import 'package:afalagi/features/post/presentation/views/report_screen/screens/report.dart';
import 'package:afalagi/features/post/presentation/views/search_screen/screens/search.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
      builder: (context, state) {
        print(state.navIndex);

        String appBarTitle;
        List<Widget> appBarActions = [];
        Widget? leading;
        Widget? drawer;

        switch (state.navIndex) {
          case 0:
            appBarTitle = "Reunite-Us";

            appBarActions = [
              IconButton(
                  style: const ButtonStyle(
                    foregroundColor:
                        WidgetStatePropertyAll(AppColors.primaryBackground),
                    // backgroundColor:
                    //     WidgetStatePropertyAll(AppColors.primaryBackground),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(AppRoutes.ADD_REPORT);
                  },
                  icon: const Icon(Icons.add_circle_outline_outlined))
            ];
            leading = IconButton(
              icon: Image.asset(
                'assets/logo/logo1.png',
                // color: AppColors.primaryBackground,
                filterQuality: FilterQuality.high,
                scale: 0.5,
              ),
              onPressed: () {
                _scaffoldKey.currentState?.openDrawer();
              },
            );

            drawer = const AppDrawer();
            break;
          case 1:
            appBarTitle = "Search";
            break;
          case 2:
            appBarTitle = "Report Missing";
            appBarActions = [
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.ADD_REPORT);
                  // Action for the report screen
                },
              ),
            ];
            break;
          case 3:
            appBarTitle = "Chat";
            break;
          case 4:
            appBarTitle = "Found Persons";
            break;
          default:
            appBarTitle = "Afalagi";
        }
        return Scaffold(
          key: _scaffoldKey,
          drawer: drawer,
          appBar: buildAppBarLarge(appBarTitle,
              actions: appBarActions, leading: leading),
          bottomNavigationBar: ConvexAppBar(
            controller: _tabController,
            style: TabStyle.react,
            backgroundColor: AppColors.secondaryColor,
            items: [
              TabItem(
                icon: Image.asset('assets/icons/home.png'),
                title: "Home",
              ),
              TabItem(
                  icon: Image.asset('assets/icons/searchMissing.png'),
                  title: "Search"),
              TabItem(
                  icon: Image.asset('assets/icons/report.png'),
                  title: "Report"),
              TabItem(
                  icon: Image.asset('assets/icons/chat.png'), title: "Chat"),
              TabItem(
                  icon: Image.asset('assets/icons/success.png'), title: "Found")
            ],
            initialActiveIndex: state.navIndex,
            onTap: (int i) {
              context
                  .read<BottomNavigationBloc>()
                  .add(BottomNavigationEvent(i));
            },
          ),
          body: TabBarView(controller: _tabController, children: const [
            Home(),
            SearchMissing(),
            ReportMissing(),
            ChatScreen(),
            FoundPersons()
          ]),
        );
      },
    );
  }
}
