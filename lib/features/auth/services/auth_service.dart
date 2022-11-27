import 'package:bookslib/constants/error_handling.dart';
import 'package:bookslib/constants/utils.dart';
import 'package:bookslib/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:bookslib/constants/global_variables.dart';

class AuthService {
  // SIGN UP USER
  void signUpUser(
      {required BuildContext context,
      required String email,
      required String name,
      required String username,
      required String password}) async {
    try {
      User user = User(
          id: '',
          name: name,
          email: email,
          username: username,
          password: password,
          address: 'address',
          type: 'type',
          token: 'token');

      http.Response res = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Akun berhasil dibuat');
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
