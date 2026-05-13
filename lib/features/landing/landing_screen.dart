import 'dart:ui';
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
            top: -100, 
            child: Image.asset(
              'assets/gradient.png',
              fit: BoxFit.cover,
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
                  GestureDetector(
                    onTap: () => Navigator.maybePop(context),
                    child: Container(
                      width: 48,
                      height: 37,
                      decoration: BoxDecoration(
                        color: const Color(0x0DFFFFFF),
                        borderRadius: BorderRadius.circular(9999),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x0D000000),
                            blurRadius: 6.9,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(9999),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: const Center(
                            child: Icon(
                              Icons.chevron_left,
                              color: Colors.black,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const Spacer(flex: 2), // Reduced from 3 to move headline up

                  // Hero headline (on mesh)
                  Text(
                    'Find Your PEBC\nStarting Point In\nMinutes.',
                    style: AppTextStyles.heroHeadline.copyWith(
                      fontSize: 44,
                    ),
                  ),

                  const Spacer(flex: 2),

                  // Subtitle
                  const Padding(
                    padding: EdgeInsets.only(top: 0.0), // Tightened
                    child: Text(
                      'Answer a short set of topic-based questions and discover where to focus your study time next.',
                      style: AppTextStyles.heroSubtitle,
                    ),
                  ),

                  const SizedBox(height: AppSpacing.xxl),

                  // CTA button
                  ExamButton(
                    label: 'Get Started',
                    onPressed: _onGetStarted,
                    backgroundColor: AppColors.ctaButton,
                    textColor: AppColors.textWhite,
                  ),

                  const SizedBox(height: AppSpacing.xl),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
