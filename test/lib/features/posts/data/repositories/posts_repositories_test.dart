import 'package:blog_app/core/error/exceptions.dart';
import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/network/network_info.dart';
import 'package:blog_app/features/posts/data/datasources/posts_remote_data_source.dart';
import 'package:blog_app/features/posts/data/models/post_model.dart';
import 'package:blog_app/features/posts/data/repositories/posts_repository.dart';
import 'package:blog_app/features/posts/domain/entities/post.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'posts_repositories_test.mocks.dart';


@GenerateMocks([BasePostRemoteDataSource, NetworkInfo])
void main() {
  late PostsRepository repository;
  late MockBasePostRemoteDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockBasePostRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = PostsRepository(mockRemoteDataSource, mockNetworkInfo);
  });

  const tPost = Post(
    id: '1',
    title: 'Test Title',
    author: 'Test Author',
    description: 'Test Description',
    publicationDate: '2022-01-01',
    body: 'Test Body',
  );

  const tPostModel = PostModel(
    id: '1',
    title: 'Test Title',
    author: 'Test Author',
    description: 'Test Description',
    publicationDate: '2022-01-01',
    body: 'Test Body',
  );

  group('getAllPosts', () {
    final tPostModelList = [tPostModel];
    final List<Post> tPostList = tPostModelList;

    test('should check if the device is online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getAllPosts()).thenAnswer((_) async => tPostModelList);
      // act
      repository.getAllPosts();
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    test('should return remote data when the device is online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getAllPosts()).thenAnswer((_) async => tPostModelList);
      // act
      final result = await repository.getAllPosts();
      // assert
      verify(mockRemoteDataSource.getAllPosts());
      expect(result, equals(Right(tPostList)));
    });



    test('should return offline failure when the device is offline', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      // act
      final result = await repository.getAllPosts();
      // assert
      verifyZeroInteractions(mockRemoteDataSource);
      expect(result, equals(Left(OfflineFailure())));
    });
  });

  group('createPost', () {
    test('should check if the device is online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.createPost(any)).thenAnswer((_) async => Future.value(unit));
      // act
      repository.createPost(tPost);
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    test('should return remote data when the device is online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.createPost(any)).thenAnswer((_) async => Future.value(unit));
      // act
      final result = await repository.createPost(tPost);
      // assert
      verify(mockRemoteDataSource.createPost(tPostModel));
      expect(result, equals(const Right(unit)));
    });

    test('should return server failure when the device is online and the call to remote data source is unsuccessful', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.createPost(any)).thenThrow(ServerException());
      // act
      final result = await repository.createPost(tPost);
      // assert
      verify(mockRemoteDataSource.createPost(tPostModel));
      expect(result, equals(Left(ServerFailure())));
    });

    test('should return offline failure when the device is offline', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      // act
      final result = await repository.createPost(tPost);
      // assert
      verifyZeroInteractions(mockRemoteDataSource);
      expect(result, equals(Left(OfflineFailure())));
    });
  });

  group('updatePost', () {
    test('should check if the device is online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.updatePost(any)).thenAnswer((_) async => Future.value(unit));
      // act
      repository.updatePost(tPost);
      // assert
      verify(mockNetworkInfo.isConnected);
    });

    test('should return remote data when the device is online', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.updatePost(any)).thenAnswer((_) async => Future.value(unit));
      // act
      final result = await repository.updatePost(tPost);
      // assert
      verify(mockRemoteDataSource.updatePost(tPostModel));
      expect(result, equals(const Right(unit)));
    });

    test('should return server failure when the device is online and the call to remote data source is unsuccessful', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.updatePost(any)).thenThrow(ServerException());
      // act
      final result = await repository.updatePost(tPost);
      // assert
      verify(mockRemoteDataSource.updatePost(tPostModel));
      expect(result, equals(Left(ServerFailure())));
    });

    test('should return offline failure when the device is offline', () async {
      // arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      // act
      final result = await repository.updatePost(tPost);
      // assert
      verifyZeroInteractions(mockRemoteDataSource);
      expect(result, equals(Left(OfflineFailure())));
    });
  });
}
