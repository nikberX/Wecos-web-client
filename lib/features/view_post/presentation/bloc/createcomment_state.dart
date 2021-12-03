part of 'createcomment_bloc.dart';

abstract class CreateCommentState extends Equatable {
  @override
  List<Object> get props => [];
}

class CreateCommentInitialState extends CreateCommentState {}

class CreateCommentLoadingState extends CreateCommentState {}

class CreateCommentSuccessState extends CreateCommentState {}

class CreateCommentErrorState extends CreateCommentState {
  final String error;

  CreateCommentErrorState(this.error);

  @override
  List<Object> get props => [error];
}
