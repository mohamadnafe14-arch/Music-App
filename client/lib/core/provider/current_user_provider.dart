import 'package:client/features/auth/model/user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'current_user_provider.g.dart';

@Riverpod(keepAlive: true)
class CurrentUser extends _$CurrentUser {
  @override
  User? build() => null;

  void setCurrentUser(User user) => state = user;
}
