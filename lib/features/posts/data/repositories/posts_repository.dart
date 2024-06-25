import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/network/network_info.dart';
import 'package:blog_app/features/posts/data/datasources/posts_remote_data_source.dart';
import 'package:blog_app/features/posts/data/models/post_model.dart';
import 'package:blog_app/features/posts/domain/entities/post.dart';
import 'package:blog_app/features/posts/domain/repositories/base_post_repositorry.dart';
import 'package:dartz/dartz.dart';

typedef UpdateOrAddPost = Future<Unit> Function();

class PostsRepository extends BasePostsRepository {
  final BasePostRemoteDataSource postRemoteDataSource;
  final NetworkInfo networkInfo;

  PostsRepository(this.postRemoteDataSource, this.networkInfo);

  @override
  Future<Either<Failure, Unit>> createPost(Post post) async {
    final PostModel postModel = PostModel(
        id: post.id,
        title: post.title,
        author: post.author,
        description: post.description,
        publicationDate: post.publicationDate,
        body: post.body);
    return await _getMessage(() {
      return postRemoteDataSource.createPost(postModel);
    });
  }

  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    if (await networkInfo.isConnected) {
      final result = await postRemoteDataSource.getAllPosts();
      try {
        return Right(result);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async {
    final PostModel postModel = PostModel(
      id: post.id,
      title: post.title,
      author: post.author,
      description: post.description,
      publicationDate: post.publicationDate,
      body: post.body,
    );

    return await _getMessage(() {
      return postRemoteDataSource.updatePost(postModel);
    });
  }

  Future<Either<Failure, Unit>> _getMessage(
      UpdateOrAddPost updateOrAddPost) async {
    if (await networkInfo.isConnected) {
      try {
        await updateOrAddPost();
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
