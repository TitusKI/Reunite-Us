import 'package:afalagi/core/constants/presentation_export.dart';
import 'package:afalagi/features/post/domain/entities/closed_case_entity.dart';
import '../../../../../success_stories/presentation/views/screens/create_success_story.dart';

class ClosePostScreen extends StatefulWidget {
  const ClosePostScreen({super.key, this.postId});
  final String? postId;

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
  late String? id;

  @override
  void initState() {
    super.initState();
    id = widget.postId ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: BlocListener<PostsCubit, GenericState>(
        listener: (context, state) {
          if (state.isSuccess) {
            Navigator.pop(context); // Close dialog on success
            _showSuccessStoryDialog(context,
                closedCaseId: id!); // Show Success Story dialog
          } else if (state.failure != null) {
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
              shrinkWrap: true,
              children: [
                const Text(
                  'Close Post',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  controller: _foundConditionController,
                  label: 'Found Condition',
                ),
                const SizedBox(height: 10),
                _buildTextField(
                  controller: _foundLocationController,
                  label: 'Found Location',
                ),
                const SizedBox(height: 10),
                _buildTextField(
                  controller: _foundThroughController,
                  label: 'Found Through',
                ),
                const SizedBox(height: 10),
                _buildTextField(
                  controller: _foundDateController,
                  label: 'Found Date',
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
    );
  }

  void _closePost(BuildContext context) async {
    ClosedCaseEntity updates = ClosedCaseEntity(
      id: id,
      foundDate: _foundDateController.text,
      foundLocation: _foundLocationController.text,
      foundThrough: _foundThroughController.text,
      description: _descriptionController.text,
      foundCondition: _foundConditionController.text,
    );

    context.read<PostsCubit>().closePost(updates);
  }
}

void _showSuccessStoryDialog(BuildContext context,
    {required String closedCaseId}) {
  showDialog(
    context: context,
    builder: (context) => SuccessStoryDialog(closedCaseId: closedCaseId),
  );
}
