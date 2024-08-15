import 'package:afalagi/presentation/bloc/post/search/search_bloc.dart';
import 'package:afalagi/config/theme/colors.dart';
import 'package:afalagi/presentation/views/post/search_screen/widgets/filter_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchMissing extends StatefulWidget {
  const SearchMissing({super.key});

  @override
  State<SearchMissing> createState() => _SearchMissingState();
}

class _SearchMissingState extends State<SearchMissing> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  cursorColor: AppColors.accentColor,
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search, size: 24.sp),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                  ),
                  onChanged: (text) {
                    context.read<SearchBloc>().add(SearchTextChanged(text));
                  },
                  onTap: () {
                    context.read<SearchBloc>().add(SearchFieldFocused());
                  },
                ),
              ),
              SizedBox(width: 8.w),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: context, builder: (context) => FilterDialog());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accentColor,
                  foregroundColor: AppColors.primaryBackground,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                ),
                child: Text(
                  'Add Filter',
                  style: TextStyle(fontSize: 14.sp),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          // const Center(
          //   child: Text(
          //       "You can search here\n for missing persons \nin different filter mechanism"),
          // ),

          BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              if (state is SearchLoaded) {
                // if (state.isSearching) {
                //   return Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     mainAxisSize: MainAxisSize.min,
                //     children: [
                //       Flexible(
                //         fit: FlexFit.loose,
                //         child: ListView.builder(
                //           shrinkWrap: true,
                //           itemCount: state.recentSearches.length,
                //           itemBuilder: (context, index) {
                //             return ListTile(
                //               title: Text(
                //                 state.recentSearches[index],
                //                 style: TextStyle(fontSize: 14.sp),
                //               ),
                //               onTap: () {
                //                 setState(() {
                //                   _searchController.text =
                //                       state.recentSearches[index];
                //                   context
                //                       .read<SearchBloc>()
                //                       .add(const SearchTextChanged(''));
                //                 });
                //               },
                //             );
                //           },
                //         ),
                //       ),
                //     ],
                //   );
                // }
                // else
                if (state.showRecentSearches && state.isSearching) {
                  return Flexible(
                    fit: FlexFit.loose,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Recent Searches:',
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: AppColors.secondaryColor,
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: state.recentSearches.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                state.recentSearches[index],
                                style: TextStyle(fontSize: 14.sp),
                              ),
                              onTap: () {
                                setState(() {
                                  _searchController.text =
                                      state.recentSearches[index];
                                  context.read<SearchBloc>().add(
                                      SearchTextChanged(
                                          state.recentSearches[index]));
                                });
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  );
                } else {
                  return Text(
                    'Search for missing persons',
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: Colors.grey,
                    ),
                  );
                }
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
