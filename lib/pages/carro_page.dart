import 'package:cached_network_image/cached_network_image.dart';
import 'package:carros/api/carros_api.dart';
import 'package:carros/bloc/loripsum_bloc.dart';
import 'package:carros/models/api_response.dart';
import 'package:carros/models/carro.dart';
import 'package:carros/pages/carro_form_page.dart';
import 'package:carros/pages/mapa_page.dart';
import 'package:carros/pages/video_page.dart';
import 'package:carros/services/favorito_service.dart';
import 'package:carros/utils/alert.dart';
import 'package:carros/utils/event_bus.dart';
import 'package:carros/utils/nav.dart';
import 'package:carros/widgets/text.dart';
import 'package:flutter/material.dart';

class CarroPage extends StatefulWidget {
  Carro carro;

  CarroPage(this.carro);

  @override
  _CarroPageState createState() => _CarroPageState();
}

class _CarroPageState extends State<CarroPage> {
  final _loripsumBloc = LoripsumBloc();

  Color color = Colors.grey;

  Carro get carro => widget.carro;

  @override
  void initState() {
    super.initState();

    FavoritoService().isFavorito(carro).then((bool favorito) {
      setState(() {
        color = favorito ? Colors.red : Colors.grey;
      });
    });

    _loripsumBloc.fecth();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.carro.nome),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.place),
            onPressed: () => _onClickMapa(context),
          ),
          IconButton(
            icon: Icon(Icons.videocam),
            onPressed: () => _onClickVideo(context),
          ),
          _menu(),
        ],
      ),
      body: _body(),
    );
  }

  _body() {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView(
        children: <Widget>[
          CachedNetworkImage(
            imageUrl: widget.carro.urlFoto,
          ),
          _bloco1(),
          Divider(),
          _bloco2()
        ],
      ),
    );
  }

  _bloco1() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            text(widget.carro.nome, fontSize: 20, bold: true),
            text(widget.carro.tipo),
          ],
        ),
        Row(
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.favorite,
                color: color,
                size: 40,
              ),
              onPressed: _onClickFavorito,
            ),
            IconButton(
              icon: Icon(
                Icons.share,
                size: 40,
              ),
              onPressed: _onClickCompartilhar,
            ),
          ],
        ),
      ],
    );
  }

  _bloco2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 18,
        ),
        text(widget.carro.descricao, bold: true),
        SizedBox(
          height: 20,
        ),
        StreamBuilder(
            stream: _loripsumBloc.stream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              return text(snapshot.data);
            }),
      ],
    );
  }

  _menu() {
    return PopupMenuButton<String>(
      onSelected: (String valor) => _onClickPopUpMenu(valor),
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(
            value: "Editar",
            child: Text(
              "Editar",
            ),
          ),
          PopupMenuItem(
            value: "Deletar",
            child: Text(
              "Deletar",
            ),
          ),
          PopupMenuItem(
            value: "Compartilhar",
            child: Text(
              "Compartilhar",
            ),
          ),
        ];
      },
    );
  }

  _onClickMapa(context) {
     if(carro.longitude != null && carro.latitude != null) {
       push(context, MapaPage(carro));
    } else {
      alert(context, "Este carro não possui nenhum mapa!", title: "Erro",);
    }
  }

  _onClickVideo(context) {
    if(carro.urlVideo != null && carro.urlVideo.isNotEmpty) {
      // launch(carro.urlVideo);
      push(context, VideoPage(carro));
    } else {
      alert(context, "Este carro não possui nenhum vídeo!", title: "Erro",);
    }
  }

  _onClickPopUpMenu(String valor) {
    switch (valor) {
      case "Editar":
        push(
          context,
          CarroFormPage(
            carro: carro,
          ),
        );
        break;
      case "Deletar":
        deletar();
        break;
      case "Compartilhar":
        print("Clicou em compartilhar!");
        break;
    }
  }

  void _onClickFavorito() async {
    bool favorito = await FavoritoService().favoritar(carro);

    setState(() {
      color = favorito ? Colors.red : Colors.grey;
    });
  }

  void deletar() async {
    ApiResponse<bool> response = await CarrosApi.delete(carro);

    if (response.ok) {
      alert(context, "Carro deletado com sucesso", callback: () {
        EventBus.get(context).sendEvent(CarroEvent("carro-deletado", carro.tipo));
        pop(context);
      });
    } else {
      alert(context, response.msg);
    }
  }

  void _onClickCompartilhar() {}

  @override
  void dispose() {
    super.dispose();

    _loripsumBloc.dispose();
  }
}
