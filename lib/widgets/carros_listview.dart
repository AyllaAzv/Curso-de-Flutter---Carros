import 'package:cached_network_image/cached_network_image.dart';
import 'package:carros/models/carro.dart';
import 'package:carros/pages/carro_page.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class CarrosListView extends StatelessWidget {
  List<Carro> carros;

  CarrosListView(this.carros);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: carros != null ? carros.length : 0,
        itemBuilder: (context, index) {
          Carro carro = carros[index];

          return Container(
            child: InkWell(
              onTap: () {
                _onClickCarro(context, carro);
              },
              onLongPress: () {
                _onLongClickCarro(context, carro);
              },
              child: Card(
                color: Colors.grey[100],
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(
                        child: CachedNetworkImage(
                          imageUrl: carro.urlFoto ??
                              "http://www.livroandroid.com.br/livro/carros/esportivos/MERCEDES_BENZ_AMG.png",
                          width: 250,
                        ),
                      ),
                      Text(
                        carro.nome,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                      Text(
                        "Descrição...",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      ButtonBarTheme(
                        data: ButtonBarThemeData(),
                        child: ButtonBar(
                          children: <Widget>[
                            FlatButton(
                              child: const Text('DETALHES'),
                              onPressed: () => _onClickCarro(context, carro),
                            ),
                            FlatButton(
                              child: const Text('COMPARTILHAR'),
                              onPressed: () {
                                _onClickCompartilhar(context, carro);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _onClickCarro(context, carro) {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return CarroPage(carro);
      },
    ));
  }

  _onLongClickCarro(BuildContext context, Carro carro) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                carro.nome,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              title: Text("Detalhes"),
              leading: Icon(Icons.directions_car),
              onTap: () {
                Navigator.pop(context);
                _onClickCarro(context, carro);
              },
            ),
            ListTile(
              title: Text("Compartilhar"),
              leading: Icon(Icons.share),
              onTap: () {
                Navigator.pop(context);
                _onClickCompartilhar(context, carro);
              },
            ),
          ],
        );
      },
    );
  }

  void _onClickCompartilhar(BuildContext context, Carro carro) {
    print("share ${carro.nome}");

    Share.share(carro.urlFoto);
  }
}
