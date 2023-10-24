import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_app/src/features/onboarding/onboarding_screen.dart';
import 'package:sample_app/src/features/sign_up/sign_up_bloc.dart';
import 'package:sample_app/src/features/sign_up/sign_up_screen.dart';
import 'package:sample_app/src/util/preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      final isUserOnboardingCompleted =
          await Preferences.getIsOnBoardingCompleted();
      if (isUserOnboardingCompleted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (c) => BlocProvider(
                create: (c) => SignUpBloc(), child: SignUpScreen()),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (c) => OnboardingScreen(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SizedBox(
          height: 35,
          width: 35,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
