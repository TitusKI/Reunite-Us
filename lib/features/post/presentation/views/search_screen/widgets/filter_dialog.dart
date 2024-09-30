import '../../../../../../core/constants/presentation_export.dart';
import '../../../bloc/search_cubit.dart';

class FilterDialog extends StatefulWidget {
  const FilterDialog({super.key});

  @override
  _FilterDialogState createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Only including Age Range, Nationality, and Last Seen Location filters
            DropdownButtonFormField<String>(
              items: ['CHILDREN', 'YOUTH', 'ADULTS', 'SENIORS']
                  .map((ageRange) => DropdownMenuItem(
                        value: ageRange,
                        child: Text(ageRange),
                      ))
                  .toList(),
              decoration: const InputDecoration(labelText: 'Age Range'),
              onChanged: (value) =>
                  context.read<SearchCubit>().updateAgeRange(value),
            ),

            DropdownButtonFormField<String>(
                items: ['Ethiopian', 'German', 'American']
                    .map((nationality) => DropdownMenuItem(
                          value: nationality,
                          child: Text(nationality),
                        ))
                    .toList(),
                decoration: const InputDecoration(labelText: 'Nationality'),
                onChanged: (value) =>
                    context.read<SearchCubit>().updateNationality(value)),
            DropdownButtonFormField<String>(
              items: ['Addis Ababa', 'Gondar', 'Bahirdar']
                  .map((location) => DropdownMenuItem(
                        value: location,
                        child: Text(location),
                      ))
                  .toList(),
              decoration:
                  const InputDecoration(labelText: 'Last Seen Location'),
              onChanged: (value) =>
                  context.read<SearchCubit>().updateLastSeenLocation(value),
            ),

            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<SearchCubit>().applyFilters();
                    Navigator.pop(context);
                  },
                  child: const Text('Apply Filters'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
