import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_routes.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/events/event_tracker.dart';
import '../../shared/widgets/exam_button.dart';

class ReadinessIntroScreen extends StatefulWidget {
  const ReadinessIntroScreen({super.key});

  @override
  State<ReadinessIntroScreen> createState() => _ReadinessIntroScreenState();
}

class _ReadinessIntroScreenState extends State<ReadinessIntroScreen> {
  @override
  void initState() {
    super.initState();
    EventTracker.track('readiness_intro_viewed');
  }

  void _onStartDiagnostic() {
    EventTracker.track('readiness_check_started');
    Navigator.pushNamed(context, AppRoutes.readinessCheck);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSpacing.lg),

              // Pill-shaped Back Button (48x37)
              GestureDetector(
                onTap: () => Navigator.maybePop(context),
                child: Container(
                  width: 48,
                  height: 37,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(9999),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 6.9,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.chevron_left,
                      color: AppColors.textPrimary,
                      size: 20,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: AppSpacing.xl),

              // "Before you begin" label (Grey)
              Text(
                'Before you begin',
                style: AppTextStyles.sectionLabel.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),

              const SizedBox(height: AppSpacing.md),

              // Main heading
              Text(
                'This Short Diagnostic Helps Identify Which PEBC Topics Need The Most Attention Right Now.',
                style: AppTextStyles.screenHeading.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: AppSpacing.xl),

              // Bullet points card (Lighter grey)
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFF9F9F9), // Very light grey
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 32, // More vertical padding
                ),
                child: Column(
                  children: const [
                    _BulletItem(text: 'Answer Topic-Based Question One At A Time'),
                    SizedBox(height: 24), // Increased spacing
                    _BulletItem(text: 'Discover Where To Focus Your Study Sessions'),
                    SizedBox(height: 24), // Increased spacing
                    _BulletItem(text: 'Receive A Personalized Study Starting Point'),
                  ],
                ),
              ),

              const Spacer(),

              // CTA button
              ExamButton(
                label: 'Start Diagnostic',
                onPressed: _onStartDiagnostic,
                backgroundColor: AppColors.ctaButton,
                textColor: AppColors.textWhite,
              ),

              const SizedBox(height: AppSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }
}

class _BulletItem extends StatelessWidget {
  final String text;

  const _BulletItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 6),
          width: 5,
          height: 5,
          decoration: const BoxDecoration(
            color: Color(0xFF999999), // Grey dots
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Text(
            text,
            style: AppTextStyles.bulletText.copyWith(
              color: AppColors.textSecondary, // Grey text
            ),
          ),
        ),
      ],
    );
  }
}
