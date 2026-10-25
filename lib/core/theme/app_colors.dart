import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color darkBackground = Color(0xFF121212);
  static const Color lightBackground = Color(0xFFF8F9FA);
  static const Color cardDark = Color(0xFF1E1E1E);
  static const Color cardLight = Colors.white;

  static const List<Color> seeds = [
    Colors.deepPurple,
    Colors.blue,
    Colors.teal,
    Colors.green,
    Colors.orange,
    Colors.pink,
  ];

  static Color seedAt(int index) {
    if (index < 0 || index >= seeds.length) {
      return seeds[0];
    }
    return seeds[index];
  }
}
