import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFFF97316);
  static const Color primaryLight = Color(0xFFFB923C);
  static const Color primaryDark = Color(0xFFEA580C);
  static const Color accent = Color(0xFFFB7185);
  static const Color background = Color(0xFFFFF7ED);
  static const Color cardBackground = Colors.white;
  static const Color textPrimary = Color(0xFF1F2937);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textLight = Color(0xFF9CA3AF);
  static const Color border = Color(0xFFFED7AA);
  static const Color borderLight = Color(0xFFFFEDD5);
  
  static const LinearGradient warmGradient = LinearGradient(
    colors: [Color(0xFFFB923C), Color(0xFFFB7185)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
  
  static const LinearGradient imageOverlay = LinearGradient(
    colors: [Colors.transparent, Color(0x99000000)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
