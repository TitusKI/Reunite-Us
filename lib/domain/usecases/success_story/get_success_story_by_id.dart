import 'package:afalagi/core/error/failure.dart';
import 'package:afalagi/core/usecase/usecase.dart';
import 'package:afalagi/domain/entities/success_story/success_story_entity.dart';
import 'package:afalagi/domain/repository/success_stories/success_story_repository.dart';
import 'package:afalagi/injection_container.dart';
import 'package:dartz/dartz.dart';

class GetSuccessStoryByIdUsecase
    extends Usecase<Either<Failure, SuccessStoryEntity>, String> {
  @override
  Future<Either<Failure, SuccessStoryEntity>> call({String? parms}) async {
    return await sl<SuccessStoryRepository>().getSuccessStoryById(parms!);
  }
}
