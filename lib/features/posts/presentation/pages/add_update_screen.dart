import 'package:blog_app/features/posts/domain/entities/post.dart';
import 'package:blog_app/features/posts/presentation/provider/posts_provider.dart';
import 'package:blog_app/features/posts/presentation/widgets/add_or_edit_screen/form_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostAddUpdatePage extends StatelessWidget {
  final Post? post;
  final bool isUpdatePost;
  const PostAddUpdatePage({Key? key, this.post, required this.isUpdatePost})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppbar() {
    return AppBar(title: Text(isUpdatePost ? "Edit Post" : "Add Post"));
  }

  Widget _buildBody(context) {
    
    return SingleChildScrollView(
      child: Stack(
        alignment: Alignment.center,
        children: [
    
          Center(
            child: Padding(
                padding: EdgeInsets.all(10),
                child: FormWidget(
                    isUpdatePost: isUpdatePost,
                    post: isUpdatePost ? post : null)),
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
    );
  }
}
