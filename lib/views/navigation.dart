import 'package:afalagi/bloc/bottom_navigation/bottom_navigation_bloc.dart';
import 'package:afalagi/views/chat_screen/screens/chat.dart';
import 'package:afalagi/views/common/values/colors.dart';
import 'package:afalagi/views/common/widgets/common_widgets.dart';
import 'package:afalagi/views/found_screen/screens/found.dart';
import 'package:afalagi/views/home_screen/screens/home.dart';
import 'package:afalagi/views/report_screen/screens/report.dart';
import 'package:afalagi/views/search_screen/screens/search.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavigationBloc, BottomNavigationState>(
      builder: (context, state) {
        print(state.navIndex);
        Widget body;
        String appBarTitle;
        List<Widget> appBarActions = [];

        switch (state.navIndex) {
          case 0:
            body = const Home();
            appBarTitle = "Home";
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
          appBar: buildAppBarLarge(appBarTitle, actions: appBarActions),
          bottomNavigationBar: ConvexAppBar(
            style: TabStyle.react,
            backgroundColor: AppColors.accentColor,
            items: const [
              TabItem(icon: Icons.home_rounded, title: "Home"),
              TabItem(icon: Icons.search_rounded, title: "Search"),
              TabItem(icon: Icons.live_help_rounded, title: "Report"),
              TabItem(icon: Icons.chat_rounded, title: "Chat"),
              TabItem(icon: Icons.emoji_events_rounded, title: "Found")
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
