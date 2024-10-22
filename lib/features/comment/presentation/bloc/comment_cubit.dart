import 'package:afalagi/features/comment/domain/entities/edit_comment_entity.dart';
import 'package:afalagi/features/comment/domain/entities/post_comment_entity.dart';
import 'package:afalagi/features/comment/domain/entities/story_comment_entity.dart';
import 'package:afalagi/features/comment/domain/usecases/create_post_comment.dart';
import 'package:afalagi/features/comment/domain/usecases/create_story_comment.dart';
import 'package:afalagi/features/comment/domain/usecases/edit_comment.dart';
import 'package:afalagi/features/comment/domain/usecases/toggle_like_story.dart';
import 'package:afalagi/injection_container.dart';
import 'package:afalagi/core/resources/generic_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentCubit extends Cubit<GenericState> {
  CommentCubit() : super(const GenericState());

  Future<void> createPostComment(PostCommentEntity comment) async {
    emit(state.copyWith(isLoading: true));
    final result = await CreatePostCommentUsecase().call(parms: comment);
    result.fold(
        (failure) => emit(state.copyWith(
            failure: "Failed to post comment", isLoading: false)),
        (_) => emit(state.copyWith(data: result, isSuccess: true)));
  }

  Future<void> createStoryComment(StoryCommentEntity comment) async {
    emit(state.copyWith(isLoading: true));
    final result = await sl<CreateStoryCommentUsecase>().call(parms: comment);
    result.fold(
        (failure) =>
            emit(state.copyWith(failure: "Failed to send comment to story")),
        (_) => emit(
            state.copyWith(isLoading: false, isSuccess: false, data: result)));
  }

  Future<void> editComment(EditCommentEntity comment) async {
    emit(state.copyWith(isLoading: true, isSuccess: false, failure: ''));
    final result = await sl<EditCommentUsecase>().call(parms: comment);
    result.fold(
        (failure) => emit(state.copyWith(
            isLoading: false,
            isSuccess: false,
            failure: 'Failed to edit comment')),
        (_) => state.copyWith(
              data: result,
              isLoading: false,
              isSuccess: true,
            ));
  }

  Future<void> toggleLikeStory(String id) async {
    emit(state.copyWith(isLoading: true));
    final result = await sl<ToggleLikeStoryUsecase>().call(parms: id);
    result.fold(
        (failure) => emit(state.copyWith(failure: 'Failed to like the story')),
        (_) => state.copyWith(isSuccess: true, data: result));
  }
}
