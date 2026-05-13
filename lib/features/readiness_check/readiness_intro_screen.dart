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

              // Back arrow
              GestureDetector(
                onTap: () => Navigator.maybePop(context),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.cardBg,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.chevron_left,
                    color: AppColors.textPrimary,
                    size: 24,
                  ),
                ),
              ),

              const SizedBox(height: AppSpacing.xl),

              // "Before you begin" label
              Text(
                'Before you begin',
                style: AppTextStyles.sectionLabel,
              ),

              const SizedBox(height: AppSpacing.md),

              // Main heading
              Text(
                'This Short Diagnostic Helps Identify Which PEBC Topics Need The Most Attention Right Now.',
                style: AppTextStyles.screenHeading.copyWith(
                  fontSize: 24,
                ),
              ),

              const SizedBox(height: AppSpacing.xl),

              // Bullet points card
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.cardBg,
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: const [
                    _BulletItem(text: 'Answer Topic-Based Question One At A Time'),
                    SizedBox(height: AppSpacing.lg),
                    _BulletItem(text: 'Discover Where To Focus Your Study Sessions'),
                    SizedBox(height: AppSpacing.lg),
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
          width: 6,
          height: 6,
          decoration: const BoxDecoration(
            color: AppColors.bulletDot,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Text(text, style: AppTextStyles.bulletText),
        ),
      ],
    );
  }
}
