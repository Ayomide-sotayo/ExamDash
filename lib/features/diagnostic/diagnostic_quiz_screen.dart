import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_routes.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/events/event_tracker.dart';
import '../../shared/widgets/exam_button.dart';

// Mock question model — replace with real API model when backend is ready
class _Question {
  final String id;
  final String category;
  final String text;
  final List<String> options;
  final String correctAnswer;
  final String explanation;

  const _Question({
    required this.id,
    required this.category,
    required this.text,
    required this.options,
    required this.correctAnswer,
    required this.explanation,
  });
}

// Mock question bank — replace with real API call when backend is ready
const _mockQuestion = _Question(
  id: 'q-ph-001',
  category: 'Pharmacology',
  text: 'Which dosage form is designed to dissolve slowly in the mouth for prolonged medication release?',
  options: ['Tablet', 'Lozenge', 'Capsule', 'Suspension'],
  correctAnswer: 'Lozenge',
  explanation:
      'A lozenge is designed to dissolve slowly in the mouth, allowing the medication to be released gradually over time. Tablets are swallowed whole, capsules contain powder or liquid inside a shell, and suspensions are liquid forms where particles are dispersed.',
);

class DiagnosticQuizScreen extends StatefulWidget {
  const DiagnosticQuizScreen({super.key});

  @override
  State<DiagnosticQuizScreen> createState() => _DiagnosticQuizScreenState();
}

class _DiagnosticQuizScreenState extends State<DiagnosticQuizScreen> {
  // ── State ──────────────────────────────────────────────────────────────────
  String? _selectedAnswer;
  bool _isSubmitted = false;
  bool _isLoading = false;
  String? _errorMessage;

  final int _currentQuestion = 1;
  final int _totalQuestions = 30;
  final _Question _question = _mockQuestion;

  // ── Derived state ──────────────────────────────────────────────────────────
  bool get _isCorrect => _selectedAnswer == _question.correctAnswer;

  // ── Handlers ───────────────────────────────────────────────────────────────

  void _onSubmit() {
    if (_selectedAnswer == null) return;

    setState(() {
      _isLoading = true;
    });

    // Simulate API call — replace with real submit call when backend ready
    Future.delayed(const Duration(milliseconds: 600), () {
      if (!mounted) return;

      // AC-7: Fire diagnostic_question_answered event
      EventTracker.track('diagnostic_question_answered', properties: {
        'question_id':      _question.id,
        'question_number':  _currentQuestion,
        'topic':            _question.category,
        'selected_answer':  _selectedAnswer,
        'is_correct':       _isCorrect,
      });

      setState(() {
        _isSubmitted = true;
        _isLoading = false;
      });
    });
  }

  void _onNext() {
    // TODO: navigate to next question or result screen
    // For Week 6 demo — navigate back or to result
    Navigator.pushNamed(context, AppRoutes.result);
  }

  void _onRetry() {
    setState(() {
      _errorMessage = null;
      _selectedAnswer = null;
      _isSubmitted = false;
    });
  }

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    // FE-006 AC-2: Error state
    if (_errorMessage != null) {
      return _ErrorState(message: _errorMessage!, onRetry: _onRetry);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSpacing.lg),

            // ── Top chips ───────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenPadding,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildChip(_question.category),
                  _buildChip(
                      'Question $_currentQuestion / $_totalQuestions'),
                ],
              ),
            ),

            const SizedBox(height: AppSpacing.xxl),

            // ── Question text ───────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenPadding,
              ),
              child: Text(
                _question.text,
                style: AppTextStyles.screenHeading.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  height: 1.3,
                ),
              ),
            ),

            const SizedBox(height: AppSpacing.xxl),

            // ── Options ─────────────────────────────────────────────────────
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.screenPadding,
                ),
                itemCount: _question.options.length,
                separatorBuilder: (_, __) =>
                    const SizedBox(height: AppSpacing.md),
                itemBuilder: (context, index) {
                  final option = _question.options[index];
                  final isSelected = _selectedAnswer == option;
                  final isCorrectOption =
                      _isSubmitted && option == _question.correctAnswer;
                  final isWrongSelection = _isSubmitted &&
                      isSelected &&
                      option != _question.correctAnswer;

                  return _QuizOptionTile(
                    label: option,
                    isSelected: isSelected,
                    isSubmitted: _isSubmitted,
                    isCorrect: isCorrectOption,
                    isWrong: isWrongSelection,
                    // AC-4: Can only select one answer, locked after submit
                    onTap: _isSubmitted
                        ? null
                        : () =>
                            setState(() => _selectedAnswer = option),
                  );
                },
              ),
            ),

            // ── AC-6: Explanation state ─────────────────────────────────────
            if (_isSubmitted)
              _ExplanationCard(
                isCorrect: _isCorrect,
                explanation: _question.explanation,
              ),

            // ── Button ──────────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.screenPadding,
                AppSpacing.md,
                AppSpacing.screenPadding,
                AppSpacing.xxl,
              ),
              child: _isSubmitted
                  ? ExamButton(
                      label: 'Next Question',
                      onPressed: _onNext,
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xFFFF5B40), Color(0xFFFF4172)],
                      ),
                      textColor: AppColors.textWhite,
                    )
                  : ExamButton(
                      // FE-006 AC-1: Loading state inside button
                      label: 'Submit Answer',
                      onPressed:
                          _selectedAnswer != null && !_isLoading
                              ? _onSubmit
                              : null,
                      isLoading: _isLoading,
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xFFFF5B40), Color(0xFFFF4172)],
                      ),
                      textColor: AppColors.textWhite,
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChip(String label) {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F2F2),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 14,
          color: AppColors.textSecondary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

// ── Option tile ───────────────────────────────────────────────────────────────

class _QuizOptionTile extends StatelessWidget {
  final String label;
  final bool isSelected;
  final bool isSubmitted;
  final bool isCorrect;
  final bool isWrong;
  final VoidCallback? onTap;

  const _QuizOptionTile({
    required this.label,
    required this.isSelected,
    required this.isSubmitted,
    required this.isCorrect,
    required this.isWrong,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color borderColor = Colors.transparent;
    Color bgColor = const Color(0xFFF7F7F7);

    if (isCorrect) {
      borderColor = const Color(0xFF22C55E); // green
      bgColor = const Color(0xFFEFFEF4);
    } else if (isWrong) {
      borderColor = const Color(0xFFEF4444); // red
      bgColor = const Color(0xFFFEF2F2);
    } else if (isSelected) {
      borderColor = AppColors.gradientStart;
    }

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        padding:
            const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: borderColor, width: 2),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isSelected
                      ? FontWeight.w600
                      : FontWeight.w500,
                  color: isSelected
                      ? AppColors.textPrimary
                      : const Color(0xFF68727D),
                ),
              ),
            ),
            if (isCorrect)
              const Icon(Icons.check_circle,
                  color: Color(0xFF22C55E), size: 20),
            if (isWrong)
              const Icon(Icons.cancel,
                  color: Color(0xFFEF4444), size: 20),
          ],
        ),
      ),
    );
  }
}

// ── AC-6: Explanation card ────────────────────────────────────────────────────

class _ExplanationCard extends StatelessWidget {
  final bool isCorrect;
  final String explanation;

  const _ExplanationCard({
    required this.isCorrect,
    required this.explanation,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenPadding,
        vertical: AppSpacing.md,
      ),
      padding: const EdgeInsets.all(AppSpacing.cardPadding),
      decoration: BoxDecoration(
        color: isCorrect
            ? const Color(0xFFEFFEF4)
            : const Color(0xFFFFF7ED),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isCorrect
              ? const Color(0xFF22C55E)
              : const Color(0xFFF97316),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                isCorrect
                    ? Icons.check_circle_outline
                    : Icons.lightbulb_outline,
                color: isCorrect
                    ? const Color(0xFF22C55E)
                    : const Color(0xFFF97316),
                size: 18,
              ),
              const SizedBox(width: 8),
              Text(
                isCorrect ? 'Well done!' : 'Here\'s what to know',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: isCorrect
                      ? const Color(0xFF22C55E)
                      : const Color(0xFFF97316),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            explanation,
            style: AppTextStyles.bulletText.copyWith(
              fontSize: 13,
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

// ── FE-006 AC-2: Error state ──────────────────────────────────────────────────

class _ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorState({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.screenPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.wifi_off_outlined,
                  size: 48, color: AppColors.textSecondary),
              const SizedBox(height: AppSpacing.md),
              Text(
                'Something went wrong',
                style: AppTextStyles.screenHeading.copyWith(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                message,
                style: AppTextStyles.bulletText
                    .copyWith(color: AppColors.textSecondary),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xl),
              ExamButton(
                label: 'Try Again',
                onPressed: onRetry,
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFFF5B40), Color(0xFFFF4172)],
                ),
                textColor: AppColors.textWhite,
              ),
            ],
          ),
        ),
      ),
    );
  }
}