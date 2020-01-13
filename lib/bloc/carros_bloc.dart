import 'package:carros/bloc/simple_bloc.dart';
import 'package:carros/models/carro.dart';
import 'package:carros/services/carros_api.dart';

class CarrosBloc extends SimpleBloc<List<Carro>> {
  fetch(String tipo) async {
    try {
      List<Carro> carros = await CarrosApi.getCarros(tipo);

      add(carros);
    } catch (e) {
      addError(e);
    }
  }
}
