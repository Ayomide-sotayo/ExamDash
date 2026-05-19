import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_routes.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/events/event_tracker.dart';
import '../../shared/widgets/exam_back_button.dart';
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
    EventTracker.track('readiness_intro_started');
    Navigator.pushNamed(context, AppRoutes.readinessCheck);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 1. Full-screen Mesh Background (Shifted more upward)
          Positioned.fill(
            top: -60, 
            child: Image.asset(
              'assets/gradient.png',
              fit: BoxFit.contain,
              alignment: const Alignment(0, -0.6), // Pull the vibrant core higher
            ),
          ),

          // 2. Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppSpacing.md),

                  // Pill-shaped Glassmorphic Back Button
                  const ExamBackButton(onDarkBackground: true),

                  const Spacer(flex: 2), // Move headline even higher

                  // Hero headline (on mesh)
                  Text(
                    'Find Your PEBC\nStarting Point In\nMinutes.',
                    style: AppTextStyles.heroHeadline,
                  ),

                  const SizedBox(height: 250), // Tightened gap

                  // Subtitle (Padded to force 3 lines)
                  Padding(
                    padding: const EdgeInsets.only(right: 30.0), // Force wrapping
                    child: Text(
                      'Answer a short set of topic-based questions and discover where to focus your study time next.',
                      style: AppTextStyles.heroSubtitle,
                    ),
                  ),

                  const SizedBox(height: 70), // Gap before button

                  // CTA button
                  ExamButton(
                    label: 'Get Started',
                    onPressed: _onGetStarted,
                    backgroundColor: AppColors.ctaButton,
                    textColor: AppColors.textWhite,
                  ),

                  const Spacer(flex: 2), // Lift everything up from the bottom
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
