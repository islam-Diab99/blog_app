import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/features/posts/domain/entities/post.dart';
import 'package:dartz/dartz.dart';

abstract class BasePostsRepository {
  Future<Either<Failure, List<Post>>> getAllPosts();

  Future<Either<Failure, Unit>> updatePost(Post post);

  Future<Either<Failure, Unit>> createPost(Post post);


}