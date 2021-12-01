import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:wecos_forum/core/service/api/api.dart';

part 'createpostbloc_event.dart';
part 'createpostbloc_state.dart';

class CreatePostBloc extends Bloc<CreatePostEvent, CreatePostState> {
  CreatePostBloc(this.api) : super(CreatePostInitialState());

  Api api;

  @override
  Stream<CreatePostState> mapEventToState(CreatePostEvent event) async* {
    if (event is CreatePostEvent) {
      yield CreatePostLoadingState();
      try {} on DioError catch (e) {
      } catch (e) {}
    }
  }

  @override
  Future<void> close() async {
    super.close();
  }
}
