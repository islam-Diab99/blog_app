import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/utils/failures.dart';
import 'package:blog_app/features/posts/domain/entities/post.dart';
import 'package:blog_app/features/posts/domain/usecases/add_post.dart';
import 'package:blog_app/features/posts/domain/usecases/get_all_posts.dart';
import 'package:blog_app/features/posts/domain/usecases/update_post.dart';
import 'package:flutter/material.dart';

class PostProvider with ChangeNotifier {
  final GetAllPostsUsecase getAllPostsUseCase;
  final AddPostUsecase createPostUseCase;
  final UpdatePostUsecase updatePostUseCase;

  List<Post> _posts = [];
  List<Post> _filterdPosts = [];
  bool _isLoading = false;

  PostProvider(
      this.getAllPostsUseCase, this.createPostUseCase, this.updatePostUseCase);

  List<Post> get posts => _posts;
  List<Post> get filterdPosts => _filterdPosts;
  bool get isLoading => _isLoading;

  Future<void> fetchPosts() async {
    _isLoading = true;
    notifyListeners();

    final result = await getAllPostsUseCase();
    result.fold(
      (failure) {
        _isLoading = false;
        notifyListeners();
      },
      (posts) {
        _posts = posts;
        _filterdPosts = posts;
        
        _isLoading = false;
        
        notifyListeners();
      },
    );
  }

  Future<void> addPost(Post post, context) async {
    _isLoading = true;
    notifyListeners();

    final result = await createPostUseCase(post);
    result.fold(
      (failure) {
        _isLoading = false;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(_mapFailureToMessage(failure)),
          ),
        );
        notifyListeners();
      },
      (newPost) {
        _isLoading = false;
        notifyListeners();
        fetchPosts();
        Navigator.pop(context);
      },
    );
  }

  Future<void> updatepost(Post post, context) async {
    _isLoading = true;
    notifyListeners();

    final result = await updatePostUseCase(post);
    result.fold(
      (failure) {
        _isLoading = false;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(_mapFailureToMessage(failure)),
          ),
        );
        notifyListeners();
      },
      (newPost) {
        _isLoading = false;
        notifyListeners();
        fetchPosts();
        Navigator.pop(context);
      },
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;

      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Unexpected Error , Please try again later .";
    }
  }


  void filterPosts(String query) {
    if (query == '') {
      _filterdPosts = posts;
    }
    _filterdPosts = _posts.where((post) {
      return post.title.toLowerCase().contains(query.toLowerCase()) ||
          post.author.toLowerCase().contains(query.toLowerCase());
    }).toList();
    notifyListeners();
  }
}
