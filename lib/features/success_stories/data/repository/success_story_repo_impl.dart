import 'package:afalagi/core/error/failure.dart';
import 'package:afalagi/features/success_stories/data/services/success_story_services.dart';
import 'package:afalagi/features/success_stories/domain/entities/success_story_entity.dart';
import 'package:afalagi/features/success_stories/domain/repository/success_story_repository.dart';
import 'package:afalagi/injection_container.dart';
import 'package:dartz/dartz.dart';

class SuccessStoryRepoImpl implements SuccessStoryRepository {
  @override
  Future<Either<Failure, void>> createSuccessStory(
      SuccessStoryEntity successStory) {
    return sl<SuccessStoryServices>().createSuccessStory(successStory);
  }

  @override
  Future<Either<Failure, SuccessStoryEntity>> getSuccessStoryById(
      String storyId) {
    return sl<SuccessStoryServices>().getSuccessStoryById(storyId);
  }

  @override
  Future<List<SuccessStoryEntity>> getSuccessStories() {
    return sl<SuccessStoryServices>().getSuccessStories();
  }

  @override
  Future<Either<Failure, void>> removeSuccessStory(
      {required SuccessStoryEntity story}) {
    return sl<SuccessStoryServices>().removeSuccessStory(story);
  }
}
