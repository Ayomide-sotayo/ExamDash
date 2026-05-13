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
    // Navigating to intro screen as requested in objective
    Navigator.pushNamed(context, AppRoutes.readinessCheck);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 1. Mesh Gradient Image (Top Aligned)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: screenHeight * 0.65, // Occupies top 65%
            child: Image.asset(
              'assets/gradient.png',
              fit: BoxFit.cover,
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

                  // Glassmorphic Back Button
                  ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: GestureDetector(
                        onTap: () => Navigator.maybePop(context),
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white.withOpacity(0.3),
                              width: 1.5,
                            ),
                          ),
                          child: const Icon(
                            Icons.chevron_left,
                            color: Colors.black, // Darker icon for contrast on mesh
                            size: 28,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const Spacer(flex: 3),

                  // Hero headline (stays on mesh)
                  Text(
                    'Find Your PEBC\nStarting Point In\nMinutes.',
                    style: AppTextStyles.heroHeadline,
                  ),

                  const Spacer(flex: 1),

                  // Subtitle (positioned on white area)
                  const Text(
                    'Answer a short set of topic-based questions and discover where to focus your study time next.',
                    style: AppTextStyles.heroSubtitle,
                  ),

                  const SizedBox(height: AppSpacing.xxl),

                  // CTA button (bottom)
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
