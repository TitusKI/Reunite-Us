import 'package:afalagi/core/constants/data_export.dart';
import 'package:afalagi/core/constants/domain_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // Ensure binding is initialized
  // Local Data Source Register
  sl.registerSingleton<StorageService>(await StorageService().init());

  // Services Register
  sl.registerSingleton<AuthServices>(AuthServices(sl()));
  sl.registerSingleton<UserServices>(UserServices(sl()));
  sl.registerSingleton<PostServices>(PostServices(sl()));
  sl.registerSingleton<SuccessStoryServices>(SuccessStoryServices(sl()));
  sl.registerSingleton<CommentServices>(CommentServices(sl()));

  // Repository Register
  sl.registerSingleton<UserRepository>(UserRepositoryImpl(sl()));
  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  sl.registerSingleton<PostRepository>(PostRepositoryImpl());
  sl.registerSingleton<SuccessStoryRepository>(SuccessStoryRepoImpl());
  sl.registerSingleton<CommentRepository>(CommentRepositoryImpl());

  // Auth Usecases Register
  sl.registerSingleton<SignInUseCase>(SignInUseCase());
  sl.registerSingleton<SignUpUsecase>(SignUpUsecase());
  sl.registerSingleton<SignOutUsecase>(SignOutUsecase());
  sl.registerSingleton<VerifyCodeUsecase>(VerifyCodeUsecase());
  sl.registerSingleton<RefreshTokenUsecase>(RefreshTokenUsecase());
  sl.registerSingleton<ForgotPasswordUsecase>(ForgotPasswordUsecase());
  sl.registerSingleton<ResendCodeUsecase>(ResendCodeUsecase());

  // Post Usecases Register
  sl.registerSingleton<CreatePostUsecase>(CreatePostUsecase());
  sl.registerSingleton<GetAllPostUsecase>(GetAllPostUsecase());
  sl.registerSingleton<GetMyPostsUsecase>(GetMyPostsUsecase());
  sl.registerSingleton<GetPostByIdUsecase>(GetPostByIdUsecase());
  sl.registerSingleton<GetPostImagesUsecase>(GetPostImagesUsecase());
  sl.registerSingleton<GetPostDocsUsecase>(GetPostDocsUsecase());
  sl.registerSingleton<EditPostByIdUsecase>(EditPostByIdUsecase());
  sl.registerSingleton<ClosePostUsecase>(ClosePostUsecase());
  sl.registerSingleton<DeletePostUsecase>(DeletePostUsecase());

  // User Usecases Register
  sl.registerSingleton<BuildUserProfileUsecase>(BuildUserProfileUsecase());
  sl.registerSingleton<DeleteProfilePicUsecase>(DeleteProfilePicUsecase());
  sl.registerSingleton<FetchProfilePicUsecase>(FetchProfilePicUsecase());
  sl.registerSingleton<FetchUserProfileUsecase>(FetchUserProfileUsecase());
  sl.registerSingleton<UpdateProfilePicUsecase>(UpdateProfilePicUsecase());
  sl.registerSingleton<UpdateUserProfileUsecase>(UpdateUserProfileUsecase());

  // Success Story Usecases Register
  sl.registerSingleton<CreateSuccessStoryUsecase>(CreateSuccessStoryUsecase());
  sl.registerSingleton<GetSuccessStoryByIdUsecase>(
      GetSuccessStoryByIdUsecase());
  sl.registerSingleton<GetSuccessStoriesUsecase>(GetSuccessStoriesUsecase());
  sl.registerSingleton<RemoveSuccessStoryUsecase>(RemoveSuccessStoryUsecase());

  // Comment Usecases Register
  sl.registerSingleton<CreatePostCommentUsecase>(CreatePostCommentUsecase());
  sl.registerSingleton<CreateStoryCommentUsecase>(CreateStoryCommentUsecase());
  sl.registerSingleton<EditCommentUsecase>(EditCommentUsecase());
  sl.registerSingleton<ToggleLikeStoryUsecase>(ToggleLikeStoryUsecase());
}
