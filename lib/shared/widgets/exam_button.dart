import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_text_styles.dart';

class ExamButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isDisabled;
  final Color? backgroundColor;
  final Color? textColor;
  final Gradient? gradient;

  const ExamButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.isDisabled = false,
    this.backgroundColor,
    this.textColor,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    final bool active = !isDisabled && !isLoading;

    return Container(
      width: double.infinity,
      height: AppSpacing.buttonHeight,
      decoration: BoxDecoration(
        color: active ? (backgroundColor ?? AppColors.ctaButton) : AppColors.ctaButton.withOpacity(0.5),
        gradient: active ? gradient : null,
        borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
      ),
      child: ElevatedButton(
        onPressed: active ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
          ),
          elevation: 0,
        ),
        child: isLoading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  color: AppColors.textWhite,
                  strokeWidth: 2.5,
                ),
              )
            : Text(
                label, 
                style: AppTextStyles.ctaLabel.copyWith(
                  color: textColor ?? AppColors.ctaButtonText,
                ),
              ),
      ),
    );
  }
}
