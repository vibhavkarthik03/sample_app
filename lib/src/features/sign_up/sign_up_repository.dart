import 'package:http/http.dart' as http;

class SignUpRepository {
  Future<http.Response> signUp({
    required String emailAddress,
    required String password,
  }) async {
    final signUpResponse = await http.post(
      Uri.parse(
        "https://snapkaro.com/eazyrooms_staging/api/user_registeration",
      ),
      body: {
        "user_email": emailAddress,
        "user_password": password,
      },
    );
    return signUpResponse;
  }
}
