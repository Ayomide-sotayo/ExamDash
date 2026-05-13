import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_routes.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/events/event_tracker.dart';
import '../../shared/widgets/exam_button.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  void initState() {
    super.initState();
    EventTracker.track('landing_page_viewed');
  }

  void _onGetStarted() {
    EventTracker.track('signup_started');
    Navigator.pushNamed(context, AppRoutes.signup);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.gradientStart,
              AppColors.gradientMid,
              AppColors.gradientEnd,
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.screenPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppSpacing.xl),

                // Back arrow (matches Figma)
                GestureDetector(
                  onTap: () => Navigator.maybePop(context),
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.chevron_left,
                      color: AppColors.textWhite,
                      size: 22,
                    ),
                  ),
                ),

                const Spacer(),

                // Hero headline
                Text(
                  'Find Your PEBC\nStarting Point In\nMinutes.',
                  style: AppTextStyles.heroHeadline,
                ),

                const SizedBox(height: AppSpacing.xl),

                // Subtitle
                Text(
                  'Answer A Short Set Of Topic-Based Questions And Discover Where To Focus Your Study Time Next.',
                  style: AppTextStyles.heroSubtitle,
                ),

                const SizedBox(height: AppSpacing.xxl),

                // CTA button
                ExamButton(
                  label: 'Get Started',
                  onPressed: _onGetStarted,
                  backgroundColor: Colors.white.withOpacity(0.25),
                ),

                const SizedBox(height: AppSpacing.xl),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
