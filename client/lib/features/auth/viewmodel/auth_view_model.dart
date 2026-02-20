import 'package:client/features/auth/model/user.dart';
import 'package:client/features/auth/repos/remote_auth_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_view_model.g.dart';

@riverpod
class AuthViewModel extends _$AuthViewModel {
  late RemoteAuthRepo remoteAuthRepo;
  @override
  AsyncValue<User?> build() {
    remoteAuthRepo = ref.watch(remoteAuthRepoProvider);
    return const AsyncValue.data(null);
  }

  Future<void> signIn({required String email, required String password}) async {
    state = const AsyncLoading();
    final result = await remoteAuthRepo.signIn(email, password);
    result.fold((l) {
      state = AsyncValue.error(l.message, StackTrace.current);
    }, (r) {
      state = AsyncValue.data(r);
    });
  }

  Future<void> signUp(
      {required String email,
      required String password,
      required String name}) async {
    state = const AsyncLoading();
    final result = await remoteAuthRepo.signUp(email, password, name);
    result.fold((l) {
      state = AsyncValue.error(l, StackTrace.current);
    }, (r) {
      state = AsyncValue.data(r);
    });
  }
}
