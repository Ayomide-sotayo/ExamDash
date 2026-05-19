import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_routes.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/events/event_tracker.dart';
import '../../shared/widgets/exam_back_button.dart';
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
    Navigator.pushNamed(context, AppRoutes.examContext);
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
              const ExamBackButton(),

              const SizedBox(height: AppSpacing.xl),

              // "Before you begin" label (Grey)
              Text(
                'Before you begin',
                style: AppTextStyles.sectionLabel.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),

              const SizedBox(height: AppSpacing.sm),

              // Main heading
              Text(
                'This Short Diagnostic Helps Identify Which PEBC Topics Need The Most Attention Right Now.',
                style: AppTextStyles.screenHeading.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: AppSpacing.xl),

              // Bullet points card (Fixed height, 24px radius)
              Container(
                width: double.infinity,
                height: 257, // Exactly as requested
                decoration: BoxDecoration(
                  color: const Color(0xFFF9F9F9),
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 24, // Increased padding
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center, // Centering items vertically in box
                  children: [
                    _BulletItem(text: 'Answer Topic-Based Question One At A Time'),
                    SizedBox(height: 32), // Increased space between items
                    _BulletItem(text: 'Discover Where To Focus Your Study Sessions'),
                    SizedBox(height: 32), // Increased space between items
                    _BulletItem(text: 'Receive A Personalized Study Starting Point'),
                  ],
                ),
              ),

              const Spacer(flex: 2), // Move button up

              // CTA button (Gradient)
              ExamButton(
                label: 'Start Diagnostic',
                onPressed: _onStartDiagnostic,
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFFF5B40),
                    Color(0xFFFF4172),
                  ],
                ),
                textColor: AppColors.textWhite,
              ),

              const SizedBox(height: AppSpacing.xxl), // Some space at bottom
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
          child: Padding(
            padding: const EdgeInsets.only(right: 30.0), // Force 2-line wrap
            child: Text(
              text,
              style: AppTextStyles.bulletText,
            ),
          ),
        ),
      ],
    );
  }
}
