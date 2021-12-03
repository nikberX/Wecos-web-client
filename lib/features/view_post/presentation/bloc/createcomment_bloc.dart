import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wecos_forum/core/service/api/api.dart';

part 'createcomment_event.dart';
part 'createcomment_state.dart';

class CreateCommentBloc extends Bloc<CreateCommentEvent, CreateCommentState> {
  CreateCommentBloc(this.api) : super(CreateCommentInitialState());

  Api api;

  @override
  Stream<CreateCommentState> mapEventToState(CreateCommentEvent event) async* {
    if (event is CreateCommentCrearEvent) {
      yield CreateCommentInitialState();
    }
    try {
      yield CreateCommentLoadingState();
      await api.createComment(event.postId, event.imageUrl, event.content);
      yield CreateCommentSuccessState();
    } catch (e) {
      yield CreateCommentErrorState('Ошибка при отправке комментария');
    }
  }

  @override
  Future<void> close() async {
    super.close();
  }
}
