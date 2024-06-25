
import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/features/posts/data/repositories/posts_repository.dart';
import 'package:dartz/dartz.dart';

import '../entities/post.dart';

class GetAllPostsUsecase {
  final PostsRepository repository;

  GetAllPostsUsecase(this.repository);

  Future<Either<Failure, List<Post>>> call() async {
    return await repository.getAllPosts();
  }
}