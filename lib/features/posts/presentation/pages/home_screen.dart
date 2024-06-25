import 'package:blog_app/features/posts/presentation/widgets/home_screen/Posts_list_widget.dart';
import 'package:blog_app/features/posts/presentation/widgets/home_screen/search_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blog_app/features/posts/domain/entities/post.dart';
import 'package:blog_app/features/posts/presentation/provider/posts_provider.dart';
import 'package:blog_app/features/posts/presentation/pages/add_update_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: SearchBarWidget(),
              ),
              Expanded(
                child: Selector<PostProvider, List<Post>>(
                  selector: (context, postProvider) => postProvider.filterdPosts,
                  builder: (context, posts, child) {
                    if (posts.isEmpty) {
                      return const Center(child: Text('No posts available.'));
                    } else {
                      return PostsListWidget(
                        posts: posts,
                      );
                    }
                  },
                ),
              ),
            ],
          ),
           Provider.of<PostProvider>(context, listen: true).isLoading == true
              ? Center(
                  child: CircularProgressIndicator(
                    color: Colors.deepPurpleAccent,
                  ),
                )
              : SizedBox(
                  height: 0,
                ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const PostAddUpdatePage(
                isUpdatePost: false,
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
