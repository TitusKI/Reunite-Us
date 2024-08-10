import 'package:afalagi/domain/entities/post/closed_case_entity.dart';
import 'package:afalagi/domain/entities/post/missing_person_entity.dart';
import 'package:afalagi/domain/entities/post/post_docs_entity.dart';
import 'package:afalagi/domain/entities/post/post_images_entity.dart';
import 'package:afalagi/domain/entities/post/update_post_entity.dart';

abstract class PostRepository {
  Future<void> createPost(MissingPersonEntity missingPerson);
  Future<List<MissingPersonEntity>> getMyPosts();
  Future<List<MissingPersonEntity>> getAllPosts();
  Future<MissingPersonEntity> getPostById(String id);
  Future<PostImagesEntity> getPostImages(String id);
  Future<PostDocsEntity> getPostDocs(String id);
  Future<void> editPostById(UpdatePostEntity id);
  Future<void> closePost(ClosedCaseEntity updates);
  Future<void> deletePost(String id);
}
