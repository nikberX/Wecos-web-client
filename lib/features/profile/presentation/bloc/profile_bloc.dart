import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:wecos_forum/core/service/log_service/logger.dart';
import 'package:wecos_forum/features/authorization/domain/entities/user.dart';
import 'package:wecos_forum/features/profile/domain/repository/profile_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(this.profileRepository) : super(ProfileInitialState());
  ProfileRepository profileRepository;

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is ProfileLoadEvent) {
      yield* _profileLoadEventHandler(event);
    } else if (event is ProfileRefreshEvent) {
      yield* _profileRefreshEventHandler(event);
    }
  }

  Stream<ProfileState> _profileLoadEventHandler(ProfileLoadEvent event) async* {
    yield ProfileLoadingState();
    try {
      await profileRepository.getUser();
      yield ProfileSuccessState(profileRepository.user!);
    } catch (e) {
      yield ProfileErrorState('Ошибка при загрузке профиля');
    }
  }

  Stream<ProfileState> _profileRefreshEventHandler(
      ProfileRefreshEvent event) async* {}

  @override
  void onChange(Change<ProfileState> change) {
    GetIt.I.get<Logger>().debug(change.currentState.runtimeType.toString(),
        change.nextState.runtimeType);
    super.onChange(change);
  }

  @override
  Future<void> close() async {
    super.close();
  }
}
