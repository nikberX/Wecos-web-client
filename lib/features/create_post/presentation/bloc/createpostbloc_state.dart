part of 'createpostbloc_bloc.dart';

abstract class CreatePostState extends Equatable {
  @override
  List<Object> get props => [];
}

class CreatePostInitialState extends CreatePostState {}

class CreatePostLoadingState extends CreatePostState {}

class CreatePostSuccessState extends CreatePostState {}

class CreatePostErrorState extends CreatePostState {
  final String error;

  CreatePostErrorState(this.error);

  @override
  List<Object> get props => [error];
}
