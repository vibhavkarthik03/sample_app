import 'package:flutter/material.dart';
import 'package:sample_app/src/features/splash_screen/splash_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SampleApp extends StatelessWidget {
  const SampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
