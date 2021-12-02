import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:wecos_forum/core/service/log_service/logger.dart';
import 'package:wecos_forum/features/view_post/domain/entity/post_with_comments.dart';
import 'package:wecos_forum/features/view_post/domain/repositories/viewpost_repository.dart';

part 'viewpost_event.dart';
part 'viewpost_state.dart';

class ViewPostBloc extends Bloc<ViewPostEvent, ViewPostState> {
  ViewPostBloc(this._viewPostRepository) : super(ViewPostInitialState());

  final ViewPostRepository _viewPostRepository;

  @override
  Stream<ViewPostState> mapEventToState(ViewPostEvent event) async* {
    if (event is ViewPostLoadEvent) {
      yield* _loadEventHandler(event);
    } else if (event is ViewPostRefreshEvent) {}
  }

  Stream<ViewPostState> _loadEventHandler(ViewPostLoadEvent event) async* {
    yield ViewPostLoadingState();
    try {
      await _viewPostRepository.getPost(event.postId);

      GetIt.I.get<Logger>().success('loaded', true);
      yield ViewPostSuccessState(_viewPostRepository.postWithComment!);
    } catch (e) {
      GetIt.I.get<Logger>().error('error', e);
      yield ViewPostErrorState('Произошла ошибка при загрузке страницы...');
    }
  }

  Stream<ViewPostState> _refreshEventHandler(
      ViewPostRefreshEvent event) async* {}

  @override
  void onChange(Change<ViewPostState> change) {
    GetIt.I
        .get<Logger>()
        .debug(change.currentState.runtimeType.toString(), change.nextState);
    super.onChange(change);
  }

  @override
  Future<void> close() async {
    super.close();
  }
}
