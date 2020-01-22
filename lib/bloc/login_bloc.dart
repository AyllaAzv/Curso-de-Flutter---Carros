import 'dart:async';

import 'package:carros/bloc/simple_bloc.dart';
import 'package:carros/models/api_response.dart';
import 'package:carros/models/usuario.dart';
import 'package:carros/api/login_api.dart';

class LoginBloc extends SimpleBloc<bool> {
  Future<ApiResponse<Usuario>> login(String login, String senha) async {
    add(true);

    ApiResponse response = await LoginApi.login(login, senha);

    add(false);

    return response;
  }
}
