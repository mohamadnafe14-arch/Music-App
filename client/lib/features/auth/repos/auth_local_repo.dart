import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'auth_local_repo.g.dart';
@riverpod
AuthLocalRepo authLocalRepo(AuthLocalRepoRef ref) => AuthLocalRepo();
class AuthLocalRepo {
late  SharedPreferences prefs;
Future<void> init() async {
  prefs = await SharedPreferences.getInstance();
}
  Future<void> saveToken(String token) async {
    await prefs.setString('token', token);
  }

  Future<String?> getToken() async {
    return prefs.getString('token');
  }
}