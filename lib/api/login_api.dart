import 'dart:convert';
import 'package:carros/models/api_response.dart';
import 'package:carros/models/usuario.dart';
import 'package:http/http.dart' as http;

class LoginApi {
  static Future<ApiResponse<Usuario>> login(String login, String senha) async {
    try {
      var url = 'http://carros-springboot.herokuapp.com/api/v2/login';

      Map<String, String> headers = {
        "Content-Type": "application/json",
      };

      Map params = {
        "username": login,
        "password": senha,
      };

      String s = json.encode(params);

      var response = await http.post(url, body: s, headers: headers);

      Map responseMap = json.decode(response.body);

      if (response.statusCode == 200) {
        Usuario user = Usuario.fromJson(responseMap);

        user.save();

        Usuario user2 = await Usuario.get();
        print(user2);

        return ApiResponse.ok(result: user);
      }

      return ApiResponse.error(msg: responseMap["error"]);
    } catch (error, exception) {
      print("Erro no login $error > $exception");

      return ApiResponse.error(msg: "Não foi possível fazer o login.");
    }
  }
}
