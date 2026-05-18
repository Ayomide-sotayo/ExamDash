import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  // Hero headline (Screen 1 - white on gradient)
  static TextStyle heroHeadline = GoogleFonts.gluten(
    fontSize: 40,
    fontWeight: FontWeight.w500,
    color: AppColors.textWhite,
    height: 1.59,
    letterSpacing: 0,
  );

  // Hero subtitle (Screen 1 - now on white background)
  static TextStyle heroSubtitle = GoogleFonts.poppins(
    fontSize: 17,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    height: 1.46,
    letterSpacing: 1,
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
  static TextStyle bulletText = GoogleFonts.roboto(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.4, // Increased height for better multi-line readability
    letterSpacing: 0,
  );

  // CTA button label
  static const ctaLabel = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.ctaButtonText,
    letterSpacing: 0.2,
  );
}
