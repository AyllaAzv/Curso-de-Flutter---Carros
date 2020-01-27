import 'package:carros/models/usuario.dart';
import 'package:carros/pages/login_page.dart';
import 'package:carros/pages/site_page.dart';
import 'package:carros/services/firebase_service.dart';
import 'package:carros/utils/nav.dart';
import 'package:flutter/material.dart';

class DrawerList extends StatelessWidget {
  Future<Usuario> future = Usuario.get();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            FutureBuilder<Usuario>(
              future: future,
              builder: (context, snapshot) {
                Usuario user = snapshot.data;

                return user != null ? _header(user) : Container();
              },
            ),
            ListTile(
              leading: Icon(Icons.star),
              title: Text("Favoritos"),
              subtitle: Text("Mais informações"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text("Ajuda"),
              subtitle: Text("Mais informações"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.web),
              title: Text("Visite o site"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                _onClickSite(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("Logout"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () => _onClickLogout(context),
            ),
          ],
        ),
      ),
    );
  }

  _header(Usuario user) {
    return UserAccountsDrawerHeader(
      accountName: Text(
        user.nome,
      ),
      accountEmail: Text(
        user.email,
      ),
      currentAccountPicture: CircleAvatar(
        backgroundImage: NetworkImage(
          user.urlFoto,
        ),
      ),
    );
  }

  _onClickLogout(context) {
    Usuario.clear();
    FirebaseService().logout();
    Navigator.pop(context);
    push(context, LoginPage(), replace: true);
  }

  _onClickSite(context) {
    Navigator.pop(context);
    push(context, SitePage());
  }
}
