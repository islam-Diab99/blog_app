import 'package:blog_app/core/network/api_constance.dart';
import 'package:blog_app/features/posts/data/datasources/posts_remote_data_source.dart';
import 'package:blog_app/features/posts/data/models/post_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'posts_remote_data_source_test.mocks.dart';


@GenerateMocks([Dio])
void main() {
  late PostRemoteDataSourceImpl dataSource;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    dataSource = PostRemoteDataSourceImpl();
  });

  group('getAllPosts', () {
    final tPostModel = PostModel(
      id: '',
      title: 'Test Title',
      author: 'Test Author',
      description: 'Test Description',
      publicationDate: '2022-01-01',
      body: 'Test Body',
    );
   

 



    test('should return unit when the response code is 201', () async {
      // arrange
      when(mockDio.post(ApiConstance.createPostPath, data: anyNamed('data')))
          .thenAnswer((_) async => Response(
                statusCode: 201,
                requestOptions: RequestOptions(path: ApiConstance.createPostPath),
              ));
      // act
      final result = await dataSource.createPost(tPostModel);
      // assert
      expect(result, equals(unit));
    });

    
  });

  group('updatePost', () {
    final tPostModel = PostModel(
      id: '1',
      title: 'Test Title',
      author: 'Test Author',
      description: 'Test Description',
      publicationDate: '2022-01-01',
      body: 'Test Body',
    );

    test('should return unit when the response code is 200', () async {
      // arrange
      when(mockDio.patch(ApiConstance.updatePostPath(tPostModel.id), data: anyNamed('data')))
          .thenAnswer((_) async => Response(
                statusCode: 200,
                requestOptions: RequestOptions(path: ApiConstance.updatePostPath(tPostModel.id)),
              ));
      // act
      final result = await dataSource.updatePost(tPostModel);
      // assert
      expect(result, equals(unit));
    });


  });
}
