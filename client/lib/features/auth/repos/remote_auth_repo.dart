import 'dart:convert';

import 'package:client/core/constants/server_constans.dart';
import 'package:client/core/errors/failure.dart';
import 'package:client/features/auth/model/user.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;

class RemoteAuthRepo {
  Future<Either<Failure, User>> signIn(String email, String password) async {
    final response = await http.post(
      Uri.parse('$kBaseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    final data = jsonDecode(response.body) as Map<String, dynamic>;
    if (response.statusCode == 200) {
      return right(User.fromMap(data));
    } else {
      return left(Failure(message: data['details']));
    }
  }

  Future<Either<Failure, User>> signUp(
    String email,
    String password,
    String name,
  ) async {
    final response = await http.post(
      Uri.parse('$kBaseUrl/auth/signup'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password, 'name': name}),
    );
    final data = jsonDecode(response.body) as Map<String, dynamic>;
    if (response.statusCode == 201) {
      return right(User.fromMap(data));
    } else {
      return left(Failure(message: data['details']));
    }
  }
}
