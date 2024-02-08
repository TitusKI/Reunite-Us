import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:dio/dio.dart';

enum UploadStatus { initial, loading, success, error }

class VideoUploadState {
  final String? videoFilePath;
  final String videoFileName;
  final UploadStatus status;

  VideoUploadState(
      {this.videoFilePath,
      this.videoFileName = '',
      this.status = UploadStatus.initial});
}

class VideoUploadCubit extends Cubit<VideoUploadState> {
  VideoUploadCubit() : super(VideoUploadState());

  final ImagePicker _picker = ImagePicker();

  Future<void> pickVideo() async {
    final pickedFile = await _picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      emit(VideoUploadState(
          videoFilePath: pickedFile.path,
          videoFileName: pickedFile.name,
          status: state.status));
    }
  }

  void updateFileName(String fileName) {
    emit(VideoUploadState(
        videoFilePath: state.videoFilePath,
        videoFileName: fileName,
        status: state.status));
  }

  Future<void> uploadVideo() async {
    if (state.videoFilePath == null || state.videoFileName.isEmpty) return;

    emit(VideoUploadState(
        videoFilePath: state.videoFilePath,
        videoFileName: state.videoFileName,
        status: UploadStatus.loading));

    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(state.videoFilePath!),
        'filename': state.videoFileName,
      });

      final response = await Dio().post('YOUR_API_ENDPOINT', data: formData);

      if (response.statusCode == 200) {
        emit(VideoUploadState(
            videoFilePath: state.videoFilePath,
            videoFileName: state.videoFileName,
            status: UploadStatus.success));
      } else {
        emit(VideoUploadState(
            videoFilePath: state.videoFilePath,
            videoFileName: state.videoFileName,
            status: UploadStatus.error));
      }
    } catch (e) {
      emit(VideoUploadState(
          videoFilePath: state.videoFilePath,
          videoFileName: state.videoFileName,
          status: UploadStatus.error));
    }
  }
}
