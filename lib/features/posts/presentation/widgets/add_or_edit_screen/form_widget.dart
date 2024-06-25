import 'package:blog_app/features/posts/domain/entities/post.dart';
import 'package:blog_app/features/posts/presentation/provider/posts_provider.dart';
import 'package:blog_app/features/posts/presentation/widgets/add_or_edit_screen/form_submit_button.dart';
import 'package:blog_app/features/posts/presentation/widgets/add_or_edit_screen/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormWidget extends StatefulWidget {
  final bool isUpdatePost;
  final Post? post;
  const FormWidget({
    super.key,
    required this.isUpdatePost,
    this.post,
  });

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _bodyController = TextEditingController();
  TextEditingController _authorController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    if (widget.isUpdatePost) {
      _titleController.text = widget.post!.title;
      _bodyController.text = widget.post!.body;
      _authorController.text = widget.post!.author;
      _descriptionController.text = widget.post!.description;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormFieldWidget(
                name: "Title", multiLines: false, controller: _titleController),
            TextFormFieldWidget(
                name: "author",
                multiLines: false,
                controller: _authorController),
            TextFormFieldWidget(
                name: "description",
                multiLines: false,
                controller: _descriptionController),
            TextFormFieldWidget(
                name: "Body", multiLines: true, controller: _bodyController),
            FormSubmitButton(
                isUpdatePost: widget.isUpdatePost,
                onPressed: validateFormThenUpdateOrAddPost),
          ]),
    );
  }

  void validateFormThenUpdateOrAddPost() {
    final isValid = _formKey.currentState!.validate();
 DateTime currentDate = DateTime.now();
    String formattedDate = '${currentDate.year}-${currentDate.month}-${currentDate.day}';
    if (isValid) {
      final post = Post(
          id: widget.isUpdatePost ? widget.post?.id : null,
          title: _titleController.text,
          body: _bodyController.text,
          author: _authorController.text,
          description: _descriptionController.text,
          publicationDate: widget.isUpdatePost
              ? widget.post!.publicationDate
              : formattedDate);

      if (widget.isUpdatePost) {
        Provider.of<PostProvider>(context, listen: false)
            .updatepost(post, context);
      } else {
        Provider.of<PostProvider>(context, listen: false)
            .addPost(post, context);
      }
    }
  }
}
