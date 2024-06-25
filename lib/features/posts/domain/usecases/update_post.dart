import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/features/posts/data/repositories/posts_repository.dart';
import 'package:blog_app/features/posts/domain/entities/post.dart';
import 'package:dartz/dartz.dart';



class UpdatePostUsecase {
  final PostsRepository repository;

  UpdatePostUsecase(this.repository);

  Future<Either<Failure, Unit>> call(Post post) async {
    return await repository.updatePost(post);
  }
}