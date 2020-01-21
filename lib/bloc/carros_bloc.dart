import 'package:carros/bloc/simple_bloc.dart';
import 'package:carros/dao/carro_dao.dart';
import 'package:carros/models/carro.dart';
import 'package:carros/services/carros_api.dart';
import 'package:carros/utils/network.dart';

class CarrosBloc extends SimpleBloc<List<Carro>> {
  Future<List<Carro>> fetch(String tipo) async {
    try {
      bool network = await isNetworkOn();

      if (!network) {
        List<Carro> carros = await CarroDAO().findAllByTipo(tipo);
        add(carros);
        return carros;
      }

      List<Carro> carros = await CarrosApi.getCarros(tipo);

      add(carros);

      return carros;
    } catch (e) {
      addError(e);
    }
  }
}
