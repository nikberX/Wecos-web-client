part of 'createpostbloc_bloc.dart';

class CreatePostEvent extends Equatable {
  final String imageUrl;
  final String title;
  final String content;

  CreatePostEvent(this.imageUrl, this.title, this.content);

  @override
  List<Object> get props => [imageUrl, title, content];
}
