import 'package:flutter/material.dart';

class Register {
  String? email;
  String? username;
  String? password;

  Register({this.email, this.username, this.password});

  Register.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    username = json['username'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['username'] = this.username;
    data['password'] = this.password;
    return data;
  }
}