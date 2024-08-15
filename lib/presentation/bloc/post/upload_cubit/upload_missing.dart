import 'package:afalagi/presentation/bloc/post/upload_cubit/upload_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';

// enum UploadStatus { initial, loading, success, error }

class MissingPersonUploadState {
  final String? photoPath;
  final UploadStatus status;

  MissingPersonUploadState(
      {this.photoPath, this.status = UploadStatus.initial});
}

class MissingPersonUploadCubit extends Cubit<MissingPersonUploadState> {
  MissingPersonUploadCubit() : super(MissingPersonUploadState());

  final ImagePicker _picker = ImagePicker();

  Future<void> pickPhoto() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      emit(MissingPersonUploadState(
          photoPath: pickedFile.path, status: state.status));
    }
  }

  Future<void> uploadPhoto() async {
    if (state.photoPath == null) return;

    emit(MissingPersonUploadState(
        photoPath: state.photoPath, status: UploadStatus.loading));

    try {
      final formData = FormData.fromMap({
        'photo': await MultipartFile.fromFile(state.photoPath!),
      });

      final response = await Dio().post('YOUR_API_ENDPOINT', data: formData);

      if (response.statusCode == 200) {
        emit(MissingPersonUploadState(
            photoPath: state.photoPath, status: UploadStatus.success));
      } else {
        emit(MissingPersonUploadState(
            photoPath: state.photoPath, status: UploadStatus.error));
      }
    } catch (e) {
      emit(MissingPersonUploadState(
          photoPath: state.photoPath, status: UploadStatus.error));
    }
  }
}
