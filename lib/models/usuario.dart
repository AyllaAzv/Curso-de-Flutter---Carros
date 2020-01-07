import 'dart:convert' as convert;

import 'package:carros/utils/prefs.dart';

class Usuario {
  int id;
  String login;
  String nome;
  String email;
  String urlFoto;
  String token;

  List<String> roles;

  Usuario({
    this.id,
    this.login,
    this.nome,
    this.email,
    this.urlFoto,
    this.token,
    this.roles,
  });

  Usuario.fromJson(Map<String, dynamic> map)
      : this.id = map["id"],
        this.login = map["login"],
        this.nome = map["nome"],
        this.email = map["email"],
        this.urlFoto = map["urlFoto"],
        this.token = map["token"],
        this.roles = map["roles"] != null ? _getRoles(map) : null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['login'] = this.login;
    data['nome'] = this.nome;
    data['email'] = this.email;
    data['urlFoto'] = this.urlFoto;
    data['token'] = this.token;
    data['roles'] = this.roles;
    return data;
  }

  @override
  String toString() {
    return "Usuario{id: $id, login: $login, nome: $nome, email: $email, " +
        "urlFoto: $urlFoto, token: $token, roles: $roles}";
  }

  static List<String> _getRoles(Map<String, dynamic> map) {
    List<String> roles =
        map["roles"].map<String>((role) => role.toString()).toList();

    return roles;
  }

  static void clear() {
    Prefs.setString("user.prefs", "");
  }

  void save() {
    Map map = toJson();

    String json = convert.json.encode(map);

    Prefs.setString("user.prefs", json);
  }

  static Future<Usuario> get() async {
    String json = await Prefs.getString("user.prefs");

    if(json.isEmpty) {
      return null;
    }

    Map map = convert.json.decode(json);

    return Usuario.fromJson(map);
  }
}
