import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/register.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() {
    return _RegisterScreenState();
  }
}

class _RegisterScreenState extends State<RegisterScreen>{
  final TextEditingController email = TextEditingController();
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();

  Future<Register> loginUser({required String email ,required String username, required String password}) async {
    final response = await http.post(
      Uri.parse('http://192.168.120.96:443/api/v1/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'username': username,
        'password': password,
      }),
    );
    if (response.statusCode == 200) {
      return Register.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to login. Error code: ${response.statusCode}');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }
}