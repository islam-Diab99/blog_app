import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/features/posts/domain/entities/post.dart';
import 'package:blog_app/features/posts/domain/usecases/add_post.dart';
import 'package:blog_app/features/posts/domain/usecases/get_all_posts.dart';
import 'package:blog_app/features/posts/domain/usecases/update_post.dart';
import 'package:blog_app/features/posts/presentation/provider/posts_provider.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'post_provider_test.mocks.dart';

@GenerateMocks([GetAllPostsUsecase, AddPostUsecase, UpdatePostUsecase])
void main() {
  late PostProvider provider;
  late MockGetAllPostsUsecase mockGetAllPostsUsecase;
  late MockAddPostUsecase mockAddPostUsecase;
  late MockUpdatePostUsecase mockUpdatePostUsecase;

  setUp(() {
    mockGetAllPostsUsecase = MockGetAllPostsUsecase();
    mockAddPostUsecase = MockAddPostUsecase();
    mockUpdatePostUsecase = MockUpdatePostUsecase();
    provider = PostProvider(
      mockGetAllPostsUsecase,
      mockAddPostUsecase,
      mockUpdatePostUsecase,
    );
  });

  final tPost = Post(
    id: '1',
    title: 'Test Title',
    author: 'Test Author',
    description: 'Test Description',
    publicationDate: '2022-01-01',
    body: 'Test Body',
  );

  final List<Post> tPosts = [tPost];

  group('fetchPosts', () {
    test('should set isLoading to true and then to false', () async {
      // arrange
      when(mockGetAllPostsUsecase.call()).thenAnswer((_) async => Right(tPosts));
      // act
      final fetchPostsFuture = provider.fetchPosts();
      expect(provider.isLoading, true);
      await fetchPostsFuture;
      // assert
      expect(provider.isLoading, false);
    });

    test('should populate posts on successful data fetch', () async {
      // arrange
      when(mockGetAllPostsUsecase.call()).thenAnswer((_) async => Right(tPosts));
      // act
      await provider.fetchPosts();
      // assert
      expect(provider.posts, tPosts);
      expect(provider.filterdPosts, tPosts);
    });

    test('should handle failure on data fetch', () async {
      // arrange
      when(mockGetAllPostsUsecase.call()).thenAnswer((_) async => Left(ServerFailure()));
      // act
      await provider.fetchPosts();
      // assert
      expect(provider.posts, []);
      expect(provider.filterdPosts, []);
    });
  });



  group('filterPosts', () {
    test('should filter posts based on query', () async {
      // arrange
      when(mockGetAllPostsUsecase.call()).thenAnswer((_) async => Right(tPosts));
      await provider.fetchPosts();
      // act
      provider.filterPosts('Test');
      // assert
      expect(provider.filterdPosts, tPosts);
    });

    test('should reset filtered posts if query is empty', () async {
      // arrange
      when(mockGetAllPostsUsecase.call()).thenAnswer((_) async => Right(tPosts));
      await provider.fetchPosts();
      // act
      provider.filterPosts('');
      // assert
      expect(provider.filterdPosts, tPosts);
    });
  });
}

class MockBuildContext extends Mock implements BuildContext {}
