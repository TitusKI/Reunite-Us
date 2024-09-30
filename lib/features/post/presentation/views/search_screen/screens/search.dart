import 'package:afalagi/core/constants/presentation_export.dart';
import 'package:afalagi/features/post/presentation/views/search_screen/widgets/filter_dialog.dart';
import '../../../../../../core/constants/constant.dart';
import '../../../../../../core/util/data_util.dart';
import '../../../../domain/entities/missing_person_entity.dart';
import '../../../bloc/search_cubit.dart';

class SearchMissing extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  SearchMissing({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildSearchField(context),
          BlocBuilder<SearchCubit, GenericState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state.isSuccess) {
                if (state.data != null && state.data is List<String>) {
                  return _buildRecentSearches(state.data as List<String>);
                }
                return state.data != null && state.data!.isNotEmpty
                    ? _buildSearchResults(state.data!)
                    : const Text("No results found.");
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _searchController,
            decoration: const InputDecoration(
              hintText: 'Search',
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: (text) => context.read<SearchCubit>().search(text),
          ),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: () => showDialog(
            context: context,
            builder: (_) => const FilterDialog(),
          ),
          child: const Text('Filters'),
        ),
      ],
    );
  }

  Widget _buildRecentSearches(List<String> recentSearches) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        // Subtle background for better separation
        borderRadius: BorderRadius.circular(8.0), // Gentle rounded corners
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recent Searches',
            style: TextStyle(
              fontSize: 16.0, // Clear heading size
              fontWeight: FontWeight.bold, // Emphasize heading
              color: Colors.black87, // Contrasting text for readability
            ),
          ),
          const SizedBox(height: 8.0), // Add some spacing after the heading
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: recentSearches.length,
            itemBuilder: (context, index) {
              final search = recentSearches[index];
              return InkWell(
                // Use InkWell for a more natural tap response
                borderRadius:
                    BorderRadius.circular(8.0), // Extend corner radius to items
                onTap: () {
                  _searchController.text = search;
                  context.read<SearchCubit>().search(search);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search_rounded, // Consistent material design icon
                        size: 20.0,
                        color: Theme.of(context)
                            .primaryColor, // Reflect theme color
                      ),
                      const SizedBox(
                          width: 8.0), // Spacing between icon and text
                      Flexible(
                        // Wrap text to avoid overflow on smaller screens
                        child: Text(
                          search,
                          overflow:
                              TextOverflow.ellipsis, // Truncate long searches
                          style: const TextStyle(
                            fontSize: 14.0, // Clear item text size
                            color: Colors.black87, // Consistent text color
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults(List<MissingPersonEntity> results) {
    return Expanded(
      child: ListView.builder(
        itemCount: results.length,
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        itemBuilder: (context, index) {
          final result = results[index];
          return Card(
            elevation: 4.0, // Add subtle elevation for card separation
            margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),

            child: InkWell(
              onTap: () {
                _searchController.text = result.firstName;
                context.read<SearchCubit>().search(result.firstName);
                Navigator.pushNamed(context, AppRoutes.MISSING_DETAIL,
                    arguments: result);
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                      tag: result
                          .id!, // Use unique identifier for each missing person
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            "${AppConstant.UPLOAD_BASE_URL}/post/${result.postImages[0]}",
                            width: 80.0,
                            height: 80.0,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.person,
                                  size: 40.0); // Placeholder for missing images
                            },
                          )),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${result.firstName} ${result.lastName}',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            '${calculateAge(result.dateOfBirth!)} years old, ${result.nationality}',
                            style: const TextStyle(
                                fontSize: 14.0, color: Colors.grey),
                          ),
                          Text(
                            'Last seen: ${result.lastSeenLocation}',
                            maxLines:
                                2, // Allow for two lines to display longer descriptions
                            overflow:
                                TextOverflow.ellipsis, // Trim long descriptions
                            style: const TextStyle(
                                fontSize: 12.0, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
