import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:wecos_forum/features/dashboard/domain/entity/post.dart';
import 'package:wecos_forum/features/dashboard/domain/repositories/posts_repository.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc(this.postsRepository) : super(PostsInitialState());

  final PostsRepository postsRepository;

  @override
  Stream<PostsState> mapEventToState(PostsEvent event) async* {
    if (event is PostsLoadEvent) {
      yield* _handleLoadEvent(event);
    } else if (event is PostsLoadMoreEvent) {
      yield* _handleLoadMoreEvent(event);
    }
  }

  Stream<PostsState> _handleLoadEvent(PostsLoadEvent event) async* {
    try {
      yield PostsLoadingState();
      if (postsRepository.initialized)
        yield PostsSuccessState(postsRepository.posts);
      await postsRepository.getPosts();
      yield PostsSuccessState(postsRepository.posts);
    } catch (e) {
      yield PostsErrorState('Something went wrong...');
    }
  }

  Stream<PostsState> _handleLoadMoreEvent(PostsLoadMoreEvent event) async* {
    try {
      if (!postsRepository.canLoadMore) return;
      await postsRepository.getPosts();
      yield PostsSuccessState(postsRepository.posts);
    } catch (e) {
      yield PostsErrorState('Something went wrong...');
    }
  }

  @override
  Future<void> close() async {
    super.close();
  }
}
