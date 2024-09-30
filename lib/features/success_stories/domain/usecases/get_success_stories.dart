import 'package:afalagi/core/usecase/usecase.dart';
import 'package:afalagi/features/success_stories/domain/entities/success_story_entity.dart';
import 'package:afalagi/features/success_stories/domain/repository/success_story_repository.dart';
import 'package:afalagi/injection_container.dart';

class GetSuccessStoriesUsecase extends Usecase<List<SuccessStoryEntity>, void> {
  @override
  Future<List<SuccessStoryEntity>> call({void parms}) async {
    return await sl<SuccessStoryRepository>().getSuccessStories();
  }
}
