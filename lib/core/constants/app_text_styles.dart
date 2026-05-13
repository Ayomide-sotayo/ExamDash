import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  // Hero headline (Screen 1 - white on gradient)
  static const heroHeadline = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: AppColors.textWhite,
    height: 1.2,
    letterSpacing: -0.5,
  );

  // Hero subtitle (Screen 1 - white on gradient)
  static const heroSubtitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textWhite,
    height: 1.6,
  );

  // Section label e.g. "Before you begin"
  static const sectionLabel = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textLabel,
    letterSpacing: 0.5,
  );

  // Screen heading (Screen 2 - dark on white)
  static const screenHeading = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  // Card bullet text
  static const bulletText = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    height: 1.5,
  );

  // CTA button label
  static const ctaLabel = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.ctaButtonText,
    letterSpacing: 0.2,
  );
}
