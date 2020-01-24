import 'dart:async';

import 'package:carros/bloc/simple_bloc.dart';
import 'package:carros/models/api_response.dart';
import 'package:carros/services/firebase_service.dart';

class LoginBloc extends SimpleBloc<bool> {
  Future<ApiResponse> login(String login, String senha) async {
    add(true);

    // ApiResponse response = await LoginApi.login(login, senha);
    ApiResponse response = await FirebaseService().login(login, senha);

    add(false);

    return response;
  }
}
