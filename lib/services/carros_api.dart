import 'package:carros/models/carro.dart';

class CarrosApi {
  static List<Carro> getCarros() {
    final carros = List<Carro>();

    carros.add(Carro(
      nome: "Ferrari FF 4",
      urlFoto:
          "http://www.livroandroid.com.br/livro/carros/esportivos/Ferrari_FF.png",
    ));
    carros.add(Carro(
      nome: "Porsche Panamera",
      urlFoto:
          "http://www.livroandroid.com.br/livro/carros/esportivos/Porsche_Panamera.png",
    ));
    carros.add(Carro(
      nome: "Chevrolet Corvette Z06",
      urlFoto:
          "http://www.livroandroid.com.br/livro/carros/esportivos/Chevrolet_Corvette_Z06.png",
    ));

    return carros;
  }
}
