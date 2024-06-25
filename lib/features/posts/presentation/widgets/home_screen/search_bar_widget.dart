import 'package:blog_app/features/posts/presentation/provider/posts_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search by title or author...',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: const BorderSide(
      color: Colors.grey,
      width: 1.0,
    ),
              ),
      ),
      onChanged: (query) {
        Provider.of<PostProvider>(context, listen: false)
            .filterPosts(query);
      },
    );
  }
}