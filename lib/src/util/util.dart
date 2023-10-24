import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

bool isValidEmail(String? value) {
  final pattern = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  return value!.isNotEmpty && pattern.hasMatch(value);
}

SnackBar successSnackBar(BuildContext context) {
  return SnackBar(
    content: Text(
      AppLocalizations.of(context)!.signUpSucceededText,
    ),
  );
}
