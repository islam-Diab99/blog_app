import 'package:blog_app/core/network/network_info.dart';
import 'package:blog_app/features/posts/data/datasources/posts_remote_data_source.dart';
import 'package:blog_app/features/posts/data/repositories/posts_repository.dart';
import 'package:blog_app/features/posts/domain/usecases/add_post.dart';
import 'package:blog_app/features/posts/domain/usecases/get_all_posts.dart';
import 'package:blog_app/features/posts/domain/usecases/update_post.dart';
import 'package:blog_app/features/posts/presentation/provider/posts_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final sl = GetIt.instance;

class ServicesLocator {
  void init() {
    /// Provider
    sl.registerFactory(() => PostProvider(sl<GetAllPostsUsecase>(),
        sl<AddPostUsecase>(), sl<UpdatePostUsecase>()));

    /// Use Cases
    sl.registerLazySingleton(() => GetAllPostsUsecase(sl()));
    sl.registerLazySingleton(() => AddPostUsecase(sl()));
    sl.registerLazySingleton(() => UpdatePostUsecase(sl()));

    /// Repository
    sl.registerLazySingleton<PostsRepository>(
        () => PostsRepository(sl(), sl()));

    /// DATA SOURCE
    sl.registerLazySingleton<BasePostRemoteDataSource>(
        () => PostRemoteDataSourceImpl());

    ///core
    sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

    ///network
    sl.registerLazySingleton(() => InternetConnectionChecker());
  }
}
