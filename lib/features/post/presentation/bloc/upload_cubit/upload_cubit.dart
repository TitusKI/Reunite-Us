import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

enum UploadStatus { initial, loading, success, error }

class UploadState {
  final String? filePath;
  final String description;
  final UploadStatus status;

  UploadState(
      {this.filePath,
      this.description = '',
      this.status = UploadStatus.initial});
}

class UploadCubit extends Cubit<UploadState> {
  UploadCubit() : super(UploadState());

  final ImagePicker _picker = ImagePicker();

  Future<void> pickFile() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      emit(UploadState(
          filePath: pickedFile.path, description: state.description));
    }
  }

  void updateDescription(String description) {
    emit(UploadState(
        filePath: state.filePath,
        description: description,
        status: state.status));
  }

  Future<void> uploadFile() async {
    if (state.filePath == null) return;

    emit(UploadState(
        filePath: state.filePath,
        description: state.description,
        status: UploadStatus.loading));

    // Your API upload logic here
    try {
      // Example API call using Dio
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(state.filePath!),
        'description': state.description,
      });

      final response = await Dio().post('YOUR_API_ENDPOINT', data: formData);

      if (response.statusCode == 200) {
        emit(UploadState(
            filePath: state.filePath,
            description: state.description,
            status: UploadStatus.success));
      } else {
        emit(UploadState(
            filePath: state.filePath,
            description: state.description,
            status: UploadStatus.error));
      }
    } catch (e) {
      emit(UploadState(
          filePath: state.filePath,
          description: state.description,
          status: UploadStatus.error));
    }
  }
}
