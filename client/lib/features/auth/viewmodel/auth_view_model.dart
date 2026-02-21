import 'package:client/features/auth/model/user.dart';
import 'package:client/features/auth/repos/auth_local_repo.dart';
import 'package:client/features/auth/repos/remote_auth_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_view_model.g.dart';

@Riverpod(keepAlive: true)
class AuthViewModel extends _$AuthViewModel {
  late RemoteAuthRepo remoteAuthRepo;
  late AuthLocalRepo authLocalRepo;
  @override
  AsyncValue<User?> build() {
    remoteAuthRepo = ref.watch(remoteAuthRepoProvider);
    authLocalRepo = ref.watch(authLocalRepoProvider);
    return const AsyncValue.data(null);
  }

  Future<void> signIn({required String email, required String password}) async {
    state = const AsyncLoading();
    final result = await remoteAuthRepo.signIn(email, password);
    result.match((l) {
      state = AsyncValue.error(l.message, StackTrace.current);
    }, (r) async {
      await authLocalRepo.saveToken(r.token);
      state = AsyncValue.data(r);
    });
  }

  Future<void> signUp(
      {required String email,
      required String password,
      required String name}) async {
    state = const AsyncLoading();
    final result = await remoteAuthRepo.signUp(email, password, name);
    result.match((l) {
      state = AsyncValue.error(l.message, StackTrace.current);
    }, (r) async {
      await authLocalRepo.saveToken(r.token);
      state = AsyncValue.data(r);
    });
  }

  Future<void> getUser() async {
    state = const AsyncLoading();
    final token = await authLocalRepo.getToken();
    final result = await remoteAuthRepo.getCurrentUser(token: token);
    result.fold(
      (l) {
        state = AsyncValue.error(l.message, StackTrace.current);
      },
      (r) {
        state = AsyncValue.data(r);
      },
    );
  }

  Future<void> initSharedPref() async {
    await authLocalRepo.init();
  }
}
