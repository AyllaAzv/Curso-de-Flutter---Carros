import 'package:carros/dao/base_dao.dart';
import 'package:carros/models/carro.dart';

class CarroDAO extends BaseDAO<Carro> {
  @override
  String get tableName => "carro";

  @override
  Carro fromMap(Map<String, dynamic> map) {
    return Carro.fromMap(map);
  }

  Future<List<Carro>> findAllByTipo(String tipo) {
    return query('select * from carro where tipo =? ', [tipo]);
  }
}
