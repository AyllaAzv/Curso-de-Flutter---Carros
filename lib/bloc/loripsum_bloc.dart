import 'package:carros/bloc/simple_bloc.dart';
import 'package:carros/services/loripsum_api.dart';

class LoripsumBloc extends SimpleBloc<String> {
  static String lorim;

  fecth() async {
    String s = lorim ?? await LoripsumApi.getLoripsum();

    lorim = s;
    
    try {
      add(s);
    } catch (e) {
      addError(e);
    }
  }
}
