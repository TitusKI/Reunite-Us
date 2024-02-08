import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FileUploadWidget extends StatelessWidget {
  final String? filePath;
  final VoidCallback onPickFile;
  final VoidCallback onUploadFile;

  const FileUploadWidget({
    super.key,
    required this.filePath,
    required this.onPickFile,
    required this.onUploadFile,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // File path display
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: TextEditingController(text: filePath),
                decoration: InputDecoration(
                  labelText: 'File Path',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.attach_file),
                    onPressed: onPickFile,
                  ),
                ),
                readOnly: true,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ElevatedButton.icon(
          onPressed: onUploadFile,
          icon: const Icon(Icons.upload_file),
          label: const Text('Upload'),
        ),
      ],
    );
  }
}
