import 'package:afalagi/core/error/failure.dart';
import 'package:afalagi/features/success_stories/domain/entities/success_story_entity.dart';
import 'package:dartz/dartz.dart';

abstract class SuccessStoryRepository {
  Future<Either<Failure, void>> createSuccessStory(
      SuccessStoryEntity successStory);
  Future<Either<Failure, SuccessStoryEntity>> getSuccessStoryById(
      String storyId);
  Future<List<SuccessStoryEntity>> getSuccessStories();
  Future<Either<Failure, void>> removeSuccessStory(
      {required SuccessStoryEntity story});
}
