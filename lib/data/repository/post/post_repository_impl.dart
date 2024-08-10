import 'package:afalagi/data/services/remote/post_services.dart';
import 'package:afalagi/domain/entities/post/closed_case_entity.dart';
import 'package:afalagi/domain/entities/post/missing_person_entity.dart';
import 'package:afalagi/domain/entities/post/post_docs_entity.dart';
import 'package:afalagi/domain/entities/post/post_images_entity.dart';
import 'package:afalagi/domain/entities/post/update_post_entity.dart';
import 'package:afalagi/domain/repository/post/post_repository.dart';
import 'package:afalagi/injection_container.dart';

class PostRepositoryImpl extends PostRepository {
  // final PostServices _PostServices;
  // PostRepositoryImpl(this._PostServices);

  @override
  Future<void> createPost(MissingPersonEntity missingPerson) async {
    return await sl<PostServices>().createPost(missingPerson);
  }

  @override
  Future<List<MissingPersonEntity>> getMyPosts() async {
    return await sl<PostServices>().getMyPosts();
  }

  @override
  Future<List<MissingPersonEntity>> getAllPosts() async {
    return await sl<PostServices>().getAllPosts();
  }

  @override
  Future<void> closePost(ClosedCaseEntity updates) {
    return sl<PostServices>().closePost(updates);
  }

  @override
  Future<void> deletePost(String id) {
    return sl<PostServices>().deletePost(id);
  }

  @override
  Future<void> editPostById(UpdatePostEntity updates) {
    return sl<PostServices>().editPostById(updates);
  }

  @override
  Future<MissingPersonEntity> getPostById(String id) {
    return sl<PostServices>().getPostById(id);
  }

  @override
  Future<PostDocsEntity> getPostDocs(String id) {
    return sl<PostServices>().getPostDocs(id);
  }

  @override
  Future<PostImagesEntity> getPostImages(String id) {
    return sl<PostServices>().getPostImages(id);
  }
}
