import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_routes.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/events/event_tracker.dart';
import '../../shared/widgets/exam_button.dart';

class DiagnosticWelcomeScreen extends StatefulWidget {
  const DiagnosticWelcomeScreen({super.key});

  @override
  State<DiagnosticWelcomeScreen> createState() => _DiagnosticWelcomeScreenState();
}

class _DiagnosticWelcomeScreenState extends State<DiagnosticWelcomeScreen> {
  @override
  void initState() {
    super.initState();
    EventTracker.track('diagnostic_welcome_viewed');
  }

  void _onStart() {
    EventTracker.track('diagnostic_session_started');
    Navigator.pushNamed(context, AppRoutes.diagnosticQuiz);
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

              // Pill-shaped Back Button
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

              Text(
                'Ready to begin?',
                style: AppTextStyles.sectionLabel.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),

              const SizedBox(height: AppSpacing.sm),

              Text(
                'Let’s Map Out Your Path To PEBC Success.',
                style: AppTextStyles.screenHeading,
              ),

              const SizedBox(height: AppSpacing.xl),

              // Explanatory card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSpacing.cardPadding),
                decoration: BoxDecoration(
                  color: const Color(0xFFF9F9F9),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  children: const [
                    _FeatureItem(
                      icon: Icons.assignment_outlined,
                      title: 'The Diagnostic',
                      description: 'A focused set of questions across core PEBC domains to identify your current baseline.',
                    ),
                    SizedBox(height: 24),
                    _FeatureItem(
                      icon: Icons.auto_graph_outlined,
                      title: 'The Outcome',
                      description: 'A detailed breakdown of your weak areas and a personalized study plan to tackle them.',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppSpacing.xl),

              // Non-defeating copy
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  'Don’t worry if you don’t know all the answers yet. That’s exactly why we’re here—to help you learn efficiently.',
                  style: AppTextStyles.bulletText.copyWith(
                    color: AppColors.textSecondary,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),

              const Spacer(),

              ExamButton(
                label: 'Start Now',
                onPressed: _onStart,
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

              const SizedBox(height: AppSpacing.xxl),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _FeatureItem({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: AppColors.gradientStart, size: 24),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: AppTextStyles.bulletText.copyWith(fontSize: 14),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
