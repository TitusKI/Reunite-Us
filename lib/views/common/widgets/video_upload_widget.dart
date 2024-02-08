import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';

class VideoUploadWidget extends StatelessWidget {
  final String? videoFilePath;
  final String videoFileName;
  final void Function() onPickVideo;
  final void Function() onUploadVideo;
  final void Function(String) onFileNameChanged;

  const VideoUploadWidget({
    super.key,
    required this.videoFilePath,
    required this.videoFileName,
    required this.onPickVideo,
    required this.onUploadVideo,
    required this.onFileNameChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: TextEditingController(text: videoFileName),
                decoration: InputDecoration(
                  labelText: 'Video Filename',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.attach_file),
                    onPressed: onPickVideo,
                  ),
                ),
                onChanged: onFileNameChanged,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ElevatedButton.icon(
          onPressed: onUploadVideo,
          icon: const Icon(Icons.upload_file),
          label: const Text('Upload Video'),
        ),
      ],
    );
  }
}
