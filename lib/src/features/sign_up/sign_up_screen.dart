import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_app/src/features/sign_up/sign_up_bloc.dart';
import 'package:sample_app/src/util/util.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isInvalidEmail = false;
  bool _isSignUpLoading = false;
  bool _isPasswordFieldEmpty = false;
  late SignUpBloc _signUpBloc;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _signUpBloc = BlocProvider.of<SignUpBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (blocContext, state) {
        state.when(
          loading: () {
            setState(() {
              _isSignUpLoading = true;
            });
          },
          error: () async {
            setState(() {
              _isSignUpLoading = false;
            });
            await showDialog(
              context: context,
              builder: (c) => AlertDialog(
                content: Text(
                  AppLocalizations.of(context)!.serverErrorText,
                ),
              ),
            );
          },
          success: () {
            setState(() {
              _isSignUpLoading = false;
            });
            ScaffoldMessenger.of(context)
                .showSnackBar(successSnackBar(context));
          },
        );
      },
      child: Scaffold(
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.only(
            top: 75,
            left: 25,
            right: 25,
            bottom: 25,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.signUpAllCapsText,
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _emailController,
                onChanged: (val) {
                  if (!(isValidEmail(val))) {
                    setState(() {
                      _isInvalidEmail = true;
                    });
                  } else {
                    setState(() {
                      _isInvalidEmail = false;
                    });
                  }
                },
              ),
              if (_isInvalidEmail)
                Text(
                  AppLocalizations.of(context)!.invalidEmailErrorText,
                  style: TextStyle(color: Colors.red),
                ),
              TextFormField(
                obscureText: true,
                controller: _passwordController,
                onChanged: (val) {
                  if (val.isEmpty) {
                    setState(() {
                      _isPasswordFieldEmpty = true;
                    });
                  } else {
                    setState(() {
                      _isPasswordFieldEmpty = false;
                    });
                  }
                },
              ),
              if (_isPasswordFieldEmpty)
                Text(
                  AppLocalizations.of(context)!.invalidPasswordErrorText,
                  style: TextStyle(color: Colors.red),
                ),
              SizedBox(
                height: 15,
              ),
              if (!_isSignUpLoading)
                ElevatedButton(
                  onPressed: !_isInvalidEmail &&
                          !_isPasswordFieldEmpty &&
                          _emailController.text.trim().isNotEmpty &&
                          _passwordController.text.trim().isNotEmpty
                      ? () {
                          _signUpBloc.add(
                            SignUpEvent.signUp(_emailController.text,
                                _passwordController.text),
                          );
                        }
                      : null,
                  child: Text(
                    AppLocalizations.of(context)!.signUpText,
                  ),
                ),
              if (_isSignUpLoading)
                SizedBox(
                  height: 25,
                  width: 25,
                  child: CircularProgressIndicator(),
                )
            ],
          ),
        )),
      ),
    );
  }
}
