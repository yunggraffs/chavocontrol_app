import 'package:chavocontrol_app/data/database/fake_data.dart';
import 'package:chavocontrol_app/models/movimiento.dart';

class ExpenseRepository {

  Future<List<Movimiento>> getAllMovimientos() async {
    return FakeData.kFrakeMovimientos;
  }

}