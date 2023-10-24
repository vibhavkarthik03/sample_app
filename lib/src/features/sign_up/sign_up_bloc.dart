import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sample_app/src/features/sign_up/sign_up_repository.dart';

part 'sign_up_bloc.freezed.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final repository = SignUpRepository();

  SignUpBloc() : super(const SignUpState.loading()) {
    on<SignUpEvent>(
      (event, emit) async {
        await event.when(
          signUp: (email, password) async {
            await _onSignUp(
              email,
              password,
              emit,
            );
          },
        );
      },
    );
  }

  Future<void> _onSignUp(
    String email,
    String password,
    Emitter<SignUpState> emit,
  ) async {
    emit(const SignUpState.loading());
    final response = await repository.signUp(
      emailAddress: email,
      password: password,
    );
    if (response.statusCode == 200) {
      emit(const SignUpState.success());
    } else {
      emit(const SignUpState.error());
    }
  }
}

@freezed
class SignUpState with _$SignUpState {
  const factory SignUpState.loading() = SignUpLoading;

  const factory SignUpState.error() = SignUpError;

  const factory SignUpState.success() = SignUpSuccess;
}

@freezed
class SignUpEvent with _$SignUpEvent {
  const factory SignUpEvent.signUp(String email, String password) = SignUp;
}
