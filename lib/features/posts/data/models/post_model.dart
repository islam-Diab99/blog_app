import 'package:blog_app/features/posts/domain/entities/post.dart';

class PostModel extends Post {
  const PostModel({
    required super.id,
    required super.title,
    required super.author,
    required super.description,
    required super.publicationDate,
    required super.body,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json["id"],
      title: json["title"],
      author: json["author"],
      description: json["description"],
      publicationDate: json["publication_date"],
      body: json["body"],
    );
  }

  
}
