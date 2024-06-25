import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/core/network/api_constance.dart';
import 'package:blog_app/features/posts/data/models/post_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class BasePostRemoteDataSource {
  Future<List<PostModel>> getAllPosts();
  Future<Unit> updatePost(PostModel postModel);
  Future<Unit> createPost(PostModel postModel);
}

class PostRemoteDataSourceImpl extends BasePostRemoteDataSource {
  @override
  Future<List<PostModel>> getAllPosts() async {
    final response = await Dio().get(ApiConstance.getAllPostsPath);

    if (response.statusCode == 200) {
      return List<PostModel>.from((response.data as List).map(
        (e) => PostModel.fromJson(e),
      ));
    } else {
      throw ServerException();
    }
  }



  @override
  Future<Unit> createPost(PostModel postModel) async {
    final body = {
      "title": postModel.title,
      "author": postModel.author,
      "description": postModel.description,
      "publication_date": postModel.publicationDate,
      "body": postModel.body,
    };

    final response = await Dio().post(ApiConstance.createPostPath, data: body);

    if (response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePost(PostModel postModel) async {
    final body = {
      "title": postModel.title,
      "author": postModel.author,
      "description": postModel.description,
      "publication_date": postModel.publicationDate,
      "body": postModel.body
    };

    final response = await Dio()
        .patch(ApiConstance.updatePostPath(postModel.id), data: body);

    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
