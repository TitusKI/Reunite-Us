import 'package:afalagi/features/post/domain/entities/closed_case_entity.dart';
import 'package:afalagi/features/post/domain/entities/update_post_entity.dart';
import 'package:afalagi/features/post/domain/usecases/close_post.dart';
import 'package:afalagi/features/post/domain/usecases/delete_post.dart';
import 'package:afalagi/features/post/domain/usecases/edit_post_by_id.dart';
import 'package:afalagi/features/post/domain/usecases/get_all_post.dart';
import 'package:afalagi/features/post/domain/usecases/get_my_posts.dart';
import 'package:afalagi/features/post/domain/usecases/get_post_by_id.dart';
import 'package:afalagi/features/post/domain/usecases/get_post_docs.dart';
import 'package:afalagi/features/post/domain/usecases/get_post_images.dart';
import 'package:afalagi/injection_container.dart';
import 'package:afalagi/core/resources/generic_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsCubit extends Cubit<GenericState> {
  // final UserRepository _postApiService;

  PostsCubit() : super(const GenericState());

  Future<void> fetchMyPosts() async {
    try {
      emit(state.copyWith(isLoading: true));
      final posts = await sl<GetMyPostsUsecase>().call();
      emit(state.copyWith(isLoading: false, data: posts));
    } catch (e) {
      emit(state.copyWith(
          isLoading: false, failure: " Failed to load Posts ${e.toString()}"));
    }
  }

  Future<void> fetchAllPosts() async {
    try {
      emit(state.copyWith(isLoading: true, isSuccess: false, failure: null));
      final posts = await sl<GetAllPostUsecase>().call();
      emit(state.copyWith(
          isLoading: false, isSuccess: true, data: posts, failure: null));
    } catch (e) {
      emit(state.copyWith(
          isLoading: false,
          data: null,
          failure: "Failed to load all Missing Persons ${e.toString()}"));
    }
  }

  Future<void> fetchPostById(String id) async {
    try {
      emit(state.copyWith(isLoading: true));
      final posts = await sl<GetPostByIdUsecase>().call(parms: id);
      emit(state.copyWith(data: posts));
    } catch (e) {
      emit(state.copyWith(
          failure: "Failed to load Missing Persons by id ${e.toString()}"));
    }
  }

  Future<void> getPostImages(String id) async {
    try {
      emit(state.copyWith(isLoading: true));
      final images = await sl<GetPostImagesUsecase>().call(parms: id);
      emit(state.copyWith(data: images));
    } catch (e) {
      emit(state.copyWith(failure: "Failed to load images  ${e.toString()}"));
    }
  }

  Future<void> getPostDocs(String id) async {
    try {
      emit(state.copyWith(isLoading: true));
      final docs = await sl<GetPostDocsUsecase>().call(parms: id);
      emit(state.copyWith(data: docs));
    } catch (e) {
      emit(state.copyWith(failure: "Failed to load documents ${e.toString()}"));
    }
  }

  Future<void> editPostById(UpdatePostEntity updates) async {
    try {
      emit(state.copyWith(isLoading: true));
      await sl<EditPostByIdUsecase>().call(parms: updates);
      emit(state.copyWith(isSuccess: true));
    } catch (e) {
      emit(state.copyWith(failure: "Failed to edit posts ${e.toString()}"));
    }
  }

  Future<void> closePost(ClosedCaseEntity updates) async {
    try {
      emit(state.copyWith(isLoading: true));
      await sl<ClosePostUsecase>().call(parms: updates);
      emit(state.copyWith(isSuccess: true));
    } catch (e) {
      emit(state.copyWith(failure: "Failed to close Posts ${e.toString()}"));
    }
  }

  Future<void> deletePost(String id) async {
    try {
      emit(state.copyWith(isLoading: true));
      await (sl<DeletePostUsecase>().call(parms: id));
    } catch (e) {
      emit(
          state.copyWith(failure: "Failed to Delete the post ${e.toString()}"));
    }
  }
}
