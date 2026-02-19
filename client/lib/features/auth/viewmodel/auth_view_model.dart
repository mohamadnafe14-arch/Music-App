import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_view_model.g.dart';
@riverpod
class AuthViewModel extends _$AuthViewModel {
  @override
  AsyncValue build() {
    return const AsyncValue.data(null);
  }
}