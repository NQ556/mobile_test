import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:mobile_test/core/error/exception.dart';
import 'package:mobile_test/features/auth/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class AuthDatasource {
  Future<UserModel> login({
    required String email,
    required String password,
  });
  Future<UserModel> getUser();
  Future<bool> isLoggedIn();
  Future<void> logout();
}

class AuthDatasourceImpl implements AuthDatasource {
  final SharedPreferences sharedPreferences;

  AuthDatasourceImpl(this.sharedPreferences);

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final String response =
          await rootBundle.loadString('assets/json/mock_users.json');

      final data = json.decode(response) as List;

      final List<UserModel> users =
          data.map((e) => UserModel.fromMap(e)).toList();

      final user = users.firstWhere(
          (user) => user.email == email && user.password == password);

      await sharedPreferences.setString('user', json.encode(user.toJson()));

      return user;
    } catch (e) {
      throw MyException(e.toString());
    }
  }

  @override
  Future<UserModel> getUser() async {
    try {
      final user = await sharedPreferences.getString('user');

      if (user == null) {
        throw MyException("Null");
      }

      return UserModel.fromJson(json.decode(user));
    } catch (e) {
      throw MyException(e.toString());
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    try {
      final user = await sharedPreferences.getString('user');
      return user != null;
    } catch (e) {
      throw MyException(e.toString());
    }
  }

  @override
  Future<void> logout() async {
    try {
      await sharedPreferences.remove('user');
    } catch (e) {
      throw MyException(e.toString());
    }
  }
}
