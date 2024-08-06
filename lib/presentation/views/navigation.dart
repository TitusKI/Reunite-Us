import 'package:afalagi/presentation/bloc/common/bottom_navigation/bottom_navigation_bloc.dart';
import 'package:afalagi/config/routes/names.dart';
import 'package:afalagi/presentation/views/common/chat_screen/screens/chat.dart';
import 'package:afalagi/config/theme/colors.dart';
import 'package:afalagi/presentation/views/common/widgets/common_widgets.dart';
import 'package:afalagi/presentation/views/common/found_screen/screens/found.dart';
import 'package:afalagi/presentation/views/common/home_screen/screens/home.dart';
import 'package:afalagi/presentation/views/common/drawer_screen/screens/drawer.dart';
import 'package:afalagi/presentation/views/post/report_screen/screens/report.dart';
import 'package:afalagi/presentation/views/post/search_screen/screens/search.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHomePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
      builder: (context, state) {
        print(state.navIndex);
        Widget body;
        String appBarTitle;
        List<Widget> appBarActions = [];
        Widget? leading;
        Widget? drawer;

        switch (state.navIndex) {
          case 0:
            body = const Home();
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
            body = const SearchMissing();
            appBarTitle = "Search";
            break;
          case 2:
            body = const ReportMissing();
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
            body = const ChatScreen();
            appBarTitle = "Chat";
            break;
          case 4:
            body = const FoundPersons();
            appBarTitle = "Found Persons";
            break;
          default:
            body = Container(); // Handle default case
            appBarTitle = "Afalagi";
        }
        return Scaffold(
          key: _scaffoldKey,
          drawer: drawer,
          appBar: buildAppBarLarge(appBarTitle,
              actions: appBarActions, leading: leading),
          bottomNavigationBar: ConvexAppBar(
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
          body: body,
        );
      },
    );
  }
}
