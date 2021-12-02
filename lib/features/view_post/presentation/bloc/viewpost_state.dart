part of 'viewpost_bloc.dart';

abstract class ViewPostState extends Equatable {
  @override
  List<Object> get props => [];
}

class ViewPostInitialState extends ViewPostState {}

class ViewPostLoadingState extends ViewPostState {}

class ViewPostSuccessState extends ViewPostState {
  final PostWithComment post;
  ViewPostSuccessState(this.post);
}

class ViewPostErrorState extends ViewPostState {
  final String error;

  ViewPostErrorState(this.error);

  @override
  List<Object> get props => [error];
}
