part of 'posts_bloc.dart';

abstract class PostsState extends Equatable {
  @override
  List<Object> get props => [];
}

class PostsInitialState extends PostsState {}

class PostsLoadingState extends PostsState {}

class PostsLoadingMoreState extends PostsState {
  final List<Post> posts;

  PostsLoadingMoreState(this.posts);

  @override
  List<Object> get props => [posts.length];
}

class PostsSuccessState extends PostsState {
  final List<Post> posts;

  PostsSuccessState(this.posts);

  @override
  List<Object> get props => [posts.length];
}

class PostsErrorState extends PostsState {
  final String error;

  PostsErrorState(this.error);

  @override
  List<Object> get props => [error];
}
