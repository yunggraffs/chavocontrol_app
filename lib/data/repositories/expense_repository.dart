import 'package:chavocontrol_app/data/database/fake_data.dart';
import 'package:chavocontrol_app/models/movimiento.dart';

class ExpenseRepository {
  // 1. Declaramos la dependencia
  final FakeData fakeDataSource;

  // 2. Requerimos la instancia en el constructor
  ExpenseRepository(this.fakeDataSource);

  Future<List<Movimiento>> getAllMovimientos() async {
    // 3. Accedemos a la data a través de la instancia recibida
    return FakeData.kFakeMovimientos;
  }
}