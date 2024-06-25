import 'package:blog_app/core/services/services_locator.dart';
import 'package:blog_app/features/posts/presentation/provider/posts_provider.dart';
import 'package:blog_app/features/posts/presentation/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
    WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
  ServicesLocator().init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      lazy: false,
      create: (context) => sl<PostProvider>()..fetchPosts(),

    child: MaterialApp(

      debugShowCheckedModeBanner: false,
        title: 'Blog App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: TextTheme(
            
          )

        ),
        home: const SplashScreen(), 
      ),
    );
  }
}
