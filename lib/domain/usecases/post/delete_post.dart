import 'package:afalagi/core/usecase/usecase.dart';
import 'package:afalagi/domain/repository/post/post_repository.dart';
import 'package:afalagi/injection_container.dart';

class DeletePostUsecase extends Usecase<void, String> {
  @override
  Future<void> call({String? parms}) {
    return sl<PostRepository>().deletePost(parms!);
  }
}
