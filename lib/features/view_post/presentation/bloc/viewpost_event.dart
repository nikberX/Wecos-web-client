part of 'viewpost_bloc.dart';

abstract class ViewPostEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ViewPostLoadEvent extends ViewPostEvent {
  final String postId;

  ViewPostLoadEvent(this.postId);

  @override
  List<Object> get props => [];
}

class ViewPostRefreshEvent extends ViewPostEvent {
  @override
  List<Object> get props => [];
}
