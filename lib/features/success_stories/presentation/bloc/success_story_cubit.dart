import 'package:afalagi/features/success_stories/domain/entities/success_story_entity.dart';
import 'package:afalagi/features/success_stories/domain/usecases/create_success_story.dart';
import 'package:afalagi/features/success_stories/domain/usecases/get_success_stories.dart';
import 'package:afalagi/features/success_stories/domain/usecases/get_success_story_by_id.dart';
import 'package:afalagi/features/success_stories/domain/usecases/remove_success_story.dart';
import 'package:afalagi/injection_container.dart';
import 'package:afalagi/core/resources/generic_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SuccessStoryCubit extends Cubit<GenericState> {
  // final UserRepository _postApiService;

  SuccessStoryCubit() : super(const GenericState());

  Future<void> createSuccessStory(SuccessStoryEntity successStory) async {
    try {
      emit(state.copyWith(isLoading: true));
      final successStoryData =
          await sl<CreateSuccessStoryUsecase>().call(parms: successStory);
      emit(state.copyWith(isLoading: false, data: successStoryData));
    } catch (e) {
      emit(state.copyWith(
          isLoading: false,
          failure: " Failed to create story ${e.toString()}"));
    }
  }

  Future<void> getSuccessStoryById(String storyId) async {
    try {
      emit(state.copyWith(isLoading: true));
      final successStory =
          await sl<GetSuccessStoryByIdUsecase>().call(parms: storyId);
      emit(state.copyWith(data: successStory));
    } catch (e) {
      emit(state.copyWith(
          failure: "Failed to load success story ${e.toString()}"));
    }
  }

  Future<void> getSuccessStories({String? userId}) async {
    try {
      emit(state.copyWith(isLoading: true));
      final result = await sl<GetSuccessStoriesUsecase>().call();

      emit(state.copyWith(
          isSuccess: true, isLoading: false, data: result, failure: null));
    } catch (e) {
      emit(state.copyWith(
          failure: 'Failed to get success stories ${e.toString}'));
    }
  }

  Future<void> removeSuccessStory(SuccessStoryEntity story) async {
    try {
      emit(state.copyWith(isLoading: true));
      final successStory =
          await sl<RemoveSuccessStoryUsecase>().call(parms: story);
      successStory.fold(
          (failure) => emit(state.copyWith(
              isSuccess: false,
              failure: 'Failed to remove story ${failure.toString()}')),
          (_) => emit(state.copyWith(data: successStory, isSuccess: true)));
    } catch (e) {
      emit(state.copyWith(failure: "Failed to remove stories ${e.toString()}"));
    }
  }
}
