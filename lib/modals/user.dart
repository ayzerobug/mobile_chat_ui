import 'package:flutter/material.dart';

class User {
  final String? name;
  final String id;
  final String? avatarUrl;
  final bool isOnline;
  final bool isVerified;
  final Color? color;

  User(
      {this.name,
      required this.id,
      this.avatarUrl,
      this.isOnline = false,
      this.isVerified = false,
      this.color});
}
