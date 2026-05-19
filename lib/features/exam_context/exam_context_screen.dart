import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_routes.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/events/event_tracker.dart';
import '../../providers/exam_context_provider.dart';
import '../../shared/widgets/exam_back_button.dart';
import '../../shared/widgets/exam_button.dart';
import '../../shared/widgets/progress_bar.dart';

class ExamContextScreen extends StatefulWidget {
  const ExamContextScreen({super.key});

  @override
  State<ExamContextScreen> createState() => _ExamContextScreenState();
}

class _ExamContextScreenState extends State<ExamContextScreen> {
  int _currentStep = 0; // 0: Attempt Status, 1: Retake Timing
  bool? _isFirstAttempt;
  String? _resitWindow;

  @override
  void initState() {
    super.initState();
    EventTracker.track('exam_context_viewed');
  }

  void _onContinue() {
    if (_currentStep == 0) {
      if (_isFirstAttempt == null) return;
      
      if (_isFirstAttempt == true) {
        // Skip retake timing if it's first attempt
        _finishContext();
      } else {
        setState(() => _currentStep = 1);
      }
    } else {
      if (_resitWindow == null) return;
      _finishContext();
    }
  }

  void _finishContext() {
    final provider = context.read<ExamContextProvider>();
    provider.setExam('PEBC');
    provider.setAttemptStatus(_isFirstAttempt!);
    provider.setResitWindow(_resitWindow);

    EventTracker.track('exam_context_saved');
    Navigator.pushNamed(context, AppRoutes.diagnosticWelcome);
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

              // Top Bar with Back and Progress
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildBackButton(),
                  CustomProgressBar(progress: _currentStep == 0 ? 0.33 : 0.66),
                  const SizedBox(width: 48), // Spacer for centering progress
                ],
              ),

              const SizedBox(height: AppSpacing.xl),

              // Subtitle
              const Text(
                'Help us tailor your PEBC diagnostic experience.',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w400,
                ),
              ),

              const SizedBox(height: AppSpacing.sm),

              // Dynamic Headline
              Text(
                _currentStep == 0
                    ? 'Have You Attempted The PEBC Exam Before?'
                    : 'When Are You Planning To Retake The Exam?',
                style: AppTextStyles.screenHeading.copyWith(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: AppSpacing.xxl),

              // Options
              if (_currentStep == 0) ...[
                _OptionTile(
                  label: 'Yes, I’ve Attempted It Before',
                  isSelected: _isFirstAttempt == false,
                  onTap: () => setState(() => _isFirstAttempt = false),
                ),
                const SizedBox(height: AppSpacing.md),
                _OptionTile(
                  label: 'No, This Will Be My First Attempt',
                  isSelected: _isFirstAttempt == true,
                  onTap: () => setState(() => _isFirstAttempt = true),
                ),
              ] else ...[
                _OptionTile(
                  label: 'Within 1 Month',
                  isSelected: _resitWindow == 'Within 1 Month',
                  onTap: () => setState(() => _resitWindow = 'Within 1 Month'),
                ),
                const SizedBox(height: AppSpacing.md),
                _OptionTile(
                  label: '1–3 Months',
                  isSelected: _resitWindow == '1–3 Months',
                  onTap: () => setState(() => _resitWindow = '1–3 Months'),
                ),
                const SizedBox(height: AppSpacing.md),
                _OptionTile(
                  label: '3–6 Months',
                  isSelected: _resitWindow == '3–6 Months',
                  onTap: () => setState(() => _resitWindow = '3–6 Months'),
                ),
                const SizedBox(height: AppSpacing.md),
                _OptionTile(
                  label: 'Not Sure Yet',
                  isSelected: _resitWindow == 'Not Sure Yet',
                  onTap: () => setState(() => _resitWindow = 'Not Sure Yet'),
                ),
              ],

              const Spacer(),

              ExamButton(
                label: 'Continue',
                onPressed: _canContinue() ? _onContinue : null,
                backgroundColor: AppColors.ctaButton,
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

  bool _canContinue() {
    if (_currentStep == 0) return _isFirstAttempt != null;
    return _resitWindow != null;
  }

  Widget _buildBackButton() {
    return ExamBackButton(
      onTap: () {
        if (_currentStep == 1) {
          setState(() => _currentStep = 0);
        } else {
          Navigator.maybePop(context);
        }
      },
    );
  }
}

class _OptionTile extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _OptionTile({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        decoration: BoxDecoration(
          color: const Color(0xFFF7F7F7),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.gradientStart : Colors.transparent,
            width: 2,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color: isSelected ? AppColors.textPrimary : const Color(0xFF68727D),
          ),
        ),
      ),
    );
  }
}
