import 'package:flutter/material.dart';
import 'package:blog_app/features/posts/domain/entities/post.dart';
import 'package:blog_app/features/posts/presentation/pages/add_update_screen.dart';
import 'package:blog_app/features/posts/presentation/pages/post_details_screen.dart';

class PostsListWidget extends StatelessWidget {
  final List<Post> posts;

  const PostsListWidget({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return PostListItem(post: post);
      },
    );
  }
}

class PostListItem extends StatelessWidget {
  final Post post;

  const PostListItem({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 4.0,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        title: Text(
          post.title,
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildText('Author: ${post.author}', 16.0, FontWeight.w500),
              const SizedBox(height: 1.0),
              _buildText(post.description, 14.0, null, Colors.grey),
              const SizedBox(height: 2.0),
              _buildText('Publication Date: ${post.publicationDate}', 12.0, null, Colors.grey),
            ],
          ),
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PostDetailsScreen(post: post),
            ),
          );
        },
        trailing: IconButton(
          icon: const Icon(Icons.edit, color: Colors.deepPurpleAccent),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => PostAddUpdatePage(
                  isUpdatePost: true,
                  post: post,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildText(String text, double fontSize, FontWeight? fontWeight, [Color? color]) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}