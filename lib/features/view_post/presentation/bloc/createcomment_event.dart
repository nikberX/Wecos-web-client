part of 'createcomment_bloc.dart';

class CreateCommentEvent extends Equatable {
  final String postId;
  final String content;
  final String imageUrl;
  CreateCommentEvent(this.content, this.imageUrl, this.postId);

  @override
  List<Object> get props => [];
}

class CreateCommentCrearEvent extends CreateCommentEvent {
  CreateCommentCrearEvent(String content, String imageUrl, String postId)
      : super(content, imageUrl, postId);
  CreateCommentCrearEvent.empty() : super('', '', '');
}
