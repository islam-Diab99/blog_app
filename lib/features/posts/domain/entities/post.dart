import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final String? id;
  final String title;
  final String author;
  final String description;
  final String body;
  final String publicationDate;

  const Post({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.publicationDate,
    required this.body,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        author,
        description,
        publicationDate,
        body,
      ];
}
