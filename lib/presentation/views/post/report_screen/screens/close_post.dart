import 'package:afalagi/core/constants/data_export.dart';
import 'package:afalagi/core/constants/presentation_export.dart';
import 'package:afalagi/domain/entities/post/closed_case_entity.dart';

class ClosePostScreen extends StatefulWidget {
  const ClosePostScreen({super.key});

  @override
  State<ClosePostScreen> createState() => _ClosePostScreenState();
}

class _ClosePostScreenState extends State<ClosePostScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _foundConditionController =
      TextEditingController();
  final TextEditingController _foundLocationController =
      TextEditingController();
  final TextEditingController _foundThroughController = TextEditingController();
  final TextEditingController _foundDateController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Close Post'),
      ),
      body: BlocListener<PostsCubit, GenericState>(
        listener: (context, state) {
          if (state.isSuccess) {
            // On successful close, navigate back or show success message
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Post closed successfully')),
            );
            Navigator.pop(context);
          } else if (state.failure != null) {
            // Show error message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to close post: ${state.failure}')),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  controller: _foundConditionController,
                  decoration: const InputDecoration(
                    labelText: 'Found Condition',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the condition';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _foundLocationController,
                  decoration: const InputDecoration(
                    labelText: 'Found Location',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the location';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _foundThroughController,
                  decoration: const InputDecoration(
                    labelText: 'Found Through',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter how it was found';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _foundDateController,
                  decoration: const InputDecoration(
                    labelText: 'Found Date',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the date';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _closePost(context);
                    }
                  },
                  child: const Text('Close Post'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _closePost(BuildContext context) {
    final StorageService storageService = StorageService();

    ClosedCaseEntity updates = ClosedCaseEntity(
        id: storageService.getCloseCaseID(),
        foundDate: _foundDateController.text,
        foundLocation: _foundLocationController.text,
        foundThrough: _foundThroughController.text,
        description: _descriptionController.text,
        foundCondition: _foundConditionController.text);

    // Constructing the update payload for closing the post
    // final updates = ClosedCaseEntity(closedCase: closedCase);

    // Triggering the Cubit action to close the post
    context.read<PostsCubit>().closePost(updates);
  }
}
