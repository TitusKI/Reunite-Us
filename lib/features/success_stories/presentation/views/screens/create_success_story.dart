import 'package:afalagi/core/constants/presentation_export.dart';
import 'package:afalagi/features/success_stories/presentation/bloc/success_story_cubit.dart';

import '../../../domain/entities/success_story_entity.dart';

class SuccessStoryDialog extends StatefulWidget {
  final String closedCaseId;
  const SuccessStoryDialog({super.key, required this.closedCaseId});

  @override
  State<SuccessStoryDialog> createState() => _SuccessStoryDialogState();
}

class _SuccessStoryDialogState extends State<SuccessStoryDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  List<String>? images;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            children: [
              const Text(
                'Create Success Story',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              _buildTextField(_titleController, 'Title'),
              const SizedBox(height: 10),
              _buildTextField(_contentController, 'Content', maxLines: 4),
              const SizedBox(height: 10),
              // Add an image picker if required for the images
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _createSuccessStory(context);
                  }
                },
                child: const Text('Submit Success Story'),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () => Navigator.pop(context), // Close dialog
                child: const Text('Cancel'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {int maxLines = 1}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      maxLines: maxLines,
      validator: (value) =>
          value == null || value.isEmpty ? 'Please enter $label' : null,
    );
  }

  void _createSuccessStory(BuildContext context) async {
    final successStory = SuccessStoryEntity(
      title: _titleController.text,
      content: _contentController.text,
      closedCaseId: widget.closedCaseId,
      images: images,
    );

    context.read<SuccessStoryCubit>().createSuccessStory(successStory);
    Navigator.pop(context);
  }
}
