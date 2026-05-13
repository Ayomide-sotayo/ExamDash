import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/constants/app_routes.dart';
import 'providers/exam_context_provider.dart';
import 'providers/diagnostic_provider.dart';
import 'providers/result_mission_provider.dart';
import 'features/landing/landing_screen.dart';
import 'features/readiness_check/readiness_intro_screen.dart';

class ExamDashApp extends StatelessWidget {
  const ExamDashApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ExamContextProvider()),
        ChangeNotifierProvider(create: (_) => DiagnosticProvider()),
        ChangeNotifierProvider(create: (_) => ResultProvider()),
        ChangeNotifierProvider(create: (_) => MissionProvider()),
      ],
      child: MaterialApp(
        title: 'ExamDash',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFF4757)),
          fontFamily: 'Inter',
          useMaterial3: true,
        ),
        initialRoute: AppRoutes.landing,
        routes: {
          AppRoutes.landing:        (_) => const LandingScreen(),
          AppRoutes.readinessCheck: (_) => const ReadinessIntroScreen(),
          // remaining routes added as screens are built
        },
      ),
    );
  }
}
