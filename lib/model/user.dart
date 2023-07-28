import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class User {
  final String email;
  final String password;
  final String token;

  User({
    this.email = "",
    this.password = "",
    this.token = "",
  });

  factory User.fromJson(Map<String, dynamic> json, String token) {
    return User(
      email: json['data']['email'],
      password: json['data']['password'],
      token: token,
    );
  }

  Future<User?> loginUser(String email, String password) async {
    try {
      final uri = Uri.http('10.0.2.2:8000', '/api/login');
      final headers = {
        "Accept": "application/json",
      };

      final body = {
        "email": email,
        "password": password,
      };

      var response = await http.post(
        uri,
        headers: headers,
        body: body,
      );

      final output = jsonDecode(response.body);
      if(response.statusCode == 200) {
        User user = User(
          email: email,
          password: password,
          token: output['token'],
        );
        return user;
      } else {
        return null;
      }
    } catch(e) {
      rethrow;
    }
  }

  Future<bool> resetPassword(String oldPassword, String newPassword, String token) async {
    try {
      final uri = Uri.http('10.0.2.2:8000', '/api/reset-password');
      final headers = {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      };

      final body = {
        "password": oldPassword,
        "password1": newPassword,
      };

      var response = await http.post(
        uri,
        headers: headers,
        body: body,
      );

      if(response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch(e) {
      rethrow;
    }
  }

  Future<bool> logoutUser(String token) async {
    try {
      final uri = Uri.http('10.0.2.2:8000', '/api/logout');
      final headers = {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
      };

      var response = await http.post(
        uri,
        headers: headers,
      );

      if(response.statusCode == 200) {
        Hive.openBox('userData');
        var box = Hive.box('userData');
        box.clear();
        return true;
      } else {
        return false;
      }
    } catch(e) {
      rethrow;
    }
  }
}