import 'package:afalagi/core/error/failure.dart';
import 'package:afalagi/core/usecase/usecase.dart';
import 'package:afalagi/domain/entities/success_story/success_story_entity.dart';
import 'package:afalagi/domain/repository/success_stories/success_story_repository.dart';
import 'package:afalagi/injection_container.dart';
import 'package:dartz/dartz.dart';

class RemoveSuccessStoryUsecase
    extends Usecase<Either<Failure, void>, SuccessStoryEntity> {
  @override
  Future<Either<Failure, void>> call({SuccessStoryEntity? parms}) async {
    return await sl<SuccessStoryRepository>().removeSuccessStory(story: parms!);
  }
}
